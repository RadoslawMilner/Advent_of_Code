# readlines is the best. 1 = immediately we get array.
# 2 according to whatever input you get elements just as there are in file content. But there ale always '\n' (due to enters)
# so, get chomp them. You must use chomp with map, because chomp u only with strings. So chomp and map them into array
example_array = File.readlines('example.txt').map(&:chomp)
# my_puzzle_input = File.readlines('input.txt').map(&:chomp)

# gaining nice array of random numbers
# czyli 0, pierwszy element - 1 długi string ze wszystkimi liczbami to mark on boards
# split to gain commas betweeen elements which will be ints.
random_set_numbers = example_array[0].split(',').map(&:to_i)

# first after extract our data, we need some fresh boards, when we can operate with them
def building_boards(array)
  # declare variable with array. we want somewhere gather our data = numbers on boards
  boards = []
  # because of breaks between set of numbers and boards and if we want to start build from the third
  # line, we need variable (which will increase) with int 2, because we want to start from third position
  # set of boards in input, starts in 3rd line
  line_counter = 2
  # by comparison length of array with starting point, we can at the same time creating new ones boards
  # and we have still our break if = break point to stop the loop, because there will be empty lines
  while array.length > line_counter
    # we need to declare 1 board to gather data to this board. then we will push the board data to boards, to have 
    # all numbers in 1 place
    board = []
    # we are doing this 5 times, because we have 5 elements = 5 sets of numbers on each board
    5.times do
      # great chain, by using subsequent lines, we have array with string 1 string - split that string to 5 strings with 1 number
      # map them = change them to array, convert strings to ints.
      # input them to 1 board
      board.push(array[line_counter].split(' ').map(&:to_i))
      # next line plz ;)
      line_counter += 1
    end
    # put all boards in one board
    boards.push(board)
    # next board
    line_counter += 1
  end
  # complete our data
  boards
end

# completed boards << boards
finished_boards = building_boards(example_array)

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

def final_score(random_set_numbers, finished_boards)
  # we need two sets of data: numbers that were find and numbers that didn't
  right_number = []
  sum = 0
  
  random_set_numbers.each do |nums|
    
    # we need two sets of data: numbers that were find and numbers that didn't
    right_number.push(nums)
    finished_boards.each do |board|

      if rowSearching(board, right_number) or columnSearching(board, right_number)
      # sum. besides we need flatten, because an Array needs to be converted into Int
      # we want to get rid of the extra brackets to get 1 nice array
      # most important we need to get rid of right numbers if we want to get only unmarked numbers
      sum = (board.flatten - right_number).sum
      end
    end
    sum * right_number.last
  end
end

p final_score(random_set_numbers, finished_boards)
