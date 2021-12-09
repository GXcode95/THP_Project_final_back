class ApplicationController < ActionController::API
  def user_response
    current_user ? @user = current_user : @user = User.find(params[:id])
    @wish_list = Rent.where( user_id: @user.id, status: 0 )
    @rent_games = Rent.where( user_id: @user.id, status: 1 )
    @rented_games = Rent.where( user_id: @user.id, status: 2 )
    @cart = Cart.where( user_id: @user.id)
    
    return { 
      userInfo: @user, 
      rentedGames: @rented_games,
      rentGames: @rent_games,
      wishList: @wish_list,
      cart: @cart 
    }
  end
end
