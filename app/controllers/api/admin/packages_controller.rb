class Api::Admin::PackagesController < ApplicationController
  before_action :set_package
  before_action :authenticate_admin

  def update
    if @package.update(package_params)
      render json: @package
    else
      render json: @package.errors, status: :unprocessable_entity
    end
  end

  private
 
    def set_package
      @package = Package.find(params[:id])
    end

    def package_params
      params.permit(:game_number, :name, :price, :description)
    end
end
