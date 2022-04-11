# I leave a choice. If You need files from example go for it
example_string_array = File.open('example.txt').read
# or use input data
input_string_array = File.open('input.txt').read

data = input_string_array

# here are our entry variables = our building area of arrays
mybinary_array = [0, 0]
myarray = []
# on each line
data.each_line do |string|
  # we are using split to gain an array (and an array, and an array...etc) with accessible singles integers
  # parametr ('') for split is crucial - thanks to it we can gain multi-accessible singles integers
  # we have to use chomp to dispose of gaps between sets of numbers
  myarray.push(string.chomp.split(''))
end
# we are creating a new array from our fresh created array
# we are going to use each, on each array of bits
# one more time, we need to move our new / range array back one position because of 0
# we have to also create array with most common bits, before the each.
# we want to gather data to most-common-bits array. NOT TO dynamic modfiy it constantly
most_common_bits = []
(0..myarray[0].count-1).each do |bit|
  myarray.each do |most_bit|
    # of course our myarray is all string so we need integers
    case most_bit[bit].to_i
      # when 0 occures then increment first postion in array 0_1
    when 0
      mybinary_array[0] += 1
      # when 1 occures then increment second postion in array 0_1
    when 1
      mybinary_array[1] += 1
    end
  end
  # here we try to find gamma_rate
  # task quote:
  # "Each bit in the gamma rate can be determined by finding
  # the most common bit in the corresponding position of all numbers
  # in the diagnostic report"
  # so we compare elements in our binary array with themselves
  # and pushing them into right places
  if mybinary_array[0] > mybinary_array[1]
    most_common_bits.push(0)
  else
    most_common_bits.push(1)
  end
  mybinary_array = [0, 0]
end
# to gain our at least common bits, instead we calculate them
# (just as we calculated our most common bits)
# we can reverse the result of the most common bits
least_common_bits = []
most_common_bits.each do |least_bit|
  case least_bit
  when 0
    least_common_bits.push(1)
  when 1
    least_common_bits.push(0)
  end
end
# Each bit in the gamma rate can be determined by the most common bit in the diagnostic report
# The epsilon rate is calculated in a similar way; the least common bit from each position is used
# we need to convert binary numbers to decimal
# first we are converting our arrays to strings by join
# then we are converting this strings to integers by using base 2
# because we want to calculate - convert our binary data into decimal data
# e.g. [1, 0, 1, 1, 0] = 1*2^4 + 0*2^2 + 1*2^1 + 0*2^0
gamma_rate = most_common_bits.join.to_i(2)
epsilon_rate = least_common_bits.join.to_i(2)

# at the end, according to task content, multiply gamma rate with epsilon rate
consumption = gamma_rate * epsilon_rate
puts consumption

# => 3148794
