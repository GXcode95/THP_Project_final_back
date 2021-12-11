class Api::GamesController < ApplicationController
  # GET /games
  def index
    render json: get_all_games()
  end

  # GET /games/1
  def show
    @game = Game.find(params[:id])
    
    render json: @game
  end

  private

  def get_all_games
    @all_games = Game.all

    return @all_games.map { |game| { game: game, images: game.images } }
  end
end