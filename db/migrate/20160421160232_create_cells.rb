class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.references :game, index: true, foreign_key: true
      t.integer    :row
      t.integer    :column
      t.string     :status

      t.timestamps null: false
    end
  end
end
