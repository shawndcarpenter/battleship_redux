require 'spec_helper'

RSpec.describe Cell do
  describe "#cell initialization" do
    before(:each) do
      @cell = Cell.new("B4")
    end

    it 'is a cell' do
      expect(@cell).to be_an_instance_of Cell
    end
    
    it 'has attributes' do
      expect(@cell.coordinate).to eq("B4")
      expect(@cell.ship).to be nil
    end
    
    it 'has an empty status' do
      expect(@cell.empty?).to be true
    end
    
  end
  
  describe "#ship placement" do
    before(:each) do
      @cell = Cell.new("B4")
      @cruiser = Ship.new("Cruiser", 3)
    end
  
    it 'can contain a ship' do
      expect(@cell.ship).to be nil
      expect(@cell.empty?).to be true
      
      @cell.place_ship(@cruiser)
      
      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.empty?).to be false
    end
  end

  describe '#fire_upon' do
    before(:each) do
      @cell = Cell.new("B4")
      @cruiser = Ship.new("Cruiser", 3)
      @cell.place_ship(@cruiser)
    end

    it 'knows when it has been fired upon' do
      expect(@cell.fired_upon?).to be false

      @cell.fire_upon

      expect(@cell.ship.health).to be 2
      expect(@cell.fired_upon?).to be true
    end
  end
end