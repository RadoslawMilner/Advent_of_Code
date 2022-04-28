# readrows is the best: we get array. chomp enters. remove spaces
data1 = File.readlines('example.txt').map(&:chomp).map { |string| string.split(" ") }
data2 = File.readlines('input.txt').map(&:chomp).map { |string| string.split(" ") }
data = data2

# define start scoring
final_score = 0
# take card_numbers at start = remove first draw card_numbers and push them into new variable. remove commas. remove extra brackets.
numbers_to_draw = data.shift.map { |integer| integer.split(',') }.flatten
# remove unnecessary brackets
data.delete([])
# declare place to collect all bingo cards
bingo_cards = []
# each_slice - FTW!
# one method ...one method that hold almost whole exercise!
# each_slice is exactly what we need for this task
# its great way to get exactly each board. each board(mini array) push into one place where are all boards
data.each_slice(5) { |board| bingo_cards << board }

# if the task is more complex, methods are useful
def marked_numbers?(card)
  # we have here double check
  # first check is important
  # because it is still part of loop below
  # first check its part of a whole
  card.each do |row|
    # if there are row with all elements that are marked?
    if row.all? { |char| char.include?('-marked number') }
      return card
      # return that card to bingo manager
    end
  end
  # each card has 5 rows. iterate each card to push results to variable that is telling us that this card was checked
  # second check is simple - go 5 times(5 rows) on each card.
  # moreover first check give us parameter - row to pass it on
  # check them all the time
  # check each card in bingo game
  5.times do
    checked_row = []
    card.each_with_index do |row, index|
      checked_row << row[index]
    end
    if checked_row.all? { |char| char.include?('-marked number') }
      return card
    end
  end
end

# whole proccess of bingo
# draw numbers from global access
numbers_to_draw.each do |global_int|
  case
    # result cannon be negative
    # just need of start scoring - which will be always greater than 0
    # it's just breakpoint of loop 
    # break loop <= start scoring <= found first 5 marked numbers
  when final_score > 0
    break
  else
    # main engine - all bingo cards
    bingo_cards.each do |card|
      # each card of bingo game
      card.each do |row|
        # each row of each card
        row.each do |card_number|
          # if there is a match between drawn numbers and number on specific card
          if card_number == global_int
            # then mark that number - add to its string some string
            # concat - a new tool
            # this is one of ways to mark numbers
            # all elements are strings. add to those right numbers string - proof of being marked
            card_number.concat('-marked number')
          end
        end
      end
      # final result is here
      # when size of row is 5
      # start scoring the rest
      if marked_numbers?(card).size == 5
        scoring = []
        # in each card
        card.each do |row|
          # check each row of that card
          row.each do |card_number|
            # negative of include = exclude X-es
            # if it had been rails I would use exclude? or excluding
            # score everything else exlcude marked numbers
            unless card_number.include?('-marked number')
              # change all strings to ingegers to sum them - to distinct difference between drawn numbers, card numbers and marked numbers
              # we didn't use change to integer earlier
              scoring << card_number.to_i
            end
          end
        end
        # task content:
        # "Start by finding the sum of all unmarked numbers on that board; 
        #  in this case, the sum is 188.
        #  Then, multiply that sum by the number that was just called when the board won, 24, to get the final score, 188 * 24 = 4512."
        # our last integer = results from breaking the loop because score will be greater than 0. 
        # Moreover, the score is counted after condition is met: card.size == 5 && include chars with marked numbers
        p final_score = scoring.sum * global_int.to_i
      end
    end
  end
end
# => 30052
# once again - still part 2 is blocked for me
# example is the same, but my answer is still too high
# once again - answer will be muuuuch hiiigheer than example - input numbers are much larger than example
