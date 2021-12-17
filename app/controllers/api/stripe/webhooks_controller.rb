class Api::Stripe::WebhooksController < ApplicationController
  skip_before_action :authenticate_user!, raise: false
  skip_before_action :verify_authenticate_token, raise: false

  def create
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    event = nil
    p "LALALLAL"*100
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
    p "POPPPOPOPOPOPOPOPOP"*100
    p event.type
    p "POPPPOPOPOPOPOPOPOP"*100

    case event.type
    when 'chekout.session.completed'
      session = event.data.object
      @user = User.find_by(stripe_customer_id: session.customer)
      @user.update(subscription_status: 'active')
      p "#"*300
      p session
      p "#"*300
      p session.customer
      p "#"*300
      p @user.id
      p "#"*300
      p @user.errors
      p "#"*300
    when 'custome.subscription.updated', 'customer.subscription.deleted'
      subscription = event.data.object
      @user = User.find_by(stripe_customer_id: session.customer)
      @user.update(
        subscription_status: subscription.status,
        # plan: subscription.items.data[0].price.lookup_key,
      )
    end
    render json: { message: 'success'}
  end
end