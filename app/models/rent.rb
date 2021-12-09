class Rent < ApplicationRecord
    enum status: [:wishlist, :rented, :past_rentals]

    validates :quantity, presence: true
    validates :status
  
    belongs_to :game
    belongs_to :user
end
