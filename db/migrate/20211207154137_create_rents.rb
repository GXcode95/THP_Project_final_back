class CreateRents < ActiveRecord::Migration[6.1]
  def change
    create_table :rents do |t|
      t.belongs_to :game, index: true
      t.belongs_to :user, index: true
      t.integer :quantity
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
