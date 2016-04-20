require 'rails_helper'

RSpec.describe Vessel do
  let(:vessel) {Vessel.create}

  describe '.create' do
    it 'initializes vessel size' do
      expect(vessel.size).to eq(Vessel::SIZE)
    end
  end
end
