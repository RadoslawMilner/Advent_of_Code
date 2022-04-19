# on start we only want lines and deleted enters ('\n')
# task content: "Find and discard the corrupted lines first."
# we in next step we will use each on each line
# then on those each lines, we will extract separate characters
# by this way we get separate chars
# if we had use chars here, in readlines, we would get array of separate chars
data1 = File.readlines('example.txt').map(&:chomp)
data2 = File.readlines('input.txt').map(&:chomp)
data = data2
# declare middle score array to have place, to get total score
middle_score = []
# task content: 
# "Now, discard the corrupted lines. The remaining lines are incomplete."
data.each do |line|
  # build array to get results of building open chunks. According to task:
  sequence_of_closin_characters = []
  # "Every chunk must open and close with one of four legal pairs of matching characters:
  #
  #  If a chunk opens with (, it must close with ).
  #  If a chunk opens with [, it must close with ].
  #  If a chunk opens with {, it must close with }.
  #  If a chunk opens with <, it must close with >.""
  line.chars.each do |chars|
    case chars
    when '('
      sequence_of_closin_characters << chars
    when '['
      sequence_of_closin_characters << chars
    when '{'
      sequence_of_closin_characters << chars
    when '<'
      sequence_of_closin_characters << chars
    else
      # remove last one and return it to...
      sequence_of_closin_characters.pop
      # use it in next step - score points in autocomplete tools contest
    end
  end
  #  task content: "start with a total score of 0.
  total_score = 0
  # Then, for each character, multiply the total score by 5 and 
  # then increase the total score by the point value given for the character in the following table:
  # each backwards, because we go from closing brackets to opening ones
  # it's a hack. it's simpler
  sequence_of_closin_characters.reverse_each do |chars|
    case chars
      # ): 1 point.
      # ]: 2 points.
      # }: 3 points.
      # >: 4 points."
    when '('
      # task content: 
      # "So, the last completion string above - ])}> - would be scored as follows:
      # Start with a total score of 0.
      # Multiply the total score by 5 to get 0, then add the value of ] (2) to get a new total score of 2.
      # Multiply the total score by 5 to get 10, then add the value of ) (1) to get a new total score of 11.
      # Multiply the total score by 5 to get 55, then add the value of } (3) to get a new total score of 58.
      # Multiply the total score by 5 to get 290, then add the value of > (4) to get a new total score of 294."
      total_score = total_score * 5 + 1
    when '['
      total_score = total_score * 5 + 2
    when '{'
      total_score = total_score * 5 + 3
    when '<'
      total_score = total_score * 5 + 4
    end
  end
  # push completion strings that have total scores to array to in order to go to the next element of the task
  middle_score << total_score
end
# task content: "Autocomplete tools are an odd bunch: the winner is found by sorting all of the scores and then taking the middle score.
#                Find the completion string for each incomplete line, score the completion strings, and sort the scores. 
#                What is the middle score?"
p middle_score.sort![middle_score.size / 2]
# result of example: 288957

# => 1829685989
# "That's not the right answer; your answer is too low.
# If you're stuck, make sure you're using the full input data; 
# there are also some general tips on the about page, or you can ask for hints on the subreddit. 
# Please wait one minute before trying again. (You guessed 1829685989.) [Return to Day 10]"
