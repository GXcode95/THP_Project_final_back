class CreateRanks < ActiveRecord::Migration[6.1]
  def change
    create_table :ranks do |t|
      t.belongs_to :game, index: true 
      t.belongs_to :user, index: true
      t.integer :note
      t.timestamps
    end
  end
end
