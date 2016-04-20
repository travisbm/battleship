class RemoveBoardFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :board, :text
  end
end
