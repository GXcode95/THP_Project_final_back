class Game < ApplicationRecord
    has_many :join_game_and_tags
    has_many :tags, through: :join_game_and_tags
end
