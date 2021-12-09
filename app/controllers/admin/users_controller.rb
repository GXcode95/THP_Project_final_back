class Admin::UsersController < ApplicationController
  before_action :authenticate_admin

  def index
    @all_user = User.all

    render json: @all_user
  end
  
  def show
    render json: user_response
  end
end
