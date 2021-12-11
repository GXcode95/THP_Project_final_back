class ApplicationController < ActionController::API
  def user_response (user)
    @wish_list = Rent.where( user_id: user.id, status: "wishlist" )
    @rent_games = Rent.where( user_id: user.id, status: "rented" )
    @rented_games = Rent.where( user_id: user.id, status: "past_rentals" )
    @current_cart = Cart.find_by( user_id: user.id, paid: false )
    @current_cart = Cart.create(user_id: user.id) if @current_cart == nil
    @cart_games = []
    @cart_packages = []

    @current_cart.games.each do |game|
      @cart_games.push({
        game: game,
        quantity: Order.find_by(cart_id: @current_cart.id, game_id: game.id).quantity
      })
    end

    @current_cart.games.each do |package|
      @cart_packages.push({
        package: package,
        quantity: Order.find_by(cart_id: @current_cart.id, package_id: package.id).quantity
      })
    end

    cart = {
      current_cart: @current_cart,
      cart_games: @cart_games,
      cart_packages: @cart_packages
    }

    return { 
      user_info: user, 
      rented_games: @rented_games,
      rent_games: @rent_games,
      wishlist: @wish_list,
      cart: cart
    }
  end

  def authenticate_admin
    redirect_to new_user_session_path unless current_user && current_user.admin
  end
end
