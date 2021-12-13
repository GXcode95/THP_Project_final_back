class Api::Admin::PackagesController < ApplicationController
  before_action :set_package, only: [:update]

  def index
    @packages = Package.all

    render json: @packages
  end

  def update
    if @package.update(package_params)
      render json: @package
    else
      render json: @package.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      @package = Package.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def package_params
      params.require(:package).permit(:game_number, :name, :price)
    end
end
