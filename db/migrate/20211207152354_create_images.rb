class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.belongs_to :game, index: true
      t.string :public_id
      t.timestamps
    end
  end
end
