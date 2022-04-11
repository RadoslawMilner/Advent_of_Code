# I leave a choice. If You need files from example go for it
example_string_array = File.open('example.txt').read
# or use input data
input_string_array = File.open('input.txt').read
data = input_string_array

# once again we are creating our array, from data
# we are using split to access to independent integers
myarray = data.split
# first, we want to get the most common value
# so are using our extracted data
# we want to create new array, 
# because we will need to use our input data once again for least_common_value
# albo, we are changing input data into characters, because then we can operate them more easily
most_common_value = myarray.map(&:chars)
# using chaining below we are returning up to 12 times (in case of example input) our array
# there 12 numbers in example = .length
# using .times = 12 = .length
# [0] - we are starting from the beggining
most_common_value[0].length.times do |bit|
  # according to task content "As there is only one number left, stop;"
  max_bit = "1"
  # we need variable to gather counting our numbers
  we_are_counting = most_common_value.count { |most| most[bit] == "0" }
  
  # and here is our filter
  # from if, through select, ending with break if, by using our length of most common values,
  # which are divided by 2 with decimals
  if we_are_counting > most_common_value.length / 2.0
    max_bit = "0"
  end
      
  # the chain command, using select, checks and search max bit - our condition to stop counting
  most_common_value.select! { |most| most[bit] == max_bit }
  
  # of course we want to stop our counting if there will be only one number left
  # as it is in the content of the task
  break if most_common_value.length == 1
end
# now we are converting binary numbers to decimal by
# changing them into strings, merging them in one number and next to to bits with base 2
oxygen_generator_rating = most_common_value.join.to_i(2)
# second, now we want to get at least common value
# so are using our extracted data, by the same way, as for the most common data
least_common_value = myarray.map(&:chars)
# once again - we are returning our (second-new) array up to 12 times (in case of example input)
least_common_value[0].length.times do |bit|
  max_bit = "0"
  # we need variable to gather counting our numbers
  we_are_counting = least_common_value.count { |least| least[bit] == "1" }
  # and here is our filter
  # from if, through select, ending with break if, by using our length of most common values,
  # which are divided by 2 with decimals
  if we_are_counting < least_common_value.length / 2.0
    # according to task content "As there is only one number left, stop;"
    max_bit = "1"
  end
  # the chain command, using select, checks and search max bit - our condition to stop counting
  least_common_value.select! { |least| least[bit] == max_bit }
  # of course we want to stop our counting if there will be only one number left
  # as it is in the content of the task
  break if least_common_value.length == 1
end
# now we are converting binary numbers to decimal by
# changing them into strings, merging them in one number and next to to bits with base 2
c02_scrubber_rating = least_common_value.join.to_i(2)
# according to task content we multiply our ratings
life_rating = oxygen_generator_rating * c02_scrubber_rating
puts life_rating

# => 2795310
