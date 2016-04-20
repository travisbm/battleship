class Boat < Ship
  before_create :init

  SIZE = 1

  def init
    self.size = SIZE
  end
end
