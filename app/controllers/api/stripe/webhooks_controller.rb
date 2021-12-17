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
    p "#"*100
    p event.type
    p "#"*100

    case event.type
    when 'customer.subscription.updated', 'customer.subscription.deleted'
      subscription = event.data.object
      @user = User.find_by(stripe_customer_id: session.customer)
      @user.update(
        subscription_status: subscription.status,
        # plan: subscription.items.data[0].price.lookup_key,
      )
      p"$"*300
      p @user
      p"$"*300
    end
    render json: { message: 'success'}
  end
end