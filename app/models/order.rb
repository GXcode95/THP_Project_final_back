class Order < ApplicationRecord
    validates :quantity, presence: true

    belongs_to :cart
    belongs_to :package, optional: true
    belongs_to :game, optional: true
end
