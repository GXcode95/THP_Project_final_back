class Api::CartsController < ApplicationController
  before_action :set_cart, only: [:show]
  before_action :authenticate_user!
  
   def index
    render json: user_cart_history()
  end
  
  def show
    render json: setup_cart_response(@cart)
  end
  
  private

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

    def set_cart
      @cart = Cart.find(params[:id])
    end

    def cart_params
      params.permit(:user_id, :stripe_customer_id, :package_id, :quantity)
    end
end
