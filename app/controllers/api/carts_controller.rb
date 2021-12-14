class Api::CartsController < ApplicationController
  before_action :set_cart, only: [:show]
  before_action :authenticate_user!
  
   def index
    render json: user_cart_history()
  end
  
  def show
    render json: { cart: setup_cart_response(@cart) }
  end
  
  private
    def set_cart
      @cart = Cart.find(params[:id])
    end

    def cart_params
      params.permit(:user_id, :stripe_customer_id, :package_id, :quantity)
    end
end
