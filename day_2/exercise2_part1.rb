# I leave a choice. If You need files from example go for it
example_string_array = File.open('example.txt').read
# or use input data
input_string_array = File.open('input.txt').read

data = input_string_array

# here are ours starter variables
forward = 0
down = 0
up = 0
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
    forward += integer[1].to_i
  when "down"
    down += integer[1].to_i
  when "up"
    up += integer[1].to_i
  end
end

# here is summary our data
forward_total = forward

depth_down = down
depth_up = up

depth_total = depth_down - depth_up

# and we calculate our result
puts forward_total * depth_total

# => 1480518
