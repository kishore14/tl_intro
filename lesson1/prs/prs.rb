#Rules: Paper wraps Rock; Rock smashes Scissors; Scissor shreds Paper

puts "Welcome to Paper, Rock, Scissors! "
CHOICES = {'p' => 'Paper', 'r'=> 'Rock', 's' => "Scissors"}

def display_menu 
  puts "Please make a selection!"
  CHOICES.each do | key, value |
    puts "  #{key}: #{value}"
  end
end

def display_winning_message(winning_choice)
  case winning_choice
    when 'p'
      puts "\nPaper wraps Rock!"
    when 'r'
      puts "\nRock breaks Scissors!"  
    when 's'
      puts "\nScissors shreds Paper"
  end
end

loop do #Main loop
  begin
    display_menu
    player_choice = gets.chomp.downcase
    if !CHOICES.keys.include? (player_choice)
      puts "Invalid Selction! Please enter p or r or s only!!"
    end
  end until CHOICES.keys.include? (player_choice)
  
  computer_choice = CHOICES.keys.sample

  puts "You chose #{CHOICES[player_choice]}"
  puts "Computer chose #{CHOICES[computer_choice]}"
  
  # Apply rules
    if(player_choice == computer_choice)
    puts "\nIts a tie!"
  
    elsif(player_choice == 'p' && computer_choice == 'r') || (player_choice == 'r' && computer_choice == 's') || (player_choice == 's' && computer_choice == 'p')
      display_winning_message(player_choice)
      puts "\nYou Won!!!"
    else
      display_winning_message(computer_choice)
      puts "\nComputer Won!"
    end

  puts "Do you want to continue? y/n"
  choice = gets.chomp.downcase
  if choice !='y'
    break
  end
end 

puts "Goodbye!"