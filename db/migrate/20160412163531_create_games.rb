class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.text    :board
      t.integer :shots

      t.timestamps null: false
    end
  end
end
