class TransactionsController < ApplicationController

  def index
    if !session[:account_id]
      redirect_to new_session_path
      return
    end
    if params[:account_id]
      @transactions = current_account.transactions
      respond_to do |f|
        f.html {render :transactions}
        f.json {render json: @transactions}
      end
    end
  end

end
