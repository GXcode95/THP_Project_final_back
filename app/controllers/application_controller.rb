class ApplicationController < ActionController::API

  def authenticate_admin
    redirect_to new_user_session_path unless current_user && current_user.admin
  end

  def user_response(user)
    @current_cart = Cart.find_by(user_id: user.id, paid: false)
    @current_cart = Cart.create(user_id: user.id) if @current_cart == nil
  
    return { 
      user_info: user,
      rent: setup_rent_response(user),
      cart: setup_cart_response(@current_cart),
      favorites: user.favorites_games
    }
  end

  def setup_rent_response(user)
    @wish_list = Rent.where(user_id: user.id, status: "wishlist")
    @rent_games = Rent.where(user_id: user.id, status: "rented")
    @rented_games = Rent.where(user_id: user.id, status: "past_rentals")
    return {
      rented_games: format_rent_response(@rented_games),
      rent_games: format_rent_response(@rent_games),
      wishlist: format_rent_response(@wish_list)
    }
  end

  def user_cart_history()
    @carts = Cart.where(user_id: current_user.id, paid: true)
    @formatedCart = []
    @cart_games = []
    @cart_package = []

    @carts.each do |cart|
      cart.games.each do |game|
        @cart_games.push({game: game, quantity: Order.find_by(game_id: game.id, cart_id: cart.id).quantity})
      end

      cart.packages.each do |package|
        @cart_packages.push({package: package, quantity: Order.find_by(package_id: package.id, cart_id: cart.id).quantity})
      end

      @formatedCart.push({
        cart: cart,
        cart_games: @cart_games,
        cart_packages: @cart_packages,
        cart_price: cart.total_price
      })
    end

    @formatedCart
  end

  def format_rent_response(list)
    formated_list = []

    list.each do |item|
      formated_list.push({
        game: item.game,
        quantity: item.quantity,
        rent_id: item.id
      })
    end
    
    return formated_list
  end

  def setup_cart_response (cart)
    @cart_games = []

    cart.games.each do |game|
      game_order = Order.find_by(cart_id: cart.id, game_id: game.id)
      
      @cart_games.push({
        game: game,
        quantity: game_order.quantity,
        order_id: game_order.id
      })
    end
    
    return {
      current_cart: cart,
      cart_games: @cart_games
    }
  end

  def get_all_games
    @all_games = Game.all

    return @all_games.map { |game| { info: game, images: game.images, rank: game.get_global_rank(), tags: game.tags } }
  end

end
