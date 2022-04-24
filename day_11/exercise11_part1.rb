# this task its very similar to this with fish
# it also grows exponentially
# but the MAJOR difference is that: fish grow in one axis = y = rows
# here we have growing on both axes - y (rows) and x (columns)

# each row become array become dump enters become chars become integers
data1 = File.readlines('example.txt').map(&:chomp).map(&:chars).map { |i| i.map(&:to_i) }
data2 = File.readlines('input.txt').map(&:chomp).map(&:chars).map { |i| i.map(&:to_i) }
data = data2

# counter of total_flashes
total_flashes = []

# according to task content: do it by 100 times
100.times do
# according to task content: each time, increase all integers on board - we iterate through elements! not indexes
# so on each row (map! to change immediately elements on grid)
  data.map! do |y_elements|
    y_elements.map do |x_elements|
      x_elements + 1
    end
  end
  # define array to collect flashes, to then count them
  flashes = []
  # new flashes are our switches for loop navigation = our breakpoint AND condition for loop
  # on entry define true
  turn_on_off_loop = true
  while turn_on_off_loop
    # in loop define false to NOT get infinite loop
    turn_on_off_loop = false
    # each index as in previous task: day 9, is very helpful when you need iterate through row and columns
    data.each_with_index do |y_elements, y_axis|
      y_elements.each_with_index do |x_elements, x_axis|
        # this is a core of loop
        # until this condition is met, do not fire the loop
        # so... here is where we want to flash and flash potential neighbors
        # of course we need tools to navigate and find neighbors adjacent to flashes
        # if there is element above 9 AND!!! this is important:
        # if we would use x,y elements into flashes we would get infinite loop
        if x_elements > 9 && !flashes.include?([y_axis, x_axis])
          # go with true when checking neighbors and pushing flashes to flash count
          turn_on_off_loop = true
          # push those indexs to know where was flash
          flashes << [y_axis, x_axis]
          # instead of writing down each direction such as: bunch of arrays in array:
          # [
          # [y,x-1]
          # [y,x+1]
          # [y+1,x+1]
          # ] etc.
          # define directions using method each, rather...writing down each direction separately
          # and iterate through elements on each axis
          [-1, 0, 1].each do |y_elements|
            # -1 y = UP; 0 = centre; 1 y = DOWN
            [-1, 0, 1].each do |x_elements|
              # -1 x = LEFT ; 0 = centre; 1 x = RIGHT
              case
                # here are our filter to check when, what, is increased
                # we can use also here a select 
                # when there are 0-es that showed up due to global increasing
                # then DON'T increase also those ZER0S
                # i don't want situation where zeros would affect others zeros
              when y_elements == 0 && x_elements == 0
                next
                # when elements of y on axis y are still below 0 then DON'T increase adjacents
              when [y_axis,y_elements].sum < 0
                next
                # there of course will be elements that will have some... weird numbers that are more than 0..9 - more than numbers that are presented in task
                # so of course we don't want to do anything with those numbers EXCEPT to change them to 0, accroding to task
              when [y_axis,y_elements].sum > 9
                next
                # when elements of x on axis x are still below 0 then DON'T increase adjacents
              when [x_axis,x_elements].sum < 0
                next
                # same as y:
                # there of course will be elements that will have some... weird numbers that are more than 0..9 - more than numbers that are presented in task
                # so of course we don't want to do anything with those numbers EXCEPT to change them to 0, accroding to task
              when [x_axis,x_elements].sum > 9
                next
              end
              # otherwise - normal situation - when there are flash, increase adjacents
              # according to task this is an extra increase in addition to the global increase
              data[y_elements+y_axis][x_elements+x_axis] += 1
            end
          end
        end
      end
    end
  end
  # again on grid, search for any elements with values above 9, according to task
  data.map! do |y_elements|
    # x_elements to CHECK to there are any elements with values above 9
    y_elements.map do |x_elements|
      if x_elements > 9
        # true? change them to 0
        # because, as i wrote earlier, there could be happened situation where we can get weird numbers
        x_elements = 0
      else
        # otherwise return just x_elements, that will be prepared for next global increase on board
        # i thought to dump it. more! i though to just use a simple condition to only change numbers above 9 to 0. but 
        # we are constatly changing our data. so we need to return unchanged elements once again to then increase them
        x_elements
      end
    end
  end
  # every time, push energy level to total collection of flashes
  total_flashes << flashes.count
end
# sum all flash count
p total_flashes.sum
# => 1661
