require 'rails_helper'

RSpec.describe Cell do
  let(:cell) {Cell.new(0, 0)}

  describe '#new' do
    it "intitializes cell row" do
      expect(cell.row).to eq(0)
    end

    it "initializes cell column" do
      expect(cell.column).to eq(0)
    end

    it "initializes cell status to 0" do
      expect(cell.status).to eq(0)
    end
  end

  describe "get_coordinates" do
    it "returns cell coordinates formatted" do
      expect(cell.get_coordinates).to eq("(0, 0)")
    end
  end

end
