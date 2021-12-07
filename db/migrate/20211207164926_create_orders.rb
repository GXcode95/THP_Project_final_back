class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :cart, index: true
      t.belongs_to :package, index: true
      t.belongs_to :game, index: true  
      t.integer :quantity
      t.timestamps
    end
  end
end
