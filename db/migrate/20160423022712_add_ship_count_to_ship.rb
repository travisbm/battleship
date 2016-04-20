class AddShipCountToShip < ActiveRecord::Migration
  def change
    add_column :ships, :ship_count, :integer
  end
end
