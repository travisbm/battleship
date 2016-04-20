require 'rails_helper'

RSpec.describe Carrier do
  let(:carrier) {Carrier.create}

  describe '.create' do
    it 'initializes carrier size' do
      expect(carrier.size).to eq(Carrier::SIZE)
    end
  end
end
