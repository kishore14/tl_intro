#blackjack.rb
#This is my second attempt at this. This doesnt have multideck and bet amount features.

require 'pry'
cards = ['A','2','3','4','5','6','7','8','9','10','J','Q','K'] #Actual cards
suites = ['S', 'C', 'D', 'H'] 
#Hash used to display names of suites instead of first letter
suite_name = {'S'=> 'Spades', 'C' => 'Clubs', 'D' => 'Diamonds', 'H' => 'Hearts'}
#Hash used to display names of cards instead of first letter
card_display = {
  'A' => 'Ace', '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' =>7, '8' => 8, '9' => 9,
  '10' => 10, 'J' => 'Jack', 'Q' => 'Queen', 'K' => 'King'  
  }

deck=[]
deck = cards.product(suites)
#Method to display welcome message
def welcome
  puts "Welcome to blackjack!!"
end

#Method to create a card
def create_card(deck)
  card = deck.shuffle.pop
end

#Method to create a hand
def create_hand(deck)
  card_1 = create_card(deck)
  card_2 = create_card(deck)
   
  hand = []
  hand <<  card_1
  hand << card_2
end

# Method to display the hand
def display_hand(hand, card_display, suite_name)
  hand.each do | card |
    puts "\t#{card_display[card[0]]} of #{suite_name[card[1]]}" 
  end
end

# Method to compute value of hand
def get_hand_value(hand)
  hand_values = hand.map { |card| card[0]} 
  
  total = 0
  #check if there are any Aces
  hand_values.each do |value|
    if value == 'A'
      total += 11
    elsif value.to_i == 0 # this is for J, Q, K
      total += 10
    else
      total += value.to_i
    end
  end
  
  # To accomodate Aces, subtract 10 from the total per Ace if the total is >21
  hand_values.select{|value| value == "A"}.count.times do 
    total -= 10 if total >21
  end
  total
end

#Display welcome message. I didnt want to say welcome messages in middle of the game so I pulled it out of the loop.
welcome 
#Main loop. 
loop do
  system 'clear'
  bust = false
  stay = false
  player_blackjack = false
  
  #Create players first hand
  player_hand = create_hand(deck)
  #Display Hand
  puts "Your hand is:" 
  display_hand(player_hand, card_display, suite_name)
  #Compute hand value
  player_hand_value = get_hand_value(player_hand)
  puts "Your hand value is:  #{player_hand_value}" 

  #Create computer first hand
  computer_hand = create_hand(deck)
  
  if player_hand_value == 21  
    puts "You Hit Blackjack!! "
    player_blackjack = true
  else
    begin # Loop to manage player decisions
      puts "\nDo you want to Hit or Stay (h/s)"
      player_choice = gets.chomp.downcase
      #Keep asking to choose h or s
      if player_choice != 'h' && player_choice != 's'
        puts "\nInvalid selection! Please enter 'h' to Hit or 's' to Stay !! "
      end
      
      case player_choice
        when 'h' 
          system 'clear'
          player_hand << create_card(deck)
          puts "Your hand is:" 
          display_hand(player_hand, card_display, suite_name)
          player_hand_value = get_hand_value(player_hand)
          puts "Your hand value is:  #{player_hand_value}" 
          if player_hand_value > 21
            puts "\nYou have busted! Computer Wins!!"
            puts "\nComputer hand is:"
            display_hand(computer_hand, card_display, suite_name)
            computer_hand_value = get_hand_value(computer_hand)
            puts "Computer hand value is:  #{computer_hand_value}"
            
            bust = true
          elsif player_hand_value == 21
            puts "You Hit Blackjack!! "
            player_blackjack = true
            break            
          end
        when 's'
          stay = true
        end
    end until bust || stay || player_blackjack
  end

  if stay == true || player_blackjack == true
    computer_hand_value = get_hand_value(computer_hand)
    puts "\nComputer hand is:" 
    display_hand(computer_hand, card_display, suite_name)
    computer_hand_value = get_hand_value(computer_hand)
    puts "Computer hand value is:  #{computer_hand_value}" 
    case 
      when computer_hand_value == 21 
        puts "Computer Hit Blackjack!! "
      when computer_hand_value < 17 && player_blackjack != true
        while computer_hand_value < 17
          computer_hand << create_card(deck)
          puts "\nComputer hand is:" 
          display_hand(computer_hand, card_display, suite_name)
          computer_hand_value = get_hand_value(computer_hand)
          puts "Computer hand value is:  #{computer_hand_value}" 
        end # End while
    end  # End if
    case 
      when computer_hand_value > 21
        puts "\nComputer is busted! You Win!!"
      when computer_hand_value > player_hand_value 
        puts "\nComputer Wins!!"
      when computer_hand_value < player_hand_value
        puts "\nYou Win!!"
     else
      puts "\nIts a push!!"
    end
  end

  puts "\nDo you want to play again? (y/n)"
  choice = gets.chomp.downcase
  break if choice!='y'
end 