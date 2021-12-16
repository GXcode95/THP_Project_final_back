class Api::CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  before_action :authenticate_user!
  
  # POST /comments
  def create
    @comment = Comment.new(user_id: current_user.id, game_id: params[:game_id], content: params[:content])

    if @comment.save
      @game = @comment.game
      render json: { info: @game, images: get_game_public_id(@game), rank: @game.get_global_rank(), tags: @game.tags, comments: @game.comments }
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      @game = @comment.game
      render json: { info: @game, images: get_game_public_id(@game), rank: @game.get_global_rank(), tags: @game.tags, comments: @game.comments }
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @game = @comment.game
    @comment.destroy
    render json: { info: @game, images: get_game_public_id(@game), rank: @game.get_global_rank(), tags: @game.tags, comments: @game.comments }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.permit(:user_id, :game_id, :content)
    end
end
