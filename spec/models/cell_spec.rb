require 'rails_helper'

RSpec.describe Cell do
  let(:cell) {create(:cell)}

  describe '.create' do
    it "intitializes cell row" do
      expect(cell.row).to eq(nil)
    end

    it "initializes cell column" do
      expect(cell.column).to eq(nil)
    end

    it "initializes cell status to nil" do
      expect(cell.status).to eq(Game::OPEN)
    end
  end
end
