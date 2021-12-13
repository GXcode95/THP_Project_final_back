class Api::RanksController < ApplicationController
  before_action :authenticate_user!

  def create
    @rank = Rank.new(rank_params)
    
    if @rank.save
      @game = @rank.game
      render json: { info: @game, images: @game.images, rank: @game.get_global_rank(), tags: @game.tags, comments: @game.comments }
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
