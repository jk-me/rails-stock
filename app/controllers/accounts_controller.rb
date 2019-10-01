class AccountsController < ApplicationController

  def new #register new account
    @account = Account.new
  end

  def create #post action from register form
    @account = Account.create(account_params)
    if @account.valid?
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
    end
    @account = current_account
  end

  def alphavantage
    # https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=MSFT&apikey=demo
    @account = current_account
    resp = Faraday.get "https://www.alphavantage.co/query" do |req|
      req.params["function"] = "GLOBAL_QUOTE"
      req.params["symbol"] = params[:symbol]
      req.params["apikey"] = Rails.application.credentials.alphav #remove key
    end
    body = JSON.parse(resp.body)

    stock = body["Global Quote"]
    price = stock["05. price"]
    if @account.balance.to_f > (price.to_f * params[:shares].to_f)
      s = Stock.where(account_id: @account.id).find_or_create_by(symbol: params[:symbol])
      s.shares = s.shares ? s.shares += params[:shares].to_i : params[:shares].to_i
      s.save
      @account.balance = @account.balance.to_f - (price.to_f * params[:shares].to_f)
      @account.save
    end
    redirect_to account_path(current_account)
  end

  private

  def account_params
    params.require(:account).permit(:name, :email, :password)
  end

end
