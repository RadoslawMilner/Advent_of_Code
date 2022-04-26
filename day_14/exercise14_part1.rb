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
# according to task: do it 10 times
10.times do
  # once again using alternately false with true we have control on our loop
  # we have loop because of cascade each_with_index on each element
  # moreover alternately we are pushing on specific indexes elements into array
  loop_navigation = false
  # according to task, iterate with template
  polymer_template.each_with_index do |char, index|
    case
      # at the end we need break the loop when we will get nil
    when polymer_template[index+1] == nil
      break
    else
      # otherwise create/build polymer = each element from original template with with each successive element of the polymer being built
      polymer = char + polymer_template[index+1]
    end
    case
      # we can get true condition during inserting elements between pairs
      # this block of code describes the situation where the polymer is built like this: overlapping
      # according to task:
      # "Note that these pairs overlap: the second element of one pair is the first element of the next pair.
      #  Also, because all pairs are considered simultaneously, inserted elements are not considered to be part of a pair until the next step."
    when loop_navigation == true
      loop_navigation = false
    else
      # so iterate with each rule - input
      pair_insertion_rules.each do |rule|
        # if particular present index is equal to first position of element of each rule
        # then change loop
        if polymer == rule[0]
          loop_navigation = true
          # and insert on this particular present index of polymer, each rule element, which is now second position
          polymer_template.insert(index+1, rule[1])
          # and break the loop and then proceed next time=step
          break
        end
      end
    end
  end
end
# tally rocks! that method is doing a whole package!
# task content:
# "Apply 10 steps of pair insertion to the polymer template and find the most and least common elements in the result.
#  What do you get if you take the quantity of the most common element and subtract the quantity of the least common element?"
#  so tally - hash: key: letter, value: how many of this letter, max - most common, min - leat common, substract them. result
p polymer_template.tally.values.max - polymer_template.tally.values.min
# => 4517
