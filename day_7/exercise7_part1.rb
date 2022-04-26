# read file, remove commas, change to integers
data1 = File.read('example.txt').split(',').map(&:to_i)
data2 = File.read('example.txt').split(',').map(&:to_i)
data = data2
# put array which will gather our possible outcomes - i need an array to use on it method: minimal - to get the cheapest possible fuel outcome
cheapest_possible_outcome = []
# below, one line is clue of the task. its main core of this program
# range from minimal values of input and maximal. go through each of these.
# we will get minimal and maximal of horizontal positions - there are our ...
# we try find our: 
# "You could choose any horizontal position to align them all on, but the one that costs the least fuel is horizontal position 2:"
# our: the least fuel horizontal positions, which we can use to calculate outcomes.
# we go each all min/max with all each values. all through all.
(data.min..data.max).each do |range_min_max_position|
  # we have to have place where we can gather possible outcomes fuel spent
  possible_outcomes = 0
  # as in the example, we go through each horizontal position to calculate fuel spent
  data.each do |each_particular_position|
    crabs_moving = (each_particular_position - range_min_max_position).abs
    # as in example, there are of course possible outcomes where we have difference with subtract smaller value and larger
    # we want to get difference with these two values. so we have to use absolute method on it.
    # then put these various into variable which tell us about various outcomes
    # thanks to increment, we are constantly adding to "basket" subsequent variables
    possible_outcomes += crabs_moving
  end
  # push all gathered spent/cost values to previosly created array    
  cheapest_possible_outcome << possible_outcomes
end
# we need to get: "Determine the horizontal position that the crabs can align to using the least fuel possible.
#                  How much fuel must they spend to align to that position?"
p cheapest_possible_outcome.min
# => 345035
