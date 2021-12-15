class Api::UsersController < ApplicationController
  before_action :authenticate_user! , only: [:update]
  before_action :set_user
  
  def show
    # Add user favorite and command history after MVP
    render json: user_response(@user)
  end

  def update
    if @user.update(user_params)
      render json: { userInfo: @user }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :phone, :address)
  end
end
