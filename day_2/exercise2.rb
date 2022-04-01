# I leave a choice. If You need files from example go for it
example_string_array = File.open('example.txt').read
# or use input data
input_string_array = File.open('input.txt').read

def vertical_x_horizontal(string_array)

  # here are ours starter variables
  forward = 0
  down = 0
  up = 0
  # we will need our array
  myarray = []

  # through each line we are splitting our data into pararagraphs 
  string_array.each_line do |string|
    # accessed data is transfered to our fresh new array
    myarray.push(string.split())
  end

  # through each element in our array...

  myarray.each do |i|
    # we have separate strings and we can use them depending on our needs 
    case i[0]
    when "forward"
      forward += i[1].to_i
    when "down"
      down += i[1].to_i
    when "up"
      up += i[1].to_i
    end
  end

  # here is summary our data
  forward_total = forward

  depth_down = down
  depth_up = up
  
  depth_total = depth_down - depth_up
  
  # and we calculate our result
  puts forward_total*depth_total
end

vertical_x_horizontal(input_string_array)

# => 1480518
