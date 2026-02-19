require 'spec_helper'

RSpec.describe Ship do
  describe '#ship initialization' do
    it 'can create a ship' do
      cruiser = Ship.new("Cruiser", 3)
      
      expect(cruiser).to be_an_instance_of Ship
    end
    
    before(:each) do
      @cruiser = Ship.new("Cruiser", 3)
    end

    it 'has attributes' do
      expect(@cruiser.name).to eq("Cruiser")
      expect(@cruiser.length).to eq 3
      expect(@cruiser.health).to eq 3
    end
    
    it 'can take damage' do
      expect(@cruiser.health).to eq 3
      
      @cruiser.hit
      
      expect(@cruiser.health).to eq 2

      @cruiser.hit
      
      expect(@cruiser.health).to eq 1      
    end
    
    it 'can be sunk' do
      @cruiser.hit
      @cruiser.hit

      expect(@cruiser.sunk?).to be false

      @cruiser.hit
      
      expect(@cruiser.sunk?).to be true
    end
  end
end