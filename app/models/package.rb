class Package < ApplicationRecord
    validates :game_number, presence: true
    validates :name, presence: true
    validates :price, presence: true

    has_many :users
    has_many :orders
end
