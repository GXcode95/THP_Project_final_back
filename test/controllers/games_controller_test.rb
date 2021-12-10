require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game = games(:one)
  end

  test "should get index" do
    get games_url, as: :json
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post games_url, params: { game: { creator: @game.creator, description: @game.description, editor: @game.editor, max_player: @game.max_player, min_age: @game.min_age, min_player: @game.min_player, name: @game.name, price: @game.price, release_date: @game.release_date, rent_stock: @game.rent_stock, sell_stock: @game.sell_stock } }, as: :json
    end

    assert_response 201
  end

  test "should show game" do
    get game_url(@game), as: :json
    assert_response :success
  end

  test "should update game" do
    patch game_url(@game), params: { game: { creator: @game.creator, description: @game.description, editor: @game.editor, max_player: @game.max_player, min_age: @game.min_age, min_player: @game.min_player, name: @game.name, price: @game.price, release_date: @game.release_date, rent_stock: @game.rent_stock, sell_stock: @game.sell_stock } }, as: :json
    assert_response 200
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete game_url(@game), as: :json
    end

    assert_response 204
  end
end
