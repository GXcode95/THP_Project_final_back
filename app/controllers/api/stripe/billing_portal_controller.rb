class Api::Stripe::BillingPortalController < ApplicationController
  def create
    portal_session = Stripe::BillingPortal::Session.create({
      customer: current_user.stripe_customer_id,
      return_url: ENV['SUCCESS_URL']
    })

    if portal_session
      render json: { redirect_url: portal_session[:url]}
    end
  end
end