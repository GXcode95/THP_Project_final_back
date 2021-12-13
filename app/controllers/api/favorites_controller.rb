class Api::FavoritesController < ApplicationController
  before_action :set_favorite, only: [:destroy]
  before_action :authenticate_user!

  # POST /favorites
  def create
    @favorite = Favorite.new(favorite_params)

    if @favorite.save
      render json: current_user.favorites_games
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  # DELETE /favorites/1
  def destroy
    @favorite.destroy
    render json: current_user.favorites_games
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favorite_params
      params.permit(:user_id, :game_id)
    end
end
