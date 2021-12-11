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
      render json: user_response(current_user), status: :created, location: @rent
    else
      render json: @rent.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rents/1
  def update
    quantity_diff = @rent.quantity - params[:quantity].to_i
    p "%"*500
    p params[:quantity]
    p "%"*500
    p params[:id]
    p "%"*500
    p rent_params
    p "%"*500
    p @rent
    p "%"*500


    if @rent.update(rent_params) && is_subscribed?
      p '@'*500
      p @rent
      p '@'*500

      update_game_rent_stock(quantity_diff)
 
      render json: user_response(current_user)
    else
      render json: @rent.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rents/1
  def destroy
    update_game_rent_stock(@rent.quantity)
    @rent.destroy if @rent.status == "wishlist"
    render json: user_response(current_user)
  end

  private
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
