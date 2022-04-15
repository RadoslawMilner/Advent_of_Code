# readlines are must AND let's chomp - get rid of "\n" AND definitely we need seperate characters nad of course we need defined integers
data1 = File.readlines('example.txt').map(&:chomp).map(&:chars).map { |integer| integer.map(&:to_i) }
data2 = File.readlines('input.txt').map(&:chomp).map(&:chars).map { |integer| integer.map(&:to_i) }
data = data2

# build an array to gather low points
risk_level_of_low_points = []

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
      # y,x > 0 ; y,x < input.length - 1 = corners
      # COMPARISONS with neighbours: [y-1] - up ; [x+1] - right ; [y+1] - down ; [x-1] - left
    when (data[y-1][x] <= data[y][x] and y > 0)
      false
    when ( data[y][x-1] <= data[y][x] and x > 0 )
      false
    when ( y < data.length - 1 and data[y+1][x] <= data[y][x] )
      false
    when ( x < data[0].length - 1 and data[y][x+1] <= data[y][x] )
      false
      # 5. push finded low points into defined array
    else
      risk_level_of_low_points << data[y][x]
    end
  end
end

# raise by one all low points
risk_level_of_low_points.map! do |low_point|
  low_point + 1
end

# sum all low points
p risk_level_of_low_points.sum

# => 518