# readline/readlines are the beast! Very powerful tool.

data1 = File.readlines('example.txt').map do |each_line|
  # map or map! - doesn't matter
  # get the rid of delimiter (|) and then we get ... levels in array = multi elements.
  # then we, after each delimeter, we can use another level/element, which is our [1]
  # so [1] = ...content after delimeter. then we get rid of spaces, enters
  each_line.split('|')[1].split(' ')
  # I had respect for creator of advent of code. And in this task, now I don't.
  # difference between data of example and puzzle input. what for is this delimeter? WTF seriously?
  # should I learn extracting data or solving problems???
end

data2 = File.readlines('input.txt').map do |each_line|
  each_line.split('|')[1].split(' ')
end

# so we have a nice array - containing only data, AFTER fucking delimeter = "four digit output value" according to task content
# Task: "Because the digits 1, 4, 7, and 8 each use a unique number of segments,"
# Task: "Because 7 is the only digit that uses three segments"
# Task: "Because 4 is the only digit that uses four segments,"
# Task: "the only digit that uses two segments is 1"
# 8 is the only digit that uses all nine segments
unique_number_of_segments = [2, 3, 4, 7]

# Task: "In the output values, how many times do digits 1, 4, 7, or 8 appear?"
# Task: "Counting only digits in the output values (the part after | on each line)"
# so we have our extracted data. I tried to separate count and flatten.
# chaining with flatten is key. because there is difference in counting our segments with or without flatten
# due to extra brackets of course. so we want to count each segment in the data that is one of a kind of length
# I tried with uniques == segments but it wasn't it.
p data2.flatten.count { |segments| unique_number_of_segments.include?(segments.length) }

#= => 310
