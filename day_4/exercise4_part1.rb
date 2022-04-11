# readlines is the best: 1. immediately we get array.
# 2. according to whatever input you get elements just as there are in file content. But there ale always '\n' (due to enters)
# so, get chomp them. You must use chomp with map, because chomp u only with strings. So chomp and map them into array

example_array = File.readlines('example.txt').map(&:chomp)
my_puzzle_input = File.readlines('input.txt').map(&:chomp)
# here you can input your data. that data will be processed later
example_or_input = my_puzzle_input

# gaining nice array of random numbers
# czyli 0, pierwszy element - 1 długi string ze wszystkimi liczbami to mark on boards
# split to gain commas betweeen elements which will be ints.
random_set_numbers = example_or_input[0].split(',').map(&:to_i)

# first after extract our data, we need some fresh boards, when we can operate with them
# declare variable with array. we want somewhere gather our data = numbers on boards

# completed boards << boards
# so it is our start path - here you want to assign name your array, input, data, whatever!
finished_boards = []
# because of breaks between set of numbers and boards and if we want to start build from the third
# line, we need variable (which will increase) with int 2, because we want to start from third position
# set of boards in input, starts in 3rd line
line_counter = 2
# by comparison length of array with starting point, we can at the same time creating new ones boards
# and we have still our break if = break point to stop the loop, because there will be empty lines
while example_or_input.count > line_counter
  # we need to declare 1 board to gather data to this board. then we will push the board data to boards, to have 
  # all numbers in 1 place
  board = []
  # we are doing this 5 times, because we have 5 elements = 5 sets of numbers on each board
  5.times do
    # great chain, by using subsequent lines, we have array with string 1 string - split that string to 5 strings with 1 number
    # map them = change them to array, convert strings to ints.
    # input them to 1 board
    board.push(example_or_input[line_counter].split(' ').map(&:to_i))
    # next line plz ;)
    line_counter += 1
  end
  # put all boards in one board
  finished_boards.push(board)
  # next board
  line_counter += 1
end

def columnSearching(board, right_number)
  # grid 5x5 elements = 0..4 = 5 elements according to index in array
  # but in ruby, we can only read by rows. So we need to create our tops of imaginery columns.
  # our ordinal numbers. 0 (1st column), 1 (2nd column) etc.
  (0..4).each do |column|
    nth_column = []
    # grid 5x5 elements = 0..4 = 5 elements according to index in array
    (0..4).each do |row|
      nth_column.push(board[row][column])
    end
    result = nth_column - right_number
    # so when program checks every number in random set (right_number that comes from wrong numbers that comes from random set)
    # then (row - right_number) , after checking all numbers, its size must be 0
    if result.count == 0
      true
    end
  end
  # this false has to be here! 
  # until we find all numbers of a given row or column, we have to call false to restart the loops
  false
end

# search each row, in each board. Substract that each row with right_number.
# grid 5x5 elements = 0..4 = 5 elements according to index in array
def rowSearching(board, right_number)
  board.each do |row|
    # checking row: that row is true, the and only then, when in that particular row, there are no more numbers to check
    # so when program checks every number in random set (right_number that comes from wrong numbers that comes from random set)
    # then (row - right_number) , after checking all numbers, its size must be 0
    result = row - right_number
    if result.count == 0
      return true
    end
  end
  # this false has to be here! 
  # until we find all numbers of a given row or column, we have to call false to restart the loops
  false
end

def searching_core(board, right_number, nums)
  # if row or collumn have bingo then...
  if rowSearching(board, right_number) or columnSearching(board, right_number)
    # sum. besides we need flatten, because an Array needs to be converted into Int
    # we want to get rid of the extra brackets to get 1 nice array
    sum = (board.flatten - right_number).sum
  end
  # we must checking if sum is nil. we will getting nil until we don't find right numbers. then we can gain 
  # our unmarked numbers. so... nil is kinda our proxy
  if sum == nil
    return nil
  end
  
  p sum * nums
end

# we need two sets of data: numbers that were find
right_number = []
random_set_numbers.each do |nums|
  # we need two sets of data: numbers that weren't find
  right_number.push(nums)
  # on each our completed ready board
  finished_boards.each do |board|
    
    # we need to check if our value is nil. if we don't we will get a various results. 
    # these results will be presenting our sums. but we don't want these all sum! we only need that one. that certain. first sum.
    # first bingo. so we need use nil as a proxy, as a return that don't what to do with it anything.
    # so, right with the sintax of ruby, we have to assign result of method to variable.
    # and then return result these variable then, AND ONLY THEN when this variable is our first bingo.
    # we want to ignore the rest
    outcome = searching_core(board, right_number, nums)
    return outcome unless outcome.nil?
  end
end

# => 28987
# result of example is the same: 4512.
# but when is use my puzzle input, the result is too high

# the resul of course there will muuuch higher that example. just look at the numbers. in the example the numbers don't exceed 30
# in input there are numbers which are close to 100. if we have to multiply these numbers, then the result will be much, much higher!

# the part 2 is blocked for me
