class RemoveGameFromShips < ActiveRecord::Migration
  def change
    remove_reference :ships, :game, index: true, foreign_key: true
  end
end
