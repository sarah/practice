require 'timeout'
class Cell
  def initialize
    @alive = 0.5 > rand
    # puts "in initialize: @alive: #{@alive}; #{@alive.class}"
  end
  def alive?
    # puts "@alive: #{@alive}; #{@alive.class}"
    @alive
  end
  def to_s
   alive? ? "o" : " "
  end
  # used for summing active_neighbors count
  def to_i
    alive? ? 1 : 0
  end
   # 1. Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
   # 2. Any live cell with more than three live neighbours dies, as if by overcrowding.
   # 3. Any live cell with two or three live neighbours lives on to the next generation.
   # 4. Any dead cell with exactly three live neighbours becomes a live cell.
  def next_state!(alive_neighbor_count)
    if alive?
      @alive = false if (alive_neighbor_count < 2) || (alive_neighbor_count >3)
    else
      @alive = true if alive_neighbor_count == 3
    end
  end
end

class Game
  # Make a grid of cells
  def initialize(width,height,steps)
    @width,@height,@steps = width, height, steps
    @grid = Array.new(@height){
      Array.new(@width){
        Cell.new
      }
    }
  end
  # draw the grid, showing the state of each cell
  def draw
    @grid.each do |row|
      puts row.map{|cell|
        cell.to_s
      }.join("")
    end
  end
  # draw the grid as many times as specified when the game started (@steps)
  def play
    draw
    @steps.times do 
       get_state
       `clear`
       draw
     end
  end
  # calculate whether each cell should be alive or dead and return new grid
  def get_state
    @grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        cell = @grid[y][x]
        cell_coords = [y,x]
        possible_neighbors = [
          [y,x-1],[y,x+1], # sides
          [y-1,x-1], [y-1,x], [y-1,x+1], # top
          [y+1,x-1], [y+1,x], [y+1,x+1]  # bottom
        ]
        neighbors = get_neighbors(possible_neighbors, cell_coords)
        # p "coords #{cell_coords.inspect}: neighbors: #{neighbors.size}: #{neighbors.inspect}"
        num_active_neighbors = count_active_neighbors(neighbors)
        # puts "I am currently  #{cell.alive? ? "alive" : "dead" } and I have #{num_active_neighbors} active neighbors."
        cell.next_state!(num_active_neighbors)
        # puts "I am now: #{cell.alive? ? "alive" : "dead"}"
        # puts "-------"
      end
    end
  end
  def get_neighbors(possible_neighbors,cell_coords)
    possible_neighbors.select do |neighbor_coords|
      y,x = neighbor_coords[0], neighbor_coords[1]
      # puts "y: #{y}; x: #{x}; width: #{@width}; height: #{@height}"
      !neighbor_coords.include?(-1) && (x < @width) && (y < @height)
    end
  end
  def count_active_neighbors(neighbors)
    neighbors.inject(0) do |sum,coords|
      sum + @grid[coords[0]][coords[1]].to_i
    end
  end
end

game = Game.new(100,50,100)
game.play

