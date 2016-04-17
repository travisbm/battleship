require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) {create(:game)}
  let(:board) {game.board}


  describe "#create" do
    it "sets a shot count" do
      expect(game.shots).to eq(Game::NUM_SHOTS)
    end

    it "builds an array of 10 elements" do
      expect(board.count).to eq(Game::ARRAY_SIZE)
    end

    it "builds an array of arrays" do
      expect(board.all? { |array| array.is_a?(Array) }).to be(true)
    end

    it "builds an array of arrays with 10 elements each" do
      expect(board.sample.count).to eq(Game::ARRAY_SIZE)
    end

    it "builds a 2D array of Cell objects" do
      expect(board.first.sample.is_a?(Cell)).to be(true)
    end
  end

  describe "set_shots" do
    it "sets a shot count" do
      expect(game.shots).to eq(50)
    end
  end

  describe "place_ship" do

    it "sets 5 boats on game board" do
      boat_cells_count = board.flatten.inject(0) do |sum, cell|
        cell.status == Game::BOAT_SIZE ? sum + 1 : sum
      end

      expect(boat_cells_count).to eq(Game::BOAT_COUNT * Game::BOAT_SIZE)
    end

    it "sets 3 vessels on game board" do
      vessel_cells_count = board.flatten.inject(0) do |sum, cell|
        cell.status == Game::VESSEL_SIZE ? sum + 1 : sum
      end

      expect(vessel_cells_count).to eq(Game::VESSEL_COUNT * Game::VESSEL_SIZE)
    end

    it "sets 2 aircraft carriers on game board" do
      carrier_cells_count = board.flatten.inject(0) do |sum, cell|
        cell.status == Game::CARRIER_SIZE ? sum + 1 : sum
      end

      expect(carrier_cells_count).to eq(Game::CARRIER_COUNT * Game::CARRIER_SIZE)
    end
  end

  describe "random_cell" do
    it "finds a random empty cell" do
      1000.times do
        expect((game.random_cell).status).to eq(0)
      end
    end
  end

end
