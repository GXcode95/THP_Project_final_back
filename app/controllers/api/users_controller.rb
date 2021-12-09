class Api::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    # Add user favorite and command history after MVP
    render json: user_response
  end

  def update
    @user= User.find(params[:id])
    
    if @user.update(user_params)
      render json: { userInfo: @user }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :phone, :address)
  end
end
