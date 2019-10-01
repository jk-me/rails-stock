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
    end
    @account = current_account
    @stock = Stock.new
  end

  def alphavantage
    # https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=MSFT&apikey=demo

  end

  private

  def account_params
    params.require(:account).permit(:name, :email, :password)
  end

end
