class Api::Admin::RentsController < ApplicationController
  before_action :authenticate_admin

  def index
    @rents = order_all_rents()

    render json: @rents
  end

  def update
    @all_rents = Rent.all
    Rent.change_all_rents_status(@all_rents)
    @rents = order_all_rents()

    render json: @rents
  end

  private

  def order_all_rents
    @wishlist = Rent.where(status: "wishlist")
    @rented = Rent.where(status: "rented")
    @past_rentals = Rent.where(status: "past_rentals")
    
    return {
      wishlist: @wishlist,
      rented: @rented,
      pastRentals: @past_rentals
    }
  end
end
