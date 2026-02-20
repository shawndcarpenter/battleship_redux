class Board
  attr_reader :cells

  def initialize
    @cells = {}

    build_cells
  end

  def build_cells
    rows = ["A", "B", "C", "D"]
    rows.each do |row|
      i = 0
      until i == 4
        i += 1
        @cells["#{row + i.to_s}"] = Cell.new("#{row + i.to_s}")
      end
    end
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    ord_letters = []
    numbers = []
    coordinates.each do |coordinate|
      if !@cells["#{coordinate}"].empty?
        return false
      end

      ord_letters <<coordinate[0].ord
      numbers <<coordinate[1].to_i
    end

    (ship.length == coordinates.length) && 
    (ord_letters.uniq.length == 1 && 
      self.consecutive?(numbers) || 
      numbers.uniq.length == 1 &&
      self.consecutive?(ord_letters))
  end

  def consecutive?(numbers)
    i = numbers[0]

    numbers.each do |number|
      if i == number
        i += 1
      else
        return false
      end
    end
    true
  end

  def place(ship, coords)
    if self.valid_placement?(ship, coords)
      coords.each do |coord|
        @cells["#{coord}"].place_ship(ship)
      end
    end
  end
end