class Tag < ApplicationRecord
    validates :name, uniqueness: true, length: { maximum: 15 }

    has_many :join_game_and_tags
    has_many :games, through: :join_game_and_tags
end
