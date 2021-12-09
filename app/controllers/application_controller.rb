class ApplicationController < ActionController::API
  def user_response (user)
    @wish_list = Rent.where( user_id: user.id, status: 0 )
    @rent_games = Rent.where( user_id: user.id, status: 1 )
    @rented_games = Rent.where( user_id: user.id, status: 2 )
    @cart = Cart.where( user_id: user.id)
    
    return { 
      userInfo: user, 
      rentedGames: @rented_games,
      rentGames: @rent_games,
      wishList: @wish_list,
      cart: @cart 
    }
  end

  def authenticate_admin
    redirect_to new_user_session_path unless current_user && current_user.admin
  end
end
