require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) {create(:game)}

  describe "#create" do
    it "sets a shot count" do
      expect(game.shots).to eq(Game::NUM_SHOTS)
    end

    it "builds an array of 10 elements" do
      expect(game.board.count).to eq(Game::ARRAY_SIZE)
    end

    it "builds an array of arrays" do
      expect(game.board.all? { |array| array.is_a?(Array) }).to be(true)
    end

    it "builds an array of arrays with 10 elements each" do
      expect(game.board.sample.count).to eq(Game::ARRAY_SIZE)
    end

    it "builds a 2D array of Cell objects" do
      expect(game.board.first.sample.is_a?(Cell)).to be(true)
    end
  end
end
