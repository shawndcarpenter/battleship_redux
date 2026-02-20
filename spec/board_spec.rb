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

  describe '#valid_placement?' do
    before(:each) do
      @board = Board.new
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2)
    end

    it 'can validate coordinates in array match length of ship' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be false
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to be false
    end
    
    it 'can make sure coordinates are consecutive' do
      # binding.pry
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be false
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to be false
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be false
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be false
    end
    
    it 'can validate coordinates are not diagonal' do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be false
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be false
    end

    it 'can validate placement' do
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be true
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be true
    end
  end

  describe '#placing ships' do
    it 'can place a ship in its cells' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"] 
      
      expect(cell_1.ship).to eq(cruiser)
      expect(cell_2.ship).to eq(cruiser)
      expect(cell_3.ship).to eq(cruiser)
      expect(cell_3.ship == cell_2.ship).to be true
    end
  end
  
  describe '#overlapping ships' do
    it "checks that ships are not overlapping" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      submarine = Ship.new("Submarine", 2)
      
      expect(board.valid_placement?(submarine, ["A1", "B1"])).to be false
    end
  end
  
  describe '#rendering the board' do
    it 'renders board as a string' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      
      expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
      expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
    end
  end
end