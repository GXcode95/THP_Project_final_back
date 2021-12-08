class Rent < ApplicationRecord
    validates :quantity, presence: true
    validates :status, presence: true

    belongs_to :game
    belongs_to :user
end
