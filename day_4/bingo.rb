class Bingo
attr_accessor :grid

  # initializing grid = our fields? let's call them that
  def initialize(grid)
    @grid = grid
  end

  # w zależności od input number, each po każdym gridzie,
  # czyli po każdym rzędzie każdego boarda, REPLACE (bo map!, zwykły map dałby nowy arrray) arraya (row = array)
  # w tym arrayu numery tych rzędów, jeżeli będą inne niż input, wtedy zostaną na miejscu
  def mark(number)
    grid.each { |row| row.map! { |other_number| other_number == number ? nil ; other_number } }
  end

  # if completed row OR completed column?
  def completed?
    completed_row? || completed_column?
  end
  # then proceed to another method, dependent of the result
  def completed_row?
    grid.any? { |row| row.all? { |number| number == nil} }
  end

  def completed_column?
    grid.transpose.any? { |row| row.all? { |number| number == nil} }
  end

  # po gridzie, stostujemy wypłaszczenie - czyli zestawiamy w jednym row wszystkie dotychczasowe rowy
  # jak będziemy mieli 1 row to sumujemy content
  # potrzebujemy compact dla usuwania nills which will be our proxies for next variables
  def sum_of_all_unmarked_numbers
    grid.flatten.compact.sum
  end
end