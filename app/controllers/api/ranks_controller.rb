class Api::RanksController < ApplicationController
  before_action :authenticate_user!

  def create
    @rank = Rank.new(game_id: params[:game_id].to_i, user_id: current_user.id, note: params[:note].to_i)
    
    if @rank.save
      @game = @rank.game
      render json: { info: @game, images: get_game_public_id(@game), rank: @game.get_global_rank(), tags: @game.tags, comments: @game.comments, is_ranked: true }
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
