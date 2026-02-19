class Cell
  attr_reader :coordinate, :ship
  attr_writer :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end

  def empty?
    ship == nil
  end

  def place_ship(ship_name)
    if self.empty?
      @ship = ship_name
    end
  end
end