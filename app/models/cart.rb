class Cart < ApplicationRecord
    belongs_to :user
    has_many :orders
    has_many :games, trough: :orders
    has_many :packages, trough: :orders
end
