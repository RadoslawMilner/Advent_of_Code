# readlines is the best: 1. immediately we get array. or readline in case of one line data. 
# but i see that readlines/readline don't like split. I don't know that readline/readlines can be put to open method such as optional parameters
# just as convert to integers with map

data1 = File.open('example.txt', &:readline).split(',').map(&:to_i)
data2 = File.open('input.txt', &:readline).split(',').map(&:to_i)

# depending of example data or input and number of days, choose data
# rather than using directly input, build array from scratch
# then increment start fields in that array.
if data2
  # create empty array with 9 fields. because new fish is create after 8 days. so we need 8 fields to storage 9 numbers
  # moreover we need extra field for 0. So we gather 9 fields
  old_array = [0,0,0,0,0,0,0,0,0]
  # each internal timer in data (element) sets out field in new array where we should increment that field
  data2.each do |internal_timer|
    old_array[internal_timer] += 1
  end
  
  # times = days, according to task content
  256.times do
    # once again create "empty" array - we will need it to put it into old_array
    new_day_array = [0,0,0,0,0,0,0,0,0]
    # use first element in first array to put it into new array, on last, nineth position
    # also do it the same to put it on 7th position
    new_day_array[8] = old_array[0]
    new_day_array[6] = old_array[0]
    # use each on range. 
    # "A lanternfish that creates a new fish resets its timer to 6, not 7 (because 0 is included as a valid timer value).
    # The new lanternfish starts with an internal timer of 8 and does not start counting down until the next day."
    (1..8).each do |internal_timer|
      p new_day_array[internal_timer - 1] += old_array[internal_timer]
    end
    # put subsequent data to one gathering array
    p old_array = new_day_array
  end
# rather than count elements in array (fish), we gather all fish to one basket and sum them (sum values of elements)
p old_array.sum

end

# => 1595330616005
