# readlines are must AND let's chomp - get rid of "\n" AND definitely we need seperate characters nad of course we need defined integers
data1 = File.readlines('example.txt').map(&:chomp).map(&:chars).map { |integer| integer.map(&:to_i) }
data2 = File.readlines('input.txt').map(&:chomp).map(&:chars).map { |integer| integer.map(&:to_i) }
data = data2

# part 2 vs 1 = add array to gather coordinates of our "grid"
coordinates_of_low_points = []
# building grid: (below grid represents example input !!! )
# through each index - y - our row
data.each_index do |y|
  # through each index - x - our column - [0] - start with each next row
  data[0].each_index do |x|
    #   0 1 2 3 4 5 6 7 8 9 -- x
    # 0 2 1 9 9 9 4 3 2 1 0
    # 1 3 9 8 7 8 9 4 9 2 1
    # 2 9 8 5 6 7 8 9 8 9 2
    # 3 8 7 6 7 8 9 6 7 8 9
    # 4 9 8 9 9 9 6 5 6 7 8
    # |
    # y

    # case-when is especially created for this task - it's clear elimination...huh. breakpoint - it can be way to deal with ex8p2
    case
      # here is lesson for me - brackets don't do anything wrong. If you can use them? Use them. Especially on chains!
      # false is smart way to throw away unwanted results - the way to exclude some results
      # y,x > 0 ; y,x < input.size - 1 = corners
      # COMPARISONS with neighbours: [y-1] - up ; [x+1] - right ; [y+1] - down ; [x-1] - left
    when (data[y - 1][x] <= data[y][x] and y > 0)
      false
    when (data[y][x - 1] <= data[y][x] and x > 0)
      false
    when (y < data.size - 1 and data[y + 1][x] <= data[y][x])
      false
    when (x < data[0].size - 1 and data[y][x + 1] <= data[y][x])
      false
      # 5. push finded low points into defined array
    else
      # part 2 vs 1 = add array to gather coordinates of our "grid"
      # declare hash to have coordinates assigned to y,x. many times in array - hack on 1 key
      coordinates_of_low_points << { y: y, x: x }
    end
  end
end
# using coords check all up, down, left, right points
def basin(data, y, x)
  case
    # checking basins - process of elimination
    # present or not present = 0 is not present
    # 9 = checked
  when x < 0
    0
  when y < 0
    0
    # index because its still our "column" (array of array)
  when x >= data[0].size
    0
  when y >= data.size
    0
  # until we find all 9-s
  when data[y][x] == 9
    0
  else
  # and again 9 = point in next call is to map data to 9.
    data[y][x] = 9
    # counting size of basins and checking neighbours to build up basins
    # mostly the same as in searching low points for starting searching basin
    # and building basins, counting basins size
    check_UP = basin(data, y - 1, x)
    check_DOWN = basin(data, y + 1, x)
    check_LEFT = basin(data, y, x - 1)
    check_RIGHT = basin(data, y, x + 1)
    # +1 is to increment ours x-s and y-s non-stop
    check_UP + check_DOWN + check_LEFT + check_RIGHT + 1
  end
end

# through each coords of low points - change our coords array to:
coordinates_of_low_points.map! do |coords|
# key basin => lowest points of basins / coords y => value y / coords x => value x
# as in...previous exercises I thought and wanted to attach above defined method to this mapping
# but using multi hashes in array is confortable. and method gladly accepts input and converts it
  p coords[:basin] = basin(data, coords[:y], coords[:x])
end
# task content: "Find the three largest basins and multiply their sizes together."
p coordinates_of_low_points.max(3).inject(:*)

# => 949905
