class Rent < ApplicationRecord
    enum status: [:wishlist, :rented, :past_rentals]

    validates :quantity, presence: true
  
    belongs_to :game
    belongs_to :user

    def self.change_all_rents_status(rents)
      rents.each do |rent|
        if (rent.status == "wishlist")
          rent.update(status: "rented")
        elsif (rent.status == "rented")
          rent.update(status: "past_rentals")
        else
        end
      end
    end 
end
