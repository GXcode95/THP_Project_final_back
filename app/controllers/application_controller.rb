class ApplicationController < ActionController::API
  def user_response (user)
    @wish_list = Rent.where( user_id: user.id, status: 0 )
    @rent_games = Rent.where( user_id: user.id, status: 1 )
    @rented_games = Rent.where( user_id: user.id, status: 2 )
    @current_cart = Cart.find_by( user_id: user.id, paid: false )
    @current_cart = Cart.create(user_id: user.id) if @current_cart == nil
    cart = {
      currentCart: @current_cart,
      cartGames: @current_cart.games
      cartPackages: @current_cart.packages
    }
    return { 
      userInfo: user, 
      rentedGames: @rented_games,
      rentGames: @rent_games,
      wishList: @wish_list,
      cart: cart
    }
  end

  def authenticate_admin
    redirect_to new_user_session_path unless current_user && current_user.admin
  end
end
