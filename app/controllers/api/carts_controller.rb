class Api::CartsController < ApplicationController
  before_action :set_cart
  before_action :authenticate_user!

  # PATCH/PUT /carts/1
  def update
    if @cart.update(cart_params, paid: true)
      @new_cart = Cart.create(user_id: current_user.id)
      render json: { new_cart: @new_cart, old_cart: @cart }
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.permit(:user_id, :stripe_customer_id)
    end
end
