class Game < ActiveRecord::Base
  serialize :board, Array
end
