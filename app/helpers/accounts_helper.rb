module AccountsHelper

  def current_account
    Account.find(session[:account_id])
  end
  
end
