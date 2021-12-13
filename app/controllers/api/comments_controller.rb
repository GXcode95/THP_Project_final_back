class Api::CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  before_action :authenticate_user!
  
  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to game_path(@comment.game)
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to game_path(@comment.game)
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @game = @comment.game
    @comment.destroy
    redirect_to game_path(@game)
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
