# readlines is the best: 1. immediately we get array. or readline in case of one line data. 
# but i see that readlines/readline don't like split. In previous exerc I didn't know it, that we can include it to brackets
# just as convert to integers with map

data1 = File.open('example.txt', &:readline).split(',').map(&:to_i)
data2 = File.open('input.txt', &:readline).split(',').map(&:to_i)

# depending of example data or input and number of days, choose data
if data1

end

# =>

