class Order < ApplicationRecord
    validates :quantity, presence: true
    
    belongs_to :cart
    belongs_to :package
    belongs_to :game
end
