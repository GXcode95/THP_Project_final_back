class Api::CartsController < ApplicationController
  before_action :set_cart, only: [:show, :update]
  before_action :authenticate_user!
  
  def show
    render json: { cart: user_response(current_user)[:cart] }
  end

  def index
    render json: { cartHistory: user_cart_history() }
  end
  
  def package_update
    if @cart.create(user_id: current_user.id, paid: true, stripe_customer_id: params[:stripe_customer_id])
      @package = Package.find_by(id: params[:package_id].to_i)
      @order = Order.create(package_id: @package.id, cart_id: @cart.id, quantity: params[:quantity].to_i)

      update_user_subscription()

      render json: { message: "Susbscibed !", packageCart: @cart }
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end  

  # PATCH/PUT /carts/1

  def update
    if @cart.update(paid: true, stripe_customer_id: params[:stripe_customer_id])
      @new_cart = Cart.create(user_id: current_user.id)
      render json: { new_cart: @new_cart, old_cart: @cart }
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  private

    def user_cart_history()
      return Cart.where(user_id: current_user.id, paid: false)
    end

    def update_user_subscription
      @subscription_ending = set_user_subscription_ending(@order.quantity)

      current_user.update(package_id: @package.id, subscription_ending: @subscription_ending) 
    end  

    def set_user_subscription_ending(quantity)
      now = Time.now.to_date
      month_total = now.mon + quantity
      if (month_total > 12)
        sub_end_mon = month_total % 12
        sub_end_mon = 12 if sub_end_month == 0 # prevent to have a month '0'
        sub_end_year = now.year + (1 * month_total / 12)
      else
        sub_end_mon = month_total
        sub_end_year = now.year
      end
      return Date.new(sub_end_year, sub_end_mon, 1)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.permit(:user_id, :stripe_customer_id, :package_id, :quantity)
    end
end
