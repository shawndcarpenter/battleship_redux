class Cell
  attr_reader :coordinate, :ship, :fired_upon
  attr_writer :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    ship == nil
  end

  def place_ship(ship_name)
    if self.empty?
      @ship = ship_name
    end
  end

  def fired_upon?
    fired_upon
  end

  def fire_upon
    if !self.fired_upon?
      @fired_upon = true
      if !self.empty?
        @ship.hit
      end
    end
  end

  def render(show_ship = nil)
    if show_ship == true && !self.fired_upon? && !self.empty? && !ship.sunk?
      "S" #show ship turned on
    elsif !self.fired_upon? 
      "." # cell has not been fired upon
    elsif self.fired_upon? && self.empty?
      "M" # cell fired upon/contains no ship
    elsif self.fired_upon? && !self.empty? && !ship.sunk?
      "H" # cell fired upon/contains ship/ship not sunk
    elsif self.fired_upon? && !self.empty? && ship.sunk?
      "X" # cell fired upon/contains ship/ship sunk
    end
  end
end