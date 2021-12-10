class Api::CartsController < ApplicationController
  before_action :set_cart
  before_action :authenticate_user!
  
  def show
    render json: { cart: {
      current_cart: @cart,
      current_games: @cart.games,
      current_packages: @carte.packages
    }}
  end

  # PATCH/PUT /carts/1

  def update
    @cart.paid = true
    if @cart.update(cart_params)

      if (@cart.packages != nil)
        update_user_subscription()
      end

      @new_cart = Cart.create(user_id: current_user.id)
      render json: { new_cart: @new_cart, old_cart: @cart }
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  private

    def update_user_subscription
      @package = @cart.packages[0]
      @order = Order.find_by(package_id: @package.id, cart_id: @cart.id)
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
      params.permit(:user_id, :stripe_customer_id)
    end
end
