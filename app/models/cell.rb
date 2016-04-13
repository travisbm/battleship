class Cell
  attr_accessor :row, :column, :status

  def initialize(row = nil, column = nil)
    @row = row
    @column = column
    @status = 0
  end

  # Returns formatted coordinates
  #
  # @return [String]
  def get_coordinates
    "(#{row}, #{column})"
  end

end
