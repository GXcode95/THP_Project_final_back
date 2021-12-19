class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.belongs_to :user, index: true
      t.boolean :paid, default: false
      t.boolean :package_cart, default: false
      t.string :session_id
      t.timestamps
    end
  end
end
