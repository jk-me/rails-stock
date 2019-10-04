class SessionsController < ApplicationController
  def new
    @account = Account.new
  end

  def create
    @account = Account.find_by(email: sess_params[:email])
    # byebug
    if @account
      if @account.authenticate(sess_params[:password])
        session[:account_id] = @account.id
        redirect_to account_path(@account)
      else
        flash[:error] = 'Wrong accountname or password.'
        redirect_to new_session_path
      end
    else
      flash[:error] = 'Wrong accountname or password.'
      redirect_to new_session_path
    end
  end

  def logout
    session.delete(:account_id)
    redirect_to new_account_path
  end

  private

  def sess_params
    params.require(:account).permit(:email, :password)
  end

end
