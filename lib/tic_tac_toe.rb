# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #TOP row
  [3,4,5], #MIDDLE row
  [6,7,8], #BOTTOM row
  [0,3,6], #LEFT COLLUM
  [1,4,7], #MIDDLE COLLUMN
  [2,5,8],  #RIGHT COLLUMN
  [0,4,8], #backward diagonals
  [6,4,2]  #forward diagonals
]

# Define a method display_board that prints a 3x3 Tic Tac Toe Board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#code your input_to_index and move method here!
def input_to_index(position)
 pos = position.to_i
 pos = pos - 1
 return pos
end

def move(board, index, character)
  board[index] = character
  return board
end

# code your #position_taken? method here!
def position_taken?(board, index)
  if (board[index] == " ") || (board[index] == "")
    return false
  elsif board[index] == nil
    return false
  else
    return true
  end
end

# code your #valid_move? method here
def valid_move?(board, index)
  if(index >= 0 ) && (index <= 8)
    if position_taken?(board, index)
      return false
    else
      return true
    end
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  usr_input = gets.strip
  alt_input = input_to_index(usr_input)
  if valid_move?(board, alt_input)
    move(board,alt_input, current_player(board))

  else
    turn(board)
  end
display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |slot|
    if (slot == "X") || (slot == "O")
      count += 1
    end
  end

  return count
end

def current_player(board)
  turn_count(board) % 2 == 0 ?  "X" :  "O"
end

def won?(board)
  #check if board is empty
  all_empty = board.all? do |empty|
    if empty == "" || empty == " "
      empty = true
    end
  end

  if all_empty
    return false
  end

  WIN_COMBINATIONS.each do |win_combination|
    # WINNING COMBINATION CONSTANTS
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] #board[0] = X
    position_2 = board[win_index_2] #board[1] = X
    position_3 = board[win_index_3] #board[2] = X

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    end

    if position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end

  #draw?(board)

  return false
end

def draw?(board)
  #checks for draw

  # if board[0] == "X" && board[1] == "X" && board[2] == "X"
  #   return false
  # elsif (board[0] == "X" && board[4] == "X" && board[8] == "X") || (board[2] == "X" && board[4] == "X" && board[6] == "X")
  #   return false
  # end
  #if empty_space is true means there is an empty space
  ## therefore board is not full

  if full?(board)
    if won?(board) == false
      return true
    else
      return false
    end
  else
    return false
  end

  # if draw
  #   return true
  # else
  #   return false
  # end
end

def full?(board)
  full = board.each do |slot|
    if slot == "X" || slot == "O"
      slot = true
    else
      return false
    end
  end

  if full
    return true
  end


  # inp = board.any? do |used|
  #   if used == " " || used == ""
  #     inp = true
  #   end
  # end
  # if inp
  #   return false
  # else
  #   return true
  #
  # end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) == false
    return nil
  end
  winning_position = won?(board)
  win_index = winning_position[0]

  position_1 = board[win_index]

  #if winner return winner
  return position_1
  # end

end


def play(board)
  until over?(board)
    turn(board)
  end

  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end

end
