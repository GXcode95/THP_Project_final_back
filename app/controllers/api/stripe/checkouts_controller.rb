class Api::Stripe::CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def create


    @mode = params.require(:mode)
    
    if params[:line_items]
      @line_items_params = params.require(:line_items).permit(:price, :quantity)

      @line_items_array= [
        price: @line_items_params[:price],
        quantity: @line_items_params[:quantity]
      ]
    else
      @cart = Cart.find_by(user_id: current_user, paid: false)
      @total_price = @cart.total_price

      @line_items_array= [
        name: "Achat Playbox",
        unit_amount: @total_price,
        currency: "eur"
      ]
    end


    session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      success_url: ENV['SUCCESS_URL'],
      cancel_url: ENV['CANCEL_URL'],
      payment_method_types: ['card'],
      line_items: @line_items_array,
      mode: @mode
    })

    if session
      render json: { redirect_url: session[:url] }
    end
  end
end