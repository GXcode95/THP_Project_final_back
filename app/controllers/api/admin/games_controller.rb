class Api::Admin::GamesController < ApplicationController
  before_action :set_game, only: [:update, :destroy]
  before_action :authenticate_admin

  # GET /games
  def index
    @games = Game.all

    render json: get_all_games()
  end

  # POST /games
  def create
    @game = Game.new(game_params)

    if @game.save
      params[:images].each do |image|
        Image.create(game_id: @game.id, public_id: image)
      end
      render json: get_all_games(), status: :created, location: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      render json: get_all_games()
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    render json: get_all_games()
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:name, :price, :creator, :editor, :description, :min_player, :max_player, :min_age, :release_date, :sell_stock, :rent_stock)
    end
end
