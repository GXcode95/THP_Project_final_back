class ApplicationController < ActionController::API
  def user_response (user)
    @wish_lists_list = Rent.where( user_id: user.id, status: "wishlist" )
    @rent_games_list = Rent.where( user_id: user.id, status: "rented" )
    @rented_games_list = Rent.where( user_id: user.id, status: "past_rentals" )
    @current_cart = Cart.create(user_id: user.id) if @current_cart == nil
    @current_cart = Cart.find_by( user_id: user.id, paid: false )
    
    @wish_list = format_response(@wish_lists_list)
    @rent_games = format_response(@rent_games_list)
    @rented_games = format_response(@rented_games_list)
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

  def format_response (list)
    formated_list = []
    p list

    list.each do |item|
      formated_list.push({
        game: item.game,
        quantity: item.quantity
      })
    end
    
    formated_list
  end

  def authenticate_admin
    redirect_to new_user_session_path unless current_user && current_user.admin
  end
end
