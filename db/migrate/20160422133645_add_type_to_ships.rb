class AddTypeToShips < ActiveRecord::Migration
  def change
    add_column :ships, :type, :string
  end
end
