class Cart < ApplicationRecord
    belongs_to :user

    has_many :orders
    has_many :games, through: :orders
    has_many :packages, through: :orders
end
