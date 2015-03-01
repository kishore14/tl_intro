#tictactoe.rb 

#Array to hold the current state of the board
#board = {1 =>'1', 2 => '2', 3 => '3', 4 => '4', 5 => '5', 6 => '6', 7 => '7', 8 => '8', 9 => '9'}

require 'pry'
def initialize_board
  b = {}
  (1..9).each  {|position| b[position]= position}
  b
end


# Method to draw tic-tac-toe board to screen
def draw_board(b)
  system 'clear'
  puts "Make a selection by entering any number displayed on the board."
  puts "  "+"#{b[1]} | #{b[2]} | #{b[3]}"
  puts "  "+"----------"
  puts "  "+"#{b[4]} | #{b[5]} | #{b[6]}"
  puts "  "+"----------"
  puts "  "+"#{b[7]} | #{b[8]} | #{b[9]}"
end

def get_empty_positions(b)
  b.select {|k, v| v.to_s!='X' && v.to_s!='O' }.keys
end


def get_player_selection(b)
  
  begin # check if the selection is valid
    player_choice = gets.chomp.to_i
    is_valid = get_empty_positions(b).include? player_choice
    if !is_valid
      puts "Invalid selection! Please select empty squares that are displayed by numeric values only! "
    end
  end until is_valid
  
  b[player_choice] = 'X'
end

def get_computer_selection(b)
  computer_choice = get_empty_positions(b).sample
  b[computer_choice] = 'O'
end

def winner?(b)
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9,], [3,5,7]]
  winning_lines.each do |line|
    if b[line[0]] == 'X' && b[line[1]] == 'X' && b[line[2]] == 'X'
      return 'Player'
    elsif  b[line[0]] == 'O' && b[line[1]] == 'O' && b[line[2]] == 'O'
      return 'Computer'
    end # end if 
  end #end do
  return nil
end #end method


begin # Main loop to repeat
  board = initialize_board
  draw_board(board)
  begin #Loop to play one game
    get_player_selection(board)
    draw_board(board)

    get_computer_selection(board)
    draw_board(board)
    winner = winner?(board)
  end until winner || get_empty_positions(board).empty?

  #binding.pry

  if winner == 'Player'
    puts "You Won!"
  elsif winner == 'Computer'
    puts "Computer Won!"
  else
    puts "Its a tie!"
  end

puts "Do you wish to play again? (y/n)"
play_again = gets.chomp.downcase
end until play_again !='y'
puts "Good Bye!"