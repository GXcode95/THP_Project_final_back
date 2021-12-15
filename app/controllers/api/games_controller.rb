class Api::GamesController < ApplicationController

  def index
    render json: get_all_games()
  end

  
  def show
    @game = Game.find(params[:id])
    if current_user 
      render json: { info: @game, images: get_game_public_id(@game), rank: @game.get_global_rank(), tags: @game.tags, comments: @game.comments, isRanked: is_ranked(@game, current_user) }
    else
       render json: { info: @game, images: get_game_public_id(@game), rank: @game.get_global_rank(), tags: @game.tags, comments: @game.comments, isRanked: nil }
    end
  end

  def is_ranked(game,user)
    if Rank.find_by(game_id: game.id, user_id: user.id) 
      return true 
    else 
      return false
    end
  end
  
end