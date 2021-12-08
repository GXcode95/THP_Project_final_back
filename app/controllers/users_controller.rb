class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
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
    
  end
end