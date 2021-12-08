class Rank < ApplicationRecord
    validates :note, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

    belongs_to :game
    belongs_to :user
end