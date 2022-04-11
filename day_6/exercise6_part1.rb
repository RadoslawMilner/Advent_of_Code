# readlines is the best: 1. immediately we get array. or readline in case of one line data. 
# but i see that readlines/readline don't like split. I don't know that readline/readlines can be put to open method such as optional parameters
# just as convert to integers with map

data1 = File.open('example.txt', &:readline).split(',').map(&:to_i)
data2 = File.open('input.txt', &:readline).split(',').map(&:to_i)
data256 = File.open('example.txt', &:readline).split(',').map(&:to_i)
# this task is a milestone in my new ruby ​​career.
# when I read the content of this exerc. it was so shitty written that I stopped reading halfway.
# I looked at the exponential example of creating fish. and immediately i understand that process.
# Its a simply proof that i learn more effiecient and quickly if i see some examples, solutions, well-worn path,
# than waste time to search and dig into docs and next trying to create something.
# I am not inventor. Its not a purpose. certainly not as a junior. And then someone has a nerve to tell me that he/she achieved this exercises in very short time
# while that person had for example 4 years experience in that field.

# depending of example data or input and number of days, choose syntax below
# (times = days)
if data1

  18.times do
    # declare array to gather extra fish = newborn fish? just-created fish?
    fish = []
    # we cannot go with just each, because we seriously need that index
    # thanks to that index we can use its parameter to navigate through data
    data1.each_index do |i|
      # if for example third position in our array (fish[2]) is 0 ? change it to 6 according to task content
      if data1[i] == 0
        data1[i] = 6
        # moreover whenever internal timer expires, then is creating a new fish. with value 8. according to task content
        # task content: "The new lanternfish starts with an internal timer of 8 and does not start counting down until the next day."
        # that's why this syntax-line? is the last in class:integer method: times.
        # ruby syntax doesn't allow for array += 8. then: "undefined method `+' for nil:NilClass (NoMethodError)"
        fish.push(8)
      else
        # otherwise decrease any others elements that are not close to ending of internal timer
        data1[i] -= 1
      end
    end
    # here we want to add subsequent parts (new-born fish) to our huge array
    p data1 += fish
  end
  # "In this example, after 18 days, there are a total of 26 fish" = count elements (all-fish = "old" and "new") in array
  p data1.size
end

# => 26

# if input, do it the same for 80 days
if data2

  80.times do
    fish = []
    data2.each_index do |i|
      if data2[i] == 0
        data2[i] = 6
        fish.push(8)
      else
        data2[i] -= 1
      end
    end
    data2 += fish
  end

  p data2.size
end

# => 351092

# i don't understand concept of this task. maybe I am wrong, but this look like a simple benchmark test of the device you are working on.
# if you have powerful device, you will get result in simple way
# in another case you have modify the code
# in my case below code DON'T WORK

# if data256

#   256.times do
#     fish = []
#     data256.each_index do |i|
#       if data256[i] == 0
#         data256[i] = 6
#         fish.push(8)
#       else
#         data256[i] -= 1
#       end
#     end
#     p data256 += fish
#   end

#   p data256.size
# end
