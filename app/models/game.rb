class Game < ActiveRecord::Base
  serialize :board, Array
  before_create :set_board, :set_shots

  ARRAY_SIZE    = 10
  NUM_SHOTS     = 50
  CARRIER_SIZE  = 5
  CARRIER_COUNT = 2
  VESSEL_SIZE   = 3
  VESSEL_COUNT  = 3
  BOAT_SIZE     = 1
  BOAT_COUNT    = 5

  # Return a random empty cell
  #
  # @param [Integer] count
  #
  # @return [Cell]
  # @return [String]
  def random_cell(count = 0)
    cnt = count
    cell = self.board[rand(0..9)][rand(0..9)]

    if cell.status == 0
      cell
    elsif cnt == 100
      return "No empty cells"
    else
      cnt += 1
      random_cell(cnt)
    end
  end

  # Place ships on the game board
  #
  # @param [Integer] ship_size
  def place_ship(ship_size)
    cell = random_cell
    direction = [:left, :right, :up, :down].sample

    return cell.status = BOAT_SIZE if ship_size.equal?(BOAT_SIZE)

    case direction
    when :left
      negative_edge(cell, ship_size, self.board)
    when :right
      positive_edge(cell, ship_size, self.board)
    when :up
      negative_edge(cell, ship_size, self.board.transpose)
    when :down
      positive_edge(cell, ship_size, self.board.transpose)
    end
  end

  # Checks positive edge of board for ship placement
  #
  # @param [Cell]    cell
  # @param [Integer] ship_size
  # @param [Array]   board
  def positive_edge(cell, ship_size, board)
    range      = board[cell.row][cell.column..(cell.column + (ship_size - 1))]
    right_edge = cell.column + (ship_size - 1) <= ARRAY_SIZE - 1

    set_cell_status(cell, ship_size, right_edge, range)
  end

  # Checks negative edge of board for ship placement
  #
  # @param [Cell]    cell
  # @param [Integer] ship_size
  # @param [Array]   board
  def negative_edge(cell, ship_size, board)
    range     = board[cell.row][(cell.column - (ship_size - 1))..cell.column]
    left_edge = cell.column - (ship_size - 1) >= 0

    set_cell_status(cell, ship_size, left_edge, range)
  end

  # Sets cell status to ship_size
  #
  # @param [Cell]    cells
  # @param [Integer] ship_size
  # @param [Boolean] edge
  # @param [Array]   range
  def set_cell_status(cell, ship_size, edge, range)
    if (edge) && (range).none? { |cell| cell.status > 0 }
      range.each do |cell|
        cell.status = ship_size
      end
    else
      place_ship(ship_size)
    end
  end

  private

  # Places ships on board
  def set_ships
    CARRIER_COUNT.times do
      self.place_ship(CARRIER_SIZE)
    end

    VESSEL_COUNT.times do
      self.place_ship(VESSEL_SIZE)
    end

    BOAT_COUNT.times do
      self.place_ship(BOAT_SIZE)
    end
  end

  # Sets game board
  def set_board
    self.board = Array.new(ARRAY_SIZE) do |row|
      Array.new(ARRAY_SIZE) { |column| Cell.new(row, column) }
    end

    set_ships
  end

  # Sets game shots count
  def set_shots
    self.shots = NUM_SHOTS
  end

end
