class Api::Admin::TagsController < ApplicationController
  before_action :set_tag, only: [:update, :destroy]
  before_action :authenticate_admin

  # POST /tags
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      @tags = Tag.all
      render json: @tags, status: :created
    else
      render json: { error: @tag.errors }
    end
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      @tags = Tag.all
      render json: @tags
    else
      render json: { error: @tag.errors }
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
    @tags = Tag.all
    render json: @tags
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.permit(:name)
    end
end
