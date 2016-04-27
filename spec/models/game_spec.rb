require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game)       {create(:game)}
  let(:game_score) {create(:game, :score)}
  let(:cell)       {create(:cell)}
  let(:cell_ship)  {create(:cell, :ship)}

  describe ".create" do
    it "sets a shot count" do
      expect(game.shots).to eq(Game::NUM_SHOTS)
    end

    it "sets an initial score of 0" do
      expect(game.score).to eq(0)
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

  describe "#fire" do
    it "updates status to MISS when OPEN cell fired on" do
      expect{
        game.fire(cell.id)
        cell.reload
      }.to change(cell, :status).from(Game::OPEN).to(Game::MISS)
    end

    it "decrements score by 50 when shot is a MISS" do
      expect{
        game.fire(cell.id)
      }.to change(game, :score).by (-50)
    end

    it "decrements shots by 1 when shot is a MISS" do
      expect{
        game.fire(cell.id)
      }.to change(game, :shots).by (-1)
    end

    it "updates status to HIT when status is not OPEN, MISS or HIT" do
      expect{
        game.fire(cell_ship.id)
        cell_ship.reload
      }.to change(cell_ship, :status).from("Boat").to(Game::HIT)
    end

    it "updates score when a Ship is fired upon" do
      expect{
        game.fire(cell_ship.id)
      }.to change(game, :score).by (500)
    end
  end

  describe "#final_score" do
    it "returns final calculated score" do
      allow(Time).to receive(:now).and_return(game_score.created_at + 180)

      expect(game_score.final_score).to eq(60)
    end
  end
end
