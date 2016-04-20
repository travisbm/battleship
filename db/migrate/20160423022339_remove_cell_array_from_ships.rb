class RemoveCellArrayFromShips < ActiveRecord::Migration
  def change
    remove_column :ships, :cell_array, :text
  end
end
