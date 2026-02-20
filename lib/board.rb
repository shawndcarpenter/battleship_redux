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
end