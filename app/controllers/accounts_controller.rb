class AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token, only:[:alpharesp]
  def new #register new account
    @account = Account.new
  end

  def create #post action from register form
    @account = Account.create(account_params)
    if @account.valid?
      session[:account_id] = @account.id
      redirect_to account_path(@account)
    else
      render :new
    end
  end

  def show
    # @account = Account.find(params[:id])
    if !session[:account_id]
      redirect_to new_session_path
      return
    end
    if params[:id] != current_account.id.to_s
      flash[:error]="You may not access another user's data"
      redirect_to account_path(current_account)
      return
    end
    @account = current_account
    respond_to do |f|
      f.html {render :show}
      f.json {render json: @account}
    end
  end

  def alphavantage
    # https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=MSFT&apikey=demo
    @account = current_account
    resp = Faraday.get 'https://www.alphavantage.co/query' do |req|
      req.params['function'] = 'GLOBAL_QUOTE'
      req.params['symbol'] = params[:symbol]
      req.params['apikey'] = Rails.application.credentials.alphav
    end
    body = JSON.parse(resp.body)

    if body['Error Message']
      flash[:error] = 'Invalid Ticker Symbol'
      redirect_to account_path(@account)
      return
    end

    stock = body['Global Quote']
    price = stock['05. price']
    if @account.balance.to_f > (price.to_f * params[:shares].to_f)
      s = Stock.where(account_id: @account.id).find_or_create_by(symbol: params[:symbol].upcase)
      s.shares = s.shares ? s.shares += params[:shares].to_i : params[:shares].to_i
      s.save

      t = Transaction.create({account_id: @account.id, symbol:params[:symbol].upcase, shares:params[:shares], price:price})

      @account.balance = @account.balance.to_f - (price.to_f * params[:shares].to_f)
      @account.save
    end
    redirect_to account_path(@account)
  end

  def alpharesp
    # @account = current_account
    # byebug
    resp = Faraday.get 'https://www.alphavantage.co/query' do |req|
      req.params['function'] = 'GLOBAL_QUOTE'
      req.params['symbol'] = params[:symbol]
      req.params['apikey'] = Rails.application.credentials.alphav
    end
    body = JSON.parse(resp.body)
    render json: body
  end

  def stocks
    if !session[:account_id]
      redirect_to new_session_path
      return
    end
    account = current_account
    stocks = account.stocks
    render json: stocks
  end

  private

  def account_params
    params.require(:account).permit(:name, :email, :password)
  end

end
