class Order < ApplicationRecord
    belongs_to :cart
    belongs_to :package
    belongs_to :game
end
