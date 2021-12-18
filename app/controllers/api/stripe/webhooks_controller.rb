class Api::Stripe::WebhooksController < ApplicationController
  skip_before_action :authenticate_user!, raise: false
  skip_before_action :verify_authenticate_token, raise: false

  def create
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, ENV["END_POINT_SK"]
      )
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      puts "Signature error"
      p e
      return
    end

    p "$"*300
    p event.type
    p "$"*300

    case event.type 

    when 'checkout.session.completed'
      session = event.data.object
      @user = User.find_by(stripe_customer_id: session.customer)
      @cart = Cart.find_by(user_id: @user.id, paid: false)
      
      if session.payment_status == "paid"
        @cart.update(paid: true, session_id: session.id)

        @cart.games.each do |game|
          game_order = Order.find_by(cart_id: @cart.id, game_id: game.id)
          game_sell_stock_update(game, game_order.quantity)
        end

        Cart.create(user_id: @user.id)
      end

    when 'customer.subscription.updated', 'customer.subscription.deleted'
      subscription = event.data.object

      @user = User.find_by(stripe_customer_id: subscription.customer)
      @package = Package.find_by(price_id: subscription.plan.id)
      @user.update(subscription_status: subscription.status, package_id: @package.id)
    end

    render json: { message: 'success'}
  end

  private
  
  def game_sell_stock_update(game, quantity)
    sell_stock = game.sell_stock
    game.update(sell_stock: sell_stock - quantity)
  end
end