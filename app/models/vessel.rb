class Vessel < Ship
  before_create :init

  SIZE = 3

  def init
    self.size = SIZE
  end
end
