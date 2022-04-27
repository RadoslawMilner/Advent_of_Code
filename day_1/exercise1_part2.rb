# it irritates me that at first tasks i had little knowledge
# example: lack of knowledge about File.read
# so readlines, each integer,remove enters, change to integers
data1 = File.readlines("example.txt").map(&:chomp).map(&:to_i)
data2 = File.readlines("input.txt").map(&:chomp).map(&:to_i)
p data = data2

# in this task, first we need to extract / create multi smaller arrays from the main array (our measurements)
# each minor array needs to has 3 values

# once again we create variable called start with value 0
# this variable will give us the number of times
# the sum of measurements in this sliding window increases 
# by comparing current sum with previous ones

start = 0 
# go with each index of our data. just it. no range. no complicated stuff
data.each_with_index do |number, index|
   # when program will iterate last position + 3 position further (according to task = three measurement window)
    # break the loop
    # to no get 1 unnecessary increment
  if data[index + 3] == nil
    break
  end
    # otherwise comparing each next position with previous position
    # first element to compare = each element of data + position next + third position
  three_measurement_window = number + data[index + 1] + data[index + 2]
  # second element to compare = each position next + third position + fourth position
  next_three_measurement_windown = data[index + 1] + data[index + 2] + data[index + 3]
  # if next is greater than previous one, increment
  if next_three_measurement_windown > three_measurement_window
    start += 1
  end
end

p start
# => 1457
