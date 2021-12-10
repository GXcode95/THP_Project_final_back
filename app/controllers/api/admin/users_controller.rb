class Api::Admin::UsersController < ApplicationController
  before_action :authenticate_admin

  def index
    @all_user = User.all

    render json: @all_user
  end
  
  def show
    @user = User.find(params[:id])

    render json: user_response(@user)
  end
end