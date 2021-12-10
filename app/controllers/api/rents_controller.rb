class Api::RentsController < ApplicationController
  before_action :set_rent, only: [:update, :destroy]
  before_action :set_game, only: [:update, :destroy]
  before_action :authenticate_user!

  # GET /rents
  def index
    render json: set_rents()
  end


  # POST /rents
  def create
    @rent = Rent.new(rent_params)
    set_game()
    
    if @rent.save && is_subscribed?
      update_game_rent_stock(-@rent.quantity)
      render json: set_rents(), status: :created, location: @rent
    else
      render json: @rent.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rents/1
  def update
    
    quantity_diff = @rent.quantity - params[:quantity].to_i

    if @rent.update(rent_params) && is_subscribed?
      update_game_rent_stock(quantity_diff)
 
      render json: set_rents()
    else
      render json: @rent.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rents/1
  def destroy
    update_game_rent_stock(@rent.quantity)
    @rent.destroy if @rent.status == "wishlist"
    render json: set_rents()
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

    def set_game
      @game = Game.find_by(id: @rent.game_id)
    end

    def is_subscribed?
      current_user.subscription_ending > Date.today
    end

    def update_game_rent_stock(quantity)
      @rent_stock = @game.rent_stock
      @game.update(rent_stock: (@rent_stock + quantity))
    end
    # Only allow a list of trusted parameters through.
    def rent_params
      params.permit(:quantity, :user_id, :game_id)
    end
end
