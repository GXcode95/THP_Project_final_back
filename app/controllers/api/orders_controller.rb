class Api::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_cart
  before_action :set_order, only: [:update, :destroy]
  

  # POST /orders
  def create
    @order = Order.new(order_params)
    
    if @order.save
      render json: setup_cart_response(@current_cart), status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: setup_cart_response(@current_cart)
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    render json: setup_cart_response(@current_cart)
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def set_current_cart
      @current_cart = Cart.find_by( user_id: current_user.id, paid: false )
    end

    def order_params
      params.permit(:cart_id, :package_id, :game_id, :quantity)
    end
end
