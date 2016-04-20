class Cell < ActiveRecord::Base
  before_create :init
  belongs_to :game

  def init
    self.status = Game::OPEN
  end
end
