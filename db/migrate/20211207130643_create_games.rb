class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :name
      t.integer :price
      t.string :creator
      t.string :editor
      t.text :description
      t.integer :min_player
      t.integer :max_player
      t.integer :min_age
      t.date :release_date
      t.integer :sell_stock
      t.integer :rent_stock

      t.timestamps
    end
  end
end
