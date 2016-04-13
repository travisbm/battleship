class Game < ActiveRecord::Base
  serialize :board, Array
  before_create :set_board, :set_shots

  ARRAY_SIZE = 10
  NUM_SHOTS  = 50

  private

  # Sets game board
  def set_board
    self.board = Array.new(ARRAY_SIZE) do |row|
      Array.new(ARRAY_SIZE) { |column| Cell.new(row, column) }
    end
  end

  # Sets game shots count
  def set_shots
    self.shots = NUM_SHOTS
  end
end
