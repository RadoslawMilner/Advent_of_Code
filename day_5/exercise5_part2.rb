# readlines is the best: 1. immediately we get array.
# 2. according to whatever input you get elements just as there are in file content. But there ale always '\n' (due to enters)
# so, get chomp them. You must use chomp with map, because chomp u only with strings. So chomp and map them into array

example_array = File.readlines('example.txt').map(&:chomp)
my_puzzle_input = File.readlines('input.txt').map(&:chomp)
# here you can input your data. that data will be processed later
two_dimensional_array = my_puzzle_input
# create empty grid with 0es as values of this grid. this grid has 1000 fields, because none of the input values exceed 1000
# instead of 0 we could use dots (.). But ruby can't cannot perform the add operation on (.) and 1.
# Moreover we cannot convert a dot to integer
grid = Array.new(1000) { Array.new(1000) { 0 } }

two_dimensional_array.each do |l|

  x1_y1_x2_y2 = l.split(' -> ')
  x1_y1 = x1_y1_x2_y2[0].split(',')
  x2_y2 = x1_y1_x2_y2[1].split(',')
  # ["0,9", "5,9"]
  # ["8,0", "0,8"]
  # ["9,4", "3,4"]
  # ["2,2", "2,1"]
  # ["7,0", "7,4"]
  # ["6,4", "2,0"]
  # ["0,9", "2,9"]
  # ["3,4", "1,4"]
  # ["0,0", "8,8"]
  # ["5,5", "8,2"]
  # array[0] - first element, after each and split = x, so first column represent our x-es
  # array[1] - second element, after each and split = y, so second column represent our y-es
  first_points = x1_y1.map(&:to_i)
  second_points = x2_y2.map(&:to_i)
  # after each, splitting, and mapping to integers
  # so here, sequentialy:
  # [x1 y1 x2 y2]
  # [0, 9, 5, 9]
  # [8, 0, 0, 8]
  # [9, 4, 3, 4]
  # [2, 2, 2, 1]
  # [7, 0, 7, 4]
  # [6, 4, 2, 0]
  # [0, 9, 2, 9]
  # [3, 4, 1, 4]
  # [0, 0, 8, 8]
  # [5, 5, 8, 2]

  # we need to be careful - it's our insurance:
  # if first point-y1, will be larger than second point-y2 OR 
  # if first point-y1, will be the same as second point-y2 AND first point-x1 will be larger than second point x2
  # then simply reverse points = globally we set the new rules of inversion which allow us to draw line still forward, not backwards
  case
  when first_points[1] > second_points[1]
    (first_points, second_points = second_points, first_points)
  when first_points[1] == second_points[1] && first_points[0] > second_points[0]
    (first_points, second_points = second_points, first_points)
  end
  x1, y1, x2, y2 = first_points + second_points

  # as it happens in the example, position points can repeat = overleap each other.
  # if they do, then we get a horizontal line. or if it will be x1 == x2. 
  # if it happens that y1 != y2 & x1 != x2, then we get a diagonal line.
  # which we don't need according to task content
  case
  when y1 == y2
    # we are using range because of task content:
    # "These line segments include the points at both ends. In other words:
    # An entry like 1,1 -> 1,3 covers points 1,1, 1,2, and 1,3.
    # An entry like 9,7 -> 7,7 covers points 9,7, 8,7, and 7,7."
    (x1..x2).each do |x|
      # we want to move with the grid, one by one - horizontal line with x-es
      grid[y1][x] += 1
    end
  
  # repeat proccess as at horizontal lines. here we have verticals. simply replace variables
  when x1 == x2
    # we are using range because of task content:
    # "These line segments include the points at both ends. In other words:
    # An entry like 1,1 -> 1,3 covers points 1,1, 1,2, and 1,3.
    # An entry like 9,7 -> 7,7 covers points 9,7, 8,7, and 7,7."
    (y1..y2).each do |y|
    # we want to move with the grid, one by one - vertical line with y-es
      grid[y][x1] += 1
    end
  else
    # third situation in case where the two previous situations don't happen
    # ofcourse - these upgrade is for diagonal lines
    # we need to go with both points. increase them.
    # unitl they match to x2,y2. So, we want to draw lines on our map to the bottom-right corner
    # i tried do it with range, just as previous ones, so here it would look like: (x1..y2.each do |x1,y1|
    # but it don't work due to nil value
    loop do
      grid[y1][x1] += 1
      # which has coordinates: x1=9, y1=9 ; x2=9, y2=9 => 9,9 ; 9,9
      break if x1 == x2 && y1 == y2
      # if y1 is smaller than y2 then increase non-stop (until condition) point of grid
      if y1 < y2 then y1 += 1 end
      # if y2 is larger...we can draw backwards, but in numerical world, we must decrease value, due to, we draw a line from
      # higher value
      if y2 < y1 then y1 -= 1 end
       # if x1 is smaller than x2 then increase non-stop (until condition) point of grid
      if x1 < x2 then x1 += 1 end
      # if x2 is larger...we can draw backwards, but in numerical world, we must decrease value, due to, we draw a line from
      # higher value
      if x2 < x1 then x1 -= 1 end
    end
  end
  # the clue is to reach points 9,9; 9,9 = the end of ...map? let's call it map

end
# here want to get rid of the unnecessary brackets with flatten. more important, at last 
# we want to count our twos. the count of twos is a result of this ex.
p grid.flatten.count { |i| i >= 2 }

# the difficulty level actually increases. but there are exception. this exercise, to me, is an exception.
# this task is easier then the previous ones. maybe not exactly part2

# => 20373
