# Due to wrong result of previous code (example was the same, but result of input was wrong)
# I have to rebuild my code
# get data, parse data, remove '\n'
data1 = File.readlines('example.txt').map(&:chomp)
data2 = File.readlines('input.txt').map(&:chomp)
data = data2

# define 1st method
# search and remove corrupted lines to get only incomplete lines
# this method is a core of this task
# this task is a traning of parsing / filtring / searching specific data
def corrupted?(data)
  # define array to gather incomplete lines
  p incorrupted = []
  # i tried to convert chars on first - on readlines
  # when we do each/map with data and then convert them to chars and on chars do each
  # we can get nicely one parsed data
  # so extract each chonk, according to task
  data.chars.each do |chonk|
    case chonk
      # when the opening chunk shows up, push the closing counterpart into our empty array to the beginning of this array
    when '('
      p incorrupted.prepend(')')
    when '['
      p incorrupted.prepend(']')
    when '{'
      p incorrupted.prepend('}')
    when '<'
      p incorrupted.prepend('>')
      # here we check the closing chunks to see if they match - is it the same match for the opener?
      # when comes the closing chunk, is our first chunk in our array equal to the closing chunk?
      # if so, remove it from the set (our array) = it's a proxy
      # if not, there is a wrong closing chonk - proving it is a corrupted line
    when ')'
      p incorrupted.first == ')' ? incorrupted.delete_at(0) : (return "corrupted line")
    when ']'
      p incorrupted.first == ']' ? incorrupted.delete_at(0) : (return "corrupted line")
    when '}'
      p incorrupted.first == '}' ? incorrupted.delete_at(0) : (return "corrupted line")
    when '>'
      p incorrupted.first == '>' ? incorrupted.delete_at(0) : (return "corrupted line")
    end
  end
  # return filtered data
  p incorrupted
end

data.map! do |data|
  # map through method
  corrupted?(data)
end
# remove unnecessary corrupted lines
p data.delete("corrupted line")

# count the score according to task
# "Start with a total score of 0.
# Multiply the total score by 5 to get 0, then add the value of ] (2) to get a new total score of 2.
# Multiply the total score by 5 to get 10, then add the value of ) (1) to get a new total score of 11.
# Multiply the total score by 5 to get 55, then add the value of } (3) to get a new total score of 58.
# Multiply the total score by 5 to get 290, then add the value of > (4) to get a new total score of 294."
data.map! do |data|
  total_score = 0
  data.each do |chonk|
    case chonk
    when ')'
      total_score = total_score * 5 + 1
    when ']'
      total_score = total_score * 5 + 2
    when '}'
      total_score = total_score * 5 + 3
    when '>'
      total_score = total_score * 5 + 4
    end
  end
  # return the score
  total_score
end

p data.sort[data.size/2]
# => 2116639949
