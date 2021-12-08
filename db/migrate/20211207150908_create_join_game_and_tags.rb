class CreateJoinGameAndTags < ActiveRecord::Migration[6.1]
  def change
    create_table :join_game_and_tags do |t|
      t.belongs_to :game, index: true
      t.belongs_to :tag, index: true
      t.timestamps
    end
  end
end
