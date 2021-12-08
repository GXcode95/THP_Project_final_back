class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.belongs_to :user, index: true
      t.boolean :paid
      t.string :stripe_customer_id
      t.timestamps
    end
  end
end
