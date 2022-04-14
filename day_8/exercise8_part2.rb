# part 2 - unifinished
# We can decode 1, 4, 7, and 8 digits by looking at the count of the characters.
# 2, 3, 5 digits have five character lenghts
# 6, 9, 0 digits have six character lenghts
# THE ABSOLUTE CLUE AND SOLVING THIS TASK is:
# in unique signal patterns, there are 3x digits five character lenghts. If we can find pattern, then using unique segments, we can decode five characters
# in unique signal patterns, there are 3x digits six character lenghts. If we can find pattern, then using unique segments, we can decode five characters

# today (13.04) I learned that there is possibility of using underscore...
# a = [1,2,3,4] ~ some array
# a.each { |parameter| argument }
# a.each { _ } or a.each { _1 } or a.each { _9 }
# the result of these each is the same

data1 = File.readlines('example.txt').map(&:chomp)
data2 = File.readlines('input.txt').map(&:chomp)
# depending of choice data...
data = data1

## def read_signal_patterns_and_outputs

# due to task content, we are having two types of data in our example/input which are divided by pipe | (delimeter)
# - ten unique signal patterns
# - four digit output value
data.map! { |segments| segments.split('|') }
ten_unique_signal_patterns = data.map { |segments| segments[0].split(' ') } # - first[0] - before delimeter
four_digit_output_value = data.map { |segments| segments[1].split(' ') } # - second[1] - after delimeter

# divide each string of data (segment) to separate characters
ten_unique_signal_patterns.map! { |elements| elements.chars }
four_digit_output_value.map! { |elements| elements.chars }

# we have to use our converted data and go through each with first part, which is for decoding segments
ten_unique_signal_patterns.each do |x|

# gathering decoded segments in one place
decoding_segments = []
# "What do you get if you add up all of the output values?"
output_values = 0
# those are easy - there are our unique segments
# with their help, we can eliminate subsequent segments and search for the more difficult, more complex numbers
decoding_segments[1] = signal_patterns.find { |segment| segment.count == 2 }
decoding_segments[4] = signal_patterns.find { |segment| segment.count == 4 }
decoding_segments[7] = signal_patterns.find { |segment| segment.count == 3 }
decoding_segments[8] = signal_patterns.find { |segment| segment.count == 7 }

# i have no idea how to write it
# with Mentor, we eliminated particular segments. Started with 1 beacuse it always use 2 segments in one line, that are on one side
# 7 is too very characteristic = because it's a one with little roof
decoding_segments[2] = signal_patterns.find { |segment| segment.count == 5 }
decoding_segments[3] = signal_patterns.find { |segment| segment.count == 5 }
decoding_segments[5] = signal_patterns.find { |segment| segment.count == 5 }
decoding_segments[6] = signal_patterns.find { |segment| segment.count == 6 }
decoding_segments[9] = signal_patterns.find { |segment| segment.count == 6 }
decoding_segments[0] = signal_patterns.find { |segment| segment.count == 6 }

# call decoded segments
return decoding_segments

# waiting for code to gather numbers to then sum them up
output_values_sum =
# "What do you get if you add up all of the output values?"
p output_values.sum
end