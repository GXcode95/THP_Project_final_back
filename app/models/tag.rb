class Tag < ApplicationRecord
    has_many :join_game_and_tags
    has_many :games, through: :join_game_and_tags
end
