class Admin::RentsController < ApplicationController
  before_action :authenticate_admin

  def index
    @rents = Rent.all

    render json: @rents
  end
end
