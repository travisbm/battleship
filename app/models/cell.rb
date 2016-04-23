class Cell < ActiveRecord::Base
  before_create :init
  belongs_to :game
  belongs_to :ship

  def init
    self.status = Game::OPEN
  end
end
