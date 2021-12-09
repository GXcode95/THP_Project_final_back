class Api::RentsController < ApplicationController
  before_action :set_rent, only: [:update, :destroy]
  before_action :authenticate_user!

  # GET /rents
  def index
    render json: set_rents()
  end


  # POST /rents
  def create
    @rent = Rent.new(rent_params)

    if @rent.save && is_subscribed?
      render json: set_rents, status: :created, location: @rent
    else
      render json: @rent.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rents/1
  def update
    if @rent.update(rent_params) && is_subscribed?
      render json: set_rents
    else
      render json: @rent.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rents/1
  def destroy
    @rent.destroy if @rent.status == "wishlist"
    render json: set_rents
  end

  private

    def set_rents
      @wishlist = Rent.where(user_id: current_user.id, status: "wishlist")
      @rented = Rent.where(user_id: current_user.id, status: "rented")
      @past_rentals = Rent.where(user_id: current_user.id, status: "past_rentals")

      return {
        wishlist: @wishlist,
        rented: @rented,
        pastRentals: @past_rentals
      }
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_rent
      @rent = Rent.find(params[:id])
    end

    def is_subscribed?
      current_user.subscription_ending > Date.today
    end

    # Only allow a list of trusted parameters through.
    def rent_params
      params.permit(:quantity, :user_id, :game_id)
    end
end
