class Api::FavoritesController < ApplicationController
  before_action :set_game, only: [:destroy]
  before_action :authenticate_user!

  def index
    render json: favorites_games(current_user)
  end

  # POST /favorites
  def create
    @favorite = Favorite.new(favorite_params)

    if @favorite.save
      render json: favorites_games(current_user)
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  # DELETE /favorites/1
  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, game_id: @game.id)
    @favorite.destroy
    render json: favorites_games(current_user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favorite_params
      params.permit(:user_id, :game_id)
    end
end
