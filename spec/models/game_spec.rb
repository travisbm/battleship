require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) {create(:game)}

  describe ".create" do
    it "sets a shot count" do
      expect(game.shots).to eq(Game::NUM_SHOTS)
    end

    it "builds an ARRAY_SIZE X ARRAY_SIZE grid of cells" do
      expect(game.cells.count).to eq(Game::ARRAY_SIZE * Game::ARRAY_SIZE)
    end

    it "sets 5 boats on game board" do
        expect(game.cells.where(status: "boat").count).to eq(Game::BOAT_COUNT * Boat::SIZE)
    end

    it "sets 3 vessels on game board" do
      expect(game.cells.where(status: "vessel").count).to eq(Game::VESSEL_COUNT * Vessel::SIZE)
    end

    it "sets 2 aircraft carriers on game board" do
      expect(game.cells.where(status: "carrier").count).to eq(Game::CARRIER_COUNT * Carrier::SIZE)
    end
  end
end
