class Game < ActiveRecord::Base
  after_create  :build_game_cells, :set_ships, :set_shots

  has_many :cells

  ARRAY_SIZE    = 10
  NUM_SHOTS     = 50
  CARRIER_COUNT = 2
  VESSEL_COUNT  = 3
  BOAT_COUNT    = 5
  OPEN          = "open"

  # Place ships on the game board
  #
  # @param [Ship] ship
  def place_ship(ship)
    cell      = random_cell
    size      = ship.size - 1
    row       = cell.row
    column    = cell.column
    direction = [:left, :right, :up, :down].sample

    case direction
    when :left
      range = self.cells.where(row: row).where(column: negative_range(column, size))
      edge  = fits_negative_edge?(column, size)
    when :right
      range = self.cells.where(row: row).where(column: positive_range(column, size))
      edge  = fits_positive_edge?(column, size)
    when :up
      range = self.cells.where(column: column).where(row: negative_range(row, size))
      edge  = fits_negative_edge?(row, size)
    when :down
      range = self.cells.where(column: column).where(row: positive_range(row, size))
      edge  = fits_positive_edge?(row, size)
    end

    if edge && range.all? { |cell| cell.status == OPEN }
      range.each { |cell| cell.update(status: ship.type) }
    else
      place_ship(ship)
    end
  end

  private

  # Returns true if open cells available
  #
  # @return [Boolean]
  def empty_cell?
    self.cells.any? { |cell| cell.status == OPEN}
  end

  # Return a random empty cell
  #
  # @return [Cell] cell
  def random_cell
    raise "No empty game cells..." if !empty_cell?
    self.cells.sample
  end

  # Returns range for ships being placed in positive direction
  #
  # @return [Range]
  def positive_range(row_or_column, size)
    row_or_column..(row_or_column + size)
  end

  # Returns range for ships being placed in negative direction
  #
  # @return [Range]
  def negative_range(row_or_column, size)
    (row_or_column - size)..row_or_column
  end

  # Checks if ship fits inside positive edge
  #
  # @return [Boolean]
  def fits_positive_edge?(row_or_column, size)
    row_or_column + size <= ARRAY_SIZE - 1
  end

  # Checks if ship fits inside negative edge
  #
  # @return [Boolean]
  def fits_negative_edge?(row_or_column, size)
    row_or_column - size >= 0
  end

  # Builds cells to hold game state
  def build_game_cells
    ARRAY_SIZE.times do |row|
      ARRAY_SIZE.times do |column|
        self.cells.create(row: row, column: column)
      end
    end
  end

  # Places ships on the board
  def set_ships
    BOAT_COUNT.times do
      place_ship(Boat.create)
    end

    VESSEL_COUNT.times do
      place_ship(Vessel.create)
    end

    CARRIER_COUNT.times do
      self.place_ship(Carrier.create)
    end
  end

  # Sets game shots count
  def set_shots
    self.update(shots: NUM_SHOTS)
  end
end
