class Api::Stripe::PricesController < ApplicationController
  def update

    price = Stripe::Price.create({
      unit_amount: 1000,
      currency: 'eur',
      recurring: {interval: 'month'},
      product: 'prod_KlKuL9XvKJtv7y',
    })
    if price
      p "#"*300
      p price
      p "#"*300
      render json: price
    end
  end
end