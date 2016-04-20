require 'rails_helper'

RSpec.describe Boat do
  let(:boat) {Boat.create}

  describe '.create' do
    it 'initializes boat size' do
      expect(boat.size).to eq(Boat::SIZE)
    end
  end
end
