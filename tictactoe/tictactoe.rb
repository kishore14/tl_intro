#tictactoe.rb 
# This has some computer intelligence.

require 'pry'
WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9,], [3,5,7]]
game_count = 0
player_wins = 0
computer_wins = 0
tie_count = 0

def initialize_board
  b = {}
  (1..9).each  {|position| b[position]= position}
  b
end

# Method to draw tic-tac-toe board to screen
def draw_board(board,game_count,player_wins,customer_wins,tie_count)
  sleep 0.3
  system 'clear'
  puts "History: Total Games => #{game_count}, Player => #{player_wins}, Computer => #{customer_wins}, Tie => #{tie_count}"
  puts "Make a selection by entering any number displayed on the board."
  puts "  "+"#{board[1]} | #{board[2]} | #{board[3]}"
  puts "  "+"----------"
  puts "  "+"#{board[4]} | #{board[5]} | #{board[6]}"
  puts "  "+"----------"
  puts "  "+"#{board[7]} | #{board[8]} | #{board[9]}"
end

#Method to get array of empty positions
def get_empty_positions(board)
  board.select {|k, v| v.to_s!='X' && v.to_s!='O' }.keys
end

#Method to get player selection
def get_player_selection(board)
  begin # check if the selection is valid
    player_choice = gets.chomp.to_i
    is_valid = get_empty_positions(board).include? player_choice
    if !is_valid
      puts "Invalid selection! Please select empty squares that are displayed by numeric values only! "
    end
  end until is_valid
  board[player_choice] = 'X'
end

#Method to defend against player win
def choose_to_defend(board)
  WINNING_LINES.each do |line|
    #binding.pry
    line_values_arr = [board[line[0]], board[line[1]], board[line[2]]] # build an array of winning line values
    if line_values_arr.count('X') == 2 && line_values_arr.count('O')==0 
      choice =  line_values_arr.select {|position| position.to_s!='X'}  #why is this returning an array?
      return choice[0]
    else
      #puts "NONE TO DEFEND"
    end # end for if
  end # end for do 
  return nil
end # Method end

#Method to attack and try to win
def play_to_win(board,g)
  if board[5]==5 #always choose center. That's my strategy .. lol.. 
    choice =[]
    choice[0] = 5 #since I am getting array from below, I am coding this way
    return choice[0]
  end # end choosing center square
  WINNING_LINES.each do|line|
    line_values_arr = [board[line[0]], board[line[1]], board[line[2]]] # build an array of winning line values
    if line_values_arr.count('O') == 2 and line_values_arr.count('X')==0 
      choice =  line_values_arr.select {|position| position.to_s!='O'}  #why is this returning an array?
      return choice[0]
    else
      #puts "NONE TO WIN"
    end # end for if
  end # end for do 
  return nil
end # Method end

#Main method 
def get_computer_selection(board,g)
  computer_choice = play_to_win(board,g)
  if !computer_choice
    computer_choice = choose_to_defend(board)
    if !computer_choice
    computer_choice = get_empty_positions(board).sample
    end #end to get sample
  end #end to defend
  
  if get_empty_positions(board).sample # Print this message only when there are empty positions to choose.
    puts "COMPUTER CHOICE : #{computer_choice}"
    board[computer_choice] = 'O'
  end #end for if 
end

#Method to check if there is a winner on the board or not
def winner?(board)
  WINNING_LINES.each do |line|
    if board[line[0]] == 'X' && board[line[1]] == 'X' && board[line[2]] == 'X'
      return 'Player'
    elsif  board[line[0]] == 'O' && board[line[1]] == 'O' && board[line[2]] == 'O'
      return 'Computer'
    end # end if 
  end #end do
  return nil
end #end method

begin # Main loop to repeat till user decides not to play
  board = initialize_board
  draw_board(board,game_count,player_wins,computer_wins,tie_count)

  # Let player go first and if game count is odd then computer goes first and if center is occupied then computer already made a selection
  if game_count.odd? and board[5]==5
    puts "Computer chooses first!!"
    get_computer_selection(board,game_count)
    draw_board(board,game_count,player_wins,computer_wins,tie_count)
  end
  
  begin #Loop to play one game
    get_player_selection(board)
    draw_board(board,game_count,player_wins,computer_wins,tie_count)
    winner = winner?(board)
    if !winner 
      get_computer_selection(board,game_count)
      draw_board(board,game_count,player_wins,computer_wins,tie_count)
    end
    winner = winner?(board)
  end until winner|| get_empty_positions(board).empty?

  if winner == 'Player'
    player_wins+= 1
    puts "You Won!"
  elsif winner == 'Computer'
    computer_wins+= 1
    puts "Computer Won!"
  else
    tie_count += 1
    puts "Its a tie!"
    
  end
  game_count+=1 # increment game count
  puts "Do you wish to play again? (y/n)"
  play_again = gets.chomp.downcase
end until play_again !='y'
puts "History: Total Games => #{game_count}, Player => #{player_wins}, Computer => #{computer_wins}, Tie => #{tie_count}"
puts "Good Bye!"