# I leave a choice. If You need files from example go for it
example_string_array = File.read('example.txt')
# or use input data
input_string_array = File.read('input.txt')

data = input_string_array

# here are ours starter variables
# we want to changle a little bit our starter variables, because of aim
# our aim is straight upgrade
forward = 0
depth = 0

# here is our new upgrade - new variable: aim
aim = 0
# we will need our array
myarray = []
# through each line... 
data.each_line do |string|
  # and thanks each line we can now split each line to separate paragraphs
  # accessed data is transfered to our fresh new array
  myarray.push(string.split())
end
# through each element in our array...
myarray.each do |integer|
  # we have separated strings and we can use them depending on our needs
  # first we extract only movements - "strings"
  # we want from array to return a string with each line
  case integer[0]
  when "forward"
    # then string our next 'string integers', we are converting to integers
    # we are also upgrading this case according to the content of the task:
    # " forward X does two things:
    #   It increases your horizontal position by X units.
    #   It increases your depth by your aim multiplied by X."
    forward += integer[1].to_i
    depth += aim * integer[1].to_i
  when "down"
    # here we have one aim instead of up / down - we are calculating it and we are attaching it to only aim
    aim += integer[1].to_i
  when "up"
    aim -= integer[1].to_i
  end
end
# here is our data
forward_total = forward
depth_total = depth
  
# and we calculate our result
puts forward_total * depth_total

# => 1282809906
