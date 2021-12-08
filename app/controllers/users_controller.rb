class UsersController < ApplicationController
  before_action :set_user
  
  def show
    @wish_list = Rent.where({ user_id: @user.id, status: 1 })
    @rent_games = Rent.where({ user_id: @user.id, status: 2 })
    @rented_games = Rent.where({ user_id: @user.id, status: 3 })
    @cart = Cart.where({user_id: @user.id})

    # Add user favorite and command history after MVP

    render json:  { 
                    userInfo: @user, 
                    rentedGames: @rented_games,
                    rentGames: @rent_games,
                    wishList: @wish_list,
                    cart: @cart 
                  }
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
    @user= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email , :last_name, :first_name, :phone, :address)
  end
end