# exercise demand to get individual characters = brackets = elements = chonks
# so through file return an array of content file without '\n'
data1 = File.readlines('example.txt').map(&:chomp)
data2 = File.readlines('input.txt').map(&:chomp)
data = data2

# gather total_syntax_error_scores
total_syntax_error_score = []
# we will need to extract opening chunks to compare them with closing ones
storage_to_remove_last = []
# get each separate line...
data.each do |each_line|
  # ...in those lines get separate characters
  each_line.chars.each do |char|
    # task content: 
    # "If a chunk opens with (, it must close with ).
    #  If a chunk opens with [, it must close with ].
    #  If a chunk opens with {, it must close with }.
    #  If a chunk opens with <, it must close with >."
    case char
    # start from the opening chunks because we have them prepared, ready to use, separate chars
    # then we can check match, this opening with closing ones, that are most important
    # when opening bracket: (, [, {, < show up then push it to storage, where u can remove last one and return it
    when '(' then storage_to_remove_last << char
    when '[' then storage_to_remove_last << char
    when '{' then storage_to_remove_last << char
    when '<' then storage_to_remove_last << char      
    # logical it is that check closing chunks next
    # task content:
    # "To calculate the syntax error score for a line,
    #  take the first illegal character on the line and look it up in the following table:
    #  - ): 3 points.
    #  - ]: 57 points.
    #  - }: 1197 points.
    #  - >: 25137 points."
    # if storage == ( then part of line is complete. We want to get the opposite situation where we are searching 
    # a corrupted line, where brackets(chunks) don't match
    when ')'
      # get last, remove it and return it to compare it with the closing one bracket, for every kind of closing chunk
      storage_to_return_last = storage_to_remove_last.pop
      if storage_to_return_last != '('
        total_syntax_error_score << 3
      end
    when ']'
      storage_to_return_last = storage_to_remove_last.pop
      if storage_to_return_last != '['
        total_syntax_error_score << 57
      end
    when '}'
      storage_to_return_last = storage_to_remove_last.pop
      if storage_to_return_last != '{'
        total_syntax_error_score << 1197
      end
    when '>'
      storage_to_return_last = storage_to_remove_last.pop
      if storage_to_return_last != '<'
        total_syntax_error_score << 25137
      end
    end
  end
end
# task content: "What is the total syntax error score for those errors?"
p total_syntax_error_score.sum
# => 374061
