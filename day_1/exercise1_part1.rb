# it irritates me that at first tasks i had little knowledge
# example: lack of knowledge about File.read
# so readlines, each integer,remove enters, change to integers
data1 = File.readlines("example.txt").map(&:chomp).map(&:to_i)
data2 = File.readlines("input.txt").map(&:chomp).map(&:to_i)
data = data2

# the task is to compare the next measurement with the previous one
# and then calculate the number of increases in the measurements relative
# to the previous measurements
# # so we create variable called start with value 0

start = 0

# now, this task is super easy
# go with each index of our data. just it. no range. no complicated stuff
data.each_with_index do |number, index|
  case
    # when program will iterate last position
    # break the loop
    # to no get 1 unnecessary increment
  when data[index + 1] == nil
    break
    # otherwise comparing each next position with previous position
  when data[index + 1] > number
    # if it is larger, then increment counter
    start += 1
  end
end
# return final number of increments
p start
# => 1390
