class ApplicationController < ActionController::Base

  def root

  end

  def current_account
    Account.find(session[:account_id])
  end

end
