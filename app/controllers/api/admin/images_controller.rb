class Api::Admin::ImagesController < ApplicationController
  before_action :authenticate_admin

  def create
    @game = Game.find(params[:id])
  end

  # DELETE /images/1
  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    render json: { messages: "L'image a bien été détruite"}
  end

  private
    # Only allow a list of trusted parameters through.
    def image_params
      params.permit(:game_id, :public_id)
    end
end
