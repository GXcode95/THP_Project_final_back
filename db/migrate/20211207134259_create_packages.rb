class CreatePackages < ActiveRecord::Migration[6.1]
  def change
    create_table :packages do |t|
      t.integer :game_number
      t.string :name
      t.integer :price
      t.string :description, default: ""
      t.timestamps
    end
  end
end
