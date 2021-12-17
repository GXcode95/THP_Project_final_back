class Api::Stripe::BillingPortalController < ApplicationController
  def create
    portal_session = Stripe::BillingPortal::Session.create({
      customer: 
      return_url: ENV['SUCCESS_URL']
    })

    
  end
end