# Due to wrong result of previous code of part 2 (example was the same, but result of input was wrong)
# I have to rebuild my code. to have one structure. also my skill has increased, with every further task, so I get more knowledge

# get data, parse data, remove '\n'
data1 = File.readlines('example.txt').map(&:chomp)
data2 = File.readlines('input.txt').map(&:chomp)
data = data2

# define method
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
      # true? remove it from the set (our array) = it's a proxy
      # if not, there is a wrong closing chonk - proving it is a corrupted line
    when ')'
      p incorrupted.first == ')' ? incorrupted.delete_at(0) : (return 3)
    when ']'
      p incorrupted.first == ']' ? incorrupted.delete_at(0) : (return 57)
    when '}'
      p incorrupted.first == '}' ? incorrupted.delete_at(0) : (return 1197)
    when '>'
      p incorrupted.first == '>' ? incorrupted.delete_at(0) : (return 25137)
    end
  end
end

# go through filter
data.map! do |data|
  # map through method
  corrupted?(data)
end

# choose from filtered data only points
# task content: "What is the total syntax error score for those errors?"
p data.select! { |int| int == 3 || int == 57 || int == 1197 || int == 25137 }.sum
# => 374061
