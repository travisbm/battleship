class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.references :game, index: true, foreign_key: true
      t.text       :cell_array
      t.string     :name
      t.integer    :size

      t.timestamps null: false
    end
  end
end
