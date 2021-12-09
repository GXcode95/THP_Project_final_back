class Api::Admin::ImagesController < ApplicationController
  before_action :authenticate_admin

  # POST /images
  def create
    @image = Image.new(image_params)

    if @image.save
      render json: @image, status: :created, location: @image
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /images/1
  def destroy
    @image = Image.find(params[:id])
    @image.destroy
  end

  private
    # Only allow a list of trusted parameters through.
    def image_params
      params.permit(:game_id, :public_id)
    end
end
