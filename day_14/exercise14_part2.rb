# each line get rid of '\n' & ' -> '
data1 = File.readlines('example.txt').map(&:chomp).map { |s| s.split(' -> ') }
data2 = File.readlines('input.txt').map(&:chomp).map { |s| s.split(' -> ') }
data = data1
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
  paired_rules[k] = [k[0] + v, v + k[1]]
end
# Ok. Part2. Brute force doesn't work = can't copy part1 and change it to 40times.
# the same situation as in day6
# we need to work on data
# build an array to gather... to collect the number of occurrences of par
polymer = []

polymer_template.each_with_index do |char, index|
  case
    # at the end we need break the loop when we will get nil
  when polymer_template[index+1] == nil
    break
  else
    # otherwise create/build polymer = each element from original template with with each successive element of the polymer being built
    polymer << char + polymer_template[index+1]
  end
end
# ... to collect the number of occurrences of par (tally is awesome)
polymer.tally
# at present I don't know how to do it.
