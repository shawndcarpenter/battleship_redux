require 'spec_helper'

RSpec.describe Board do
  describe '#initialize' do
    before(:each) do
      @board = Board.new
    end
    it 'can create a board object' do
      expect(@board).to be_an_instance_of Board
    end

    it 'has cells' do
      expect(@board.cells.keys).to eq(["A1", "A2", "A3", "A4", "B1", "B2",
      "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"])
      expect(@board.cells).to be_an_instance_of Hash

      @board.cells.map do |k, v|
        expect(v).to be_an_instance_of Cell
      end
    end

  end

  describe "#valid_coordinate?" do
    before(:each) do
      @board = Board.new
    end

    it "can tell if a coordinate is on a board or not" do
      expect(@board.valid_coordinate?("A1")).to be true
      expect(@board.valid_coordinate?("D4")).to be true
      expect(@board.valid_coordinate?("A5")).to be false
      expect(@board.valid_coordinate?("E1")).to be false 
      expect(@board.valid_coordinate?("A22")).to be false
    end
  end
end