class Api::ChargesController < ApplicationController
  def create
    Stripe.api_key = ENV['SECRET_KEY']

    @cart = Cart.find_by(user_id: current_user, paid: false)
    @total_price = @cart.total_price

    charge = Stripe::Charge.create(
      :amount => 0,
      :description => 'Playbox Store',
      :currency => 'eur',
      :source => params[:id]
    )
    
    rescue Stripe::CardError => e
      render json: { error: e.message }
  end
end
