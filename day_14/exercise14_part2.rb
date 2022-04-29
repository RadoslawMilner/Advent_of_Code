# each line get rid of '\n' & ' -> '
data1 = File.readlines('example.txt').map(&:chomp).map { |s| s.split(' -> ') }
data2 = File.readlines('input.txt').map(&:chomp).map { |s| s.split(' -> ') }
data = data2
# first line = first element
# first element array change to string
# string change to array of individual elements
polymer_template = data[0].join.chars
# put rest elements, starting from 3rd line
pair_insertion_rules = data[(2..)]
# the situation with this task is absolutely the same just as with task with fish(day6)
# "it sounds great, it doesn't work" ;)
# 40.times doesn't work = brute force doesn't work
# so build a hash with ready pairs
paired_rules = Hash.new
# take rules. key = rule. value = array that include to elements. these two elements are:
# first: first pair with rule
# second: second pair with rule
# for example: CH -> B.  CH => [CB, BH]
# element of the task/example/input/data should be inserted between rules elements
pair_insertion_rules.each do |k,v|
  # there is no ruby method that give us last char from string
  # in rails there is = just #last
  paired_rules[k] = [k.chr + v, v + k[1]]
end
# Ok. Part2. Brute force doesn't work = can't copy part1 and change it to 40times.
# the same situation as in day6
# we need to work on data
# build an array to gather... to collect the number of occurrences of par
large_keys = []

polymer_template.each_with_index do |char, index|
    # at the end we need break the loop when we will get nil
    polymer_template[index + 1] == nil ? break : ( large_keys << char + polymer_template[index + 1] )
    # otherwise create/build polymer = each element from original template with with each successive element of the polymer being built
end
# ... to collect the number of occurrences of par (tally is awesome)
large_keys = large_keys.tally

# Extract and count all possible pairs 40 times = how many times all possible pairs appear
# storage value is needed due to the fact that we are dealing with a hash
# map don't iterate with hash

# storage value
40.times do

  storage = Hash.new

  large_keys.each do |key, value|
    paired_rules[key].each do |pair|
      # if there is already a key, count. if not, stay the same until another key is dropped =
      # = another pair will drop to be saved
      storage.has_key?(pair) ? ( storage[pair] += value ) : ( storage[pair] = value )
    end
  end
  # into storage value
  large_keys = storage
end

# then divide these pairs and count the number of times the letter appears
# split the keys - pairs left and right
# to extract them and count them one by one
# value += add
# value = stay and wait
# check if our new storage value has any keys so that it can be counted - put the values to be counted into the basket
# consider 2 case categories - each one for each letter of each pair

# storage value
minor_keys = Hash.new

large_keys.each do |key, value|
  # so we basically do the same as for 40 times
  # we still check if they have the keys, but at the same time we break it down into two conditions
  # into two smaller keys and we're still counting values - counting of letters
  minor_keys.has_key?(key[0]) ? ( minor_keys[key[0]] += value ) : ( minor_keys[key[0]] = value )
  minor_keys.has_key?(key[1]) ? ( minor_keys[key[1]] += value ) : ( minor_keys[key[1]] = value )
end
# storage value
occuring = Hash.new

# as our goal was to single out each letter
# that is, break the KEY into key and key
# but we have 2 times more values, because we have times more keys
# so we need to reduce numbers by 2 = by count of minor keys
# ceil = is because these numbers are astronomical
# so we need to get whole integers

minor_keys.each do |key, value|
  occuring[key] = (value / 2.0).ceil
end

# tally rocks! that method is doing a whole package!
# task content:
# "Apply 40 steps of pair insertion to the polymer template and find the most and least common elements in the result.
#  What do you get if you take the quantity of the most common element and subtract the quantity of the least common element?"
# we are still dealing with hash, so extract values of keys and then subtract larger one with smaller
p occuring.values.max - occuring.values.min
# => 4704817645083
