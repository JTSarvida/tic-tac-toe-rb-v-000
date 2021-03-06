def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input = user_input.to_i - 1
  return user_input
end

def move(board_array, index, character)
board_array[index] = character
end

def valid_move?(board, index)
  if index.between?(0, 8)
    if board[index] == " "
      return true
    elsif position_taken?(board, index)
      return false
    elsif board[index] == "X"
      return true
    elsif board[index] == "O"
      return true
    else
      return false
    end
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index = gets.strip
  index = input_to_index(index)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |character|
    if character == "X" || character == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  elsif turn_count(board) % 2 == 1
    return "O"
  end
end

def play(board)
  until over?(board) == true do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]


    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      false
    end
  end
end

def full?(board)
  if board.include?(" ")
    return false
  else
    return true
  end
end

def draw?(board)
  if full?(board) == true && won?(board) == nil
    return true
  elsif won?(board) == false && full?(board) == false
    return false
  elsif won?(board) != nil
    return false
  end
end

def over?(board)
  if won?(board) != nil || draw?(board) == true || full?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) != nil
    winner = won?(board)
    return board[winner[0]]
  else
    return nil
  end
end
