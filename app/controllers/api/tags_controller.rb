class Api::TagsController < ApplicationController
  before_action :set_tag, only: [:update, :destroy]

  def index
    @tags = Tag.all

    render json: @tags
  end
end
