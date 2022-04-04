# I leave a choice. If You need files from example go for it
example_string_array = File.open('example.txt').read
# or use input data
input_string_array = File.open('input.txt').read

def final_score(string_array)

    # we divide our input into seperate, small strings. Each containing a number
    # [0] - on start to emphasize array. Moreover for numbers [0] is key, because it extracts only these random numbers without boards
    # Interestingly, second split does matter. Without the are strange output on the end of the array
    # At last we use map - create new array with strings which are changed to integers
    numbers = string_array.split("\n")[0].split(",").map(&:to_i)
    # we use \n\n because we need breaks between next boards
    # [1..] we are taking first board (without random numbers) to end of input
    # So... in conclusion we duplicate exactly our input.txt
    boards = string_array.split("\n\n")[1..]
    # change array=boards into seperate rows - each row will be separate string element in array=board
    boards.map! { |to_strings| to_strings.split("\n") }
    # each array split to gain breaks and changing everything into integers=
    boards.each do |board|
      board.map! { |current_string| current_string.split(" ").map!(&:to_i) }
    end
    # CLUE - MAIN CORE
    # change our boards into our defined bingo board
    # with help our bingo board, we return our new array which content numbers and boards
    boards.map! { |grid| Bingo.new(grid) }
    [ numbers, boards]
      
    numbers = string_array[0] # just like before, we want to get only random numbers
    boards = string_array[1] # just like before, we want to get boards
    # we are preparing some variables to get our result
    winning_board = nil
    current_number = nil
    # when current number is NOT nil, then first part of input = numbers.shift
    # which means retrieve and at the same time remove the first number
    # then we want to go with each element in boards by mark that number, which popped off
    # (we defined mark in another class: bingo - we are searching matching number)
    while !winning_board
      current_number = nums.shift
      boards.each do |board|
        board.mark(current_number)
        # if that searching row/column in board is completed, then transfer that board to variable
        # winning board
        if board.completed?
          winning_board = board
          # also it is our key to break the loop
        end
      end
    end

    # then return that winning board with our defined method, which sum and flatten our rows in that board
    sum_of_numbers_in_board = winning_board.sum_of_all_unmarked_numbers
    puts sum_of_all_unmarked_numbers * current_number
  
end

final_score(example_string_array)

# unfinished - all of it needs to wrap in the class, because now we cannot use another class (bingo)
# moreover, we would define some methods: 1. converting data into numbers and arrays. 2. running input. 3. running solution with input.
# 4. method that allows us to gain access to input/data and which will fire up solution
