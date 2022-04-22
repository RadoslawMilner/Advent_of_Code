# unbeatable readlines. swap chomp to strip - its shorter. dump '-'
data1 = File.readlines('example.txt').map { |paths_with_small_caves_most_once| paths_with_small_caves_most_once.strip.split('-') }
data2 = File.readlines('input.txt').map { |paths_with_small_caves_most_once| paths_with_small_caves_most_once.strip.split('-') }
data = data2
# declare hash - our stard-path-end array need hash
cave_system = Hash.new
data.each do |key, value|
  # I searched this way to build THIS hash definitely tooo looong!
  # at last! in situation where u need to put X values and you have elements in array that repeat
  # there is always one type of key. iterate each element of array. next push those elements into: 
  # value of key OR empty space. these values ​​enter the prepared places and are taken by the key
  cave_system[key] = (cave_system[key] || []) << value
  # key for values OR empty space for that key. these values ​​enter the prepared places and are for the key
  # there is no problem with duplicate values. there is massive problem where we have duplicate potential keys in array
  cave_system[value] = (cave_system[value] || []) << key
  # if we had pushed keys first, before values, then we would receive reversed input version
end

# EVERY POSSIBLE outcome = paths_with_small_caves_most_once = gather to array
paths_with_small_caves_most_once = []
# our proxy - NON-orignal start, to start a loop
start = [["start"]]
# our simultaneous condition for loop AND breakpoint
while start.size > 0
  # the keys of cave system are a filter. Most important are data=input=elements=values
  # with every done loop, reset array, basket with possible outcomes to gather a new ones
  possible_outcomes = []
  start.each do |path|
    # input iterate through everyone VALUE! of keys - no i te elementy są dodawane do patha który jest arrayem
   cave_system[path[-1]].each do |input|
    # using start, which is need to initialize this loop AND to build paths - each path need a start at begining - each possible outcome
      case
      when input == 'start'
        next
        # input and path are very distinct
        # there is our defined path=start which is our proxy, not orignal start
        # and there are orignals = elements of input/data = values of keys (our filters)

        # huge one filter, that must meet several requirements at the same time (thats why it is chain)
        # when these path, which we are building (so...it can't happen at the first, second loop) include input
        # when this input is NOT the end AND when it is a small cave AND if elements of these path include any small caves that were visited more than once
        # at the end (these small hash - its only a filter which allow us to simply and smart navigate and selects data)
      when path.include?(input) && (input != 'end' && input.downcase == input && path.tally.select {|key,value| key.downcase == key }.any? {|key,value| value > 1 })
        next
        # gluing of paths - 2 types of gluing those paths
      when input == 'end'
      # according to task: paths with small caves that were visited MAX ONCE
        paths_with_small_caves_most_once << (path + [input])
      else
      # AND possible_outcomes (ALL) where are given ALL combinations WHICH ARE DON'T that do not meet the requirements of the task
        possible_outcomes << (path + [input])
      end
    end
  end
  # gather to basket next elements
  # so that to gather a next different possible outcomes
  # after filters, next they go into paths_with_small_caves_most_once where are the right ones - according to task demands
  start = possible_outcomes
end
# task content: "Your goal is to find the number of distinct paths_with_small_caves_most_once that start at start, end at end, and don't visit small caves more than once. 
# There are two types of caves: big caves (written in uppercase, like A) and small caves (written in lowercase, like b).
# [...] So, all paths_with_small_caves_most_once you find should visit small caves at most once, and can visit big caves any number of times."

# task content: "How many paths_with_small_caves_most_once through this cave_system are there that visit small caves at most once?" - discarding small caves
# long chain: according to task content: choose paths_with_small_caves_most_once, where strings of these paths_with_small_caves_most_once are NOT up case. then count those paths_with_small_caves_most_once.
# then check if all these paths_with_small_caves_most_once have been visited once.
selected = paths_with_small_caves_most_once.select { |path| path.select { |str| str.upcase != str }.tally.values.all? { |values| values == 1 } }
# if all those smalls cases are ones, then return true. select those with true and large ones = 
# = thats why we need 2 select.
# = return to me those small ones AND MOREOVER THOSE small ones which are ones.

# count those paths_with_small_caves_most_once
p selected.size

# huh, that was something - my device need a few seconds to breakthrough input with this loop.
# => 4720
