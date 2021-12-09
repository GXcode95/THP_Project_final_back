class Api::GamesController < ApplicationController
  # GET /games
  def index
    @games = Game.all

    render json: @games
  end

  # GET /games/1
  def show
    @game = Game.find(params[:id])
    
    render json: @game
  end
end