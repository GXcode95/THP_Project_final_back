class Api::ChargesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    containPackage = params[:package][:presence]

    if containPackage
      @total_price = Package.find_by(id: params[:package][:package_id]).price * params[:package][:quantity]
    else
      @cart = Cart.find_by(user_id: current_user, paid: false)
      @total_price = @cart.total_price
    end
    
    charge = Stripe::Charge.create(
      :amount => 1000,
      :description => 'Playbox Store',
      :currency => 'eur',
      :source => params[:token][:id]
    )

    if charge.paid && containPackage
      package_update(charge)
      render json: current_user
    elsif charge.paid
      if @cart.update(paid: true, stripe_customer_id: charge.id)

        @cart.games.each do |game|
          game_order = Order.find_by(cart_id: @cart.id, game_id: game.id)
          game_sell_stock_update(game, game_order.quantity)
        end

        @new_cart = Cart.create(user_id: current_user.id)
        render json: { cart: @new_cart, command_history: user_cart_history() }
      else
        render json: @cart.errors, status: :unprocessable_entity
      end
    end

    rescue => e
      render json: { error: e.message }
  end

  private
  
  def package_update (charge)
    @cart = Cart.create(user_id: current_user, paid: true, stripe_customer_id: charge.id)

    if @cart
      @package = Package.find_by(id: params[:package][:package_id].to_i)
      @order = Order.create(package_id: @package.id, cart_id: @cart.id, quantity: params[:package][:quantity].to_i)

      update_user_subscription()
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def update_user_subscription
    @subscription_ending = set_user_subscription_ending(@order.quantity)

    current_user.update(package_id: @package.id, subscription_ending: @subscription_ending) 
  end  

  def set_user_subscription_ending(quantity)
    if  current_user.subscription_ending
      current_date = current_user.subscription_ending
    else
      current_date = Time.now.to_date
    end

    month_total = current_date.mon + quantity

    if (month_total > 12)
      sub_end_month = month_total % 12
      sub_end_month = 12 if sub_end_month == 0 # prevent to have a month '0'
      sub_end_year = current_date.year + (1 * month_total / 12)
    else
      sub_end_month = month_total
      sub_end_year = current_date.year
    end
    return Date.new(sub_end_year, sub_end_month, 1)
  end

  def game_sell_stock_update(game, quantity)
    sell_stock = game.sell_stock
    game.update(sell_stock: sell_stock - quantity)
  end
end
