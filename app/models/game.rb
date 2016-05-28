class Game < ActiveRecord::Base
  before_create :init
  after_create  :build_game_cells, :set_ships

  has_many :cells

  ARRAY_SIZE    = 10
  NUM_SHOTS     = 50
  CARRIER_COUNT = 2
  VESSEL_COUNT  = 3
  BOAT_COUNT    = 5
  OPEN          = "open"
  HIT           = "hit"
  MISS          = "miss"
  BOAT          = "Boat"
  VESSEL        = "Vessel"
  CARRIER       = "Carrier"
  SHIPS_ARRAY   = [BOAT, VESSEL, CARRIER]

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
      range.each { |cell| cell.update(status: ship.type, ship: ship) }
    else
      place_ship(ship)
    end
  end

  # Updates status of cells fired upon and updates score
  #
  # @param [Cell] cell
  def fire(cell_id)
    cell   = Cell.find(cell_id)
    status = cell.status

    case status
    when OPEN
      update_game_when_miss(cell)
      set_game_final_score if game_over?
    when *SHIPS_ARRAY
      update_game_when_hit(cell)
      set_game_final_score if game_over?
    # else
    #   raise "Invalid Cell status..."
    end
  end

  # Returns final score
  #
  # @return [Integer]
  def final_score
    (self.score / (Time.now - self.created_at)).floor
  end

  # Returns true if player is out of shots or all ships are sunk
  #
  # @return [Boolean]
  def game_over?
    self.shots <= 0 || self.cells.where.not(ship_id: nil).none?
  end

  private

  # Updates game stats when shot is a MISS
  #
  # @param [Cell] cell
  def update_game_when_miss(cell)
    cell.update(status: MISS)
    self.update(score: (self.score - 50), shots: (self.shots - 1))
  end

  # Updates game stats when shot is a HIT
  #
  # @param [Cell] cell
  def update_game_when_hit(cell)
    cell.update(status: HIT, ship_id: nil)
    self.update(score: (self.score + 500))
  end

  # Sets final score for game
  def set_game_final_score
    self.update(score: self.final_score)
  end

  # Returns true if open cells available
  #
  # @return [Boolean]
  def empty_cell?
    self.cells.where(status: OPEN).any?
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
      place_ship(Carrier.create)
    end
  end

  # Initializes game stats
  def init
    self.shots ||= NUM_SHOTS
    self.score ||= 0
  end
end
