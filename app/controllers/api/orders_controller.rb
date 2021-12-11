class Api::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:update, :destroy]
  

  # POST /orders
  def create
    @order = Order.new(order_params)
    
    if @order.save
      cart = set_current_cart()
      render json: cart, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      cart = set_current_cart()
      render json: cart
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    cart = set_current_cart()
    render json: cart
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def set_current_cart
      @current_cart = Cart.find_by( user_id: current_user.id, paid: false )
      
      @cart_games = []
      @cart_packages = []

      @current_cart.games.each do |game|
        @cart_games.push(Order.where(cart_id: @current_cart.id, game_id: game.id))
      end

      @current_cart.packages.each do |package|
        @cart_packages.push(Order.where(cart_id: @current_cart.id, package_id: package.id))
      end

      return cart = {
        current_cart: @current_cart,
        cart_games: @cart_games,
        cart_packages: @cart_packages
      }
    end

    def order_params
      params.permit(:cart_id, :package_id, :game_id, :quantity)
    end
end
