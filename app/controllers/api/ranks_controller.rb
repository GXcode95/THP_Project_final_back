class Api::RanksController < ApplicationController
  before_action :authenticate_user!

  def create
    @rank = Rank.new(rank_params)
    
    if @rank.save
      redirect_to game_path(@rank.game)
    else
      render json: @rank.errors, status: :unprocessable_entity
    end
  end

  private
  
    # Only allow a list of trusted parameters through.
    def rank_params
      params.permit(:game_id, :user_id, :note)
    end
end
