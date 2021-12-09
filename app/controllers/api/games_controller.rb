class Api::GamesController < ApplicationController
  # GET /games
  def index
    @games = Game.all
    game_response = {}

    @games.each do |game| 
      game_response["game#{game.id}"] = game
    end

    render json: game_response
  end

  # GET /games/1
  def show
    @game = Game.find(params[:id])
    
    render json: @game
  end
end