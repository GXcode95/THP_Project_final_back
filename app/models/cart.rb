class Cart < ApplicationRecord
  belongs_to :user

  has_many :orders
  has_many :games, through: :orders
  has_many :packages, through: :orders

  def total_price
    total = 0

    self.orders.each do |order|
      total += order.get_price * order.quantity
    end

    total
  end
end
