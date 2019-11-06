class StocksController < ApplicationController

  def index
    if !session[:account_id]
      redirect_to new_session_path
      return
    end
    if params[:account_id]
      stocks = current_account.stocks
      render json: stocks
    end
  end

end
