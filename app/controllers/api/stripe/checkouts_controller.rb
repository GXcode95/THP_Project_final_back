class Api::Stripe::CheckoutsController < ApplicationController
  def create

    @line_items_params = params.require(:line_items).permit(:name, :amount, :currency, :price, :quantity)
    @mode = params.require(:mode)

    if @line_items_params[:currency]
      @line_items_array= [
        name: @line_items_params[:name],
        unit_amount: @line_items_params[:amount],
        currency: @line_items_params[:currency]
      ]
    else
      @line_items_array= [
        price: @line_items_params[:price],
        quantity: @line_items_params[:quantity]
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