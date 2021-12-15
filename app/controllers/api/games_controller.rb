class Api::GamesController < ApplicationController
  
  def index
    render json: get_all_games()
  end

  
  def show
    @game = Game.find(params[:id])
    
    render json: { info: @game, images: get_game_public_id(@game), rank: @game.get_global_rank(), tags: @game.tags, comments: @game.comments }
  end
  
end