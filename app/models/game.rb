class Game < ApplicationRecord
    validates :name, presence: true
    validates :price, presence: true
    validates :creator, presence: true
    validates :editor, presence: true
    validates :description, presence: true
    validates :min_player, presence: true
    validates :sell_stock, presence: true
    validates :rent_stock, presence: true

    has_many :join_game_and_tags
    has_many :tags, through: :join_game_and_tags
    has_many :images
    has_many :rents
    has_many :ranks
    has_many :comments
    has_many :favorites
    has_many :orders
end
