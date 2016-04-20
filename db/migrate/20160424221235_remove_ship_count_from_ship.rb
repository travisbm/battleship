class RemoveShipCountFromShip < ActiveRecord::Migration
  def change
    remove_column :ships, :ship_count, :integer
  end
end
