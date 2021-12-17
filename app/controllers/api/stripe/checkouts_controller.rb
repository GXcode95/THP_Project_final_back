class Api::Stripe::CheckoutsController < ApplicationController
  def create
    p "#"*300
    p params
    p "#"*300

    session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      success_url: ENV['SUCCESS_URL'],
      cancel_url: ENV['CANCEL_URL'],
      payment_method_types: ['card'],
      line_items: [
        {price: 'price_1K5oEgDzWhv05aHOikcoWFCf', quantity: 1}
      ],
      mode: 'subscription'
    })

    if session
      p "%"*300
      p session[:url]
      p "%"*300
      render json: { redirect_url: session[:url]}
    end
  end
end
