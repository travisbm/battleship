class Carrier < Ship
  before_create :init

  SIZE = 5

  def init
    self.size = SIZE
  end
end
