class RemoveNameFromShip < ActiveRecord::Migration
  def change
    remove_column :ships, :name, :string
  end
end
