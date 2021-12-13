class Api::GamesController < ApplicationController
  
  def index
    render json: get_all_games()
  end

  
  def show
    @game = Game.find(params[:id])
    
    render json: { info: @game, images: @game.images, rank: @game.get_global_rank(), tags: @game.tags, comments: @game.comments }
  end

  private

  def get_all_games
    @all_games = Game.all

    return @all_games.map { |game| { info: @game, images: @game.images, rank: @game.get_global_rank(), tags: @game.tags } }
  end

end