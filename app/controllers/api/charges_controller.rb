class Api::ChargesController < ApplicationController
  before_action :authenticate_user!

  def create
    Stripe.api_key = ENV['SECRET_KEY']
    
    @cart = Cart.find_by(user_id: current_user.id, paid: false)
    @total_price = @cart.total_price
    
    charge = Stripe::Charge.create(
      :amount => @total_price*100,
      :description => 'Playbox Store',
      :currency => 'eur',
      :source => params[:id]
    )

    render json: { charge: charge } if charge.paid

    rescue => e
      error = e.message

    return generate_response(error)
  end

  def generate_response(error = nil)
    render json: { error: error} if error
  end
end
