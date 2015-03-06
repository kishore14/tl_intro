#blackjack.rb #Simplifying or refactoring ths code per suggestions.
require 'pry'
CARDS = ['A','2','3','4','5','6','7','8','9','10','J','Q','K'] #Actual cards
SUITES = ['S', 'C', 'D', 'H'] 
SUITE_SYMBOLS = {'S' => "\u2660", 'C' => "\u2663", 'H' => "\u2665", 'D' => "\u2666"}

def create_deck(number)
  deck = []
  deck_cards = []
  number.times do
    deck_cards << CARDS
  end
  deck_cards.flatten!
  deck = deck_cards.product(SUITES)
  deck.shuffle!
end

#Method to create a card
def deal_a_card(deck)
  deck.pop
end

#Method to create a hand
def deal_first_hands(deck, player_cards, dealer_cards)
  player_cards << deal_a_card(deck) << deal_a_card(deck)
  dealer_cards << deal_a_card(deck) << deal_a_card(deck)
  return player_cards, dealer_cards
end

# Method to display the hand
def display_hands( player_hand, dealer_hand, state = {} )
  system 'clear'
  if state[:gameover]
    puts "Dealer Cards: "
    dealer_hand.each do | card |
    print "   #{card[0]} #{SUITE_SYMBOLS[card[1].encode('utf-8')]}" 
    end
    puts"\nHand Value: " + get_hand_value(dealer_hand).to_s
  else
    puts "Dealer Cards :"
    puts "   #{dealer_hand[0][0]} #{SUITE_SYMBOLS[dealer_hand[0][1].encode('utf-8')]}" + " and *" 
  end
  puts "-" * 15
  puts "Your Cards:"
  player_hand.each do | card |
  print "   #{card[0]} #{SUITE_SYMBOLS[card[1]].encode('utf-8')}" 
  end  
  puts"\nHand Value: " + get_hand_value(player_hand).to_s
end

def get_hand_value(hand)
  hand_values = hand.map { |card| card[0]} 
  total = 0
  hand_values.each do |value|
    if value == 'A'
      total += 11
    elsif value.to_i == 0 # this is for J, Q, K
      total += 10
    else
      total += value.to_i
    end
  end # end for do
  # To accomodate Aces, subtract 10 from the total per Ace if the total is >21
  hand_values.select{|value| value == "A"}.count.times do 
    total -= 10 if total >21
  end
  total
end

def initialize_game
  puts "Welcome to blackjack!!" 
  puts "How many deck's you want to play with?"
  deck_count = gets.chomp.to_i
  if deck_count == 0 
    puts "Invalid Input!  Lets play with one deck ... "
    deck_count =1
  end
  deck = create_deck(deck_count)  # Create deck
  begin
    puts "Enter total bet amount: "
    total_bet = gets.chomp.to_i
    if total_bet <= 0  
      puts "Invalid Input!  "
    end
  end until total_bet > 0
  return  deck, total_bet
end  

def player_play(player_hand, dealer_hand, deck, total_bet)
  bust, stay, player_blackjack = false, false, false
  bet_amount = 0
  begin
    puts "Enter bet: "
    bet_amount = gets.chomp.to_i
    if bet_amount <= 0  
      puts "Invalid Input!  "
    end
  end until bet_amount > 0
  if bet_amount > total_bet
    puts "Lets play with your full amount ...  $#{total_bet}"
    bet_amount = total_bet
  end
  begin # Loop to manage player decisions
    player_hand_value = get_hand_value(player_hand)
    if player_hand_value == 21
      player_blackjack = true
      return stay, bust, player_blackjack, bet_amount
    end
    display_hands(player_hand, dealer_hand, gameover: false) 
    puts "\nDo you want to Hit or Stay (h/s)"
    player_choice = gets.chomp.downcase
    if !['h', 's'].include?(player_choice)
      puts "\nInvalid selection! Please enter 'h' to Hit or 's' to Stay !! "
    end
    case player_choice
      when 'h' 
        player_hand << deal_a_card(deck)
        display_hands(player_hand, dealer_hand, gameover: false) 
        player_hand_value = get_hand_value(player_hand)
        if player_hand_value > 21  #player loses
          total_bet -= bet_amount
          winner = 'dealer'
          display_winner(winner, player_hand, dealer_hand)
          bust = true
       elsif player_hand_value == 21
         player_blackjack = true
         break            
       end
     when 's'
       stay = true
     end
  end until bust || stay || player_blackjack
  return stay, bust, player_blackjack, bet_amount
end

def deal_to_dealer(deck, dealer_hand, player_hand)
  display_hands(player_hand, dealer_hand, gameover: false) 
  dealer_hand_value = get_hand_value(dealer_hand)
  while dealer_hand_value < 17
      dealer_hand << deal_a_card(deck)
      sleep 0.5
      dealer_hand_value = get_hand_value(dealer_hand)
      display_hands(player_hand, dealer_hand, gameover: false) 
  end # End while
  dealer_hand
end

def dealer_play(stay, player_blackjack, player_hand, dealer_hand, deck)
  player_blackjack= true
    if stay || (player_blackjack && player_hand.count == 2  )
      dealer_hand = deal_to_dealer(deck, dealer_hand, player_hand)
      dealer_hand_value = get_hand_value(dealer_hand)
    end # End if
  dealer_hand
end

def winner?(player_hand, dealer_hand)
   dealer_hand_value = get_hand_value(dealer_hand)
   player_hand_value = get_hand_value(player_hand)
  case
    when player_hand_value > 21
      return 'dealer'
    when dealer_hand_value > 21
      return 'player'
    when dealer_hand_value > player_hand_value 
      return 'dealer'
    when dealer_hand_value < player_hand_value
      return 'player'
    else
      return 'push'
  end
end

def display_winner(winner, player_hand, dealer_hand)
  display_hands(player_hand, dealer_hand, gameover: true) 
  puts""
  case winner
    when 'dealer'
      puts "***Dealer wins!!***"
    when 'player' 
      puts "***Player wins!!***"
  else
      puts "***Its a push!!***"
  end
  puts ""
end

def check_balance?(total_bet, bet_amount, winner)
  case winner
    when 'dealer'
      total_bet -= bet_amount 
    when 'player' 
      total_bet += bet_amount
  end
  if total_bet <= 0
      puts "Sorry you ran out of your balance."
      nil_balance = true
    else
      nil_balance = false
    end  
  return total_bet, nil_balance
end

def play_again?
  puts "Do you want to play again? (y/n)"
  player_choice = gets.chomp.downcase
  exit_game = player_choice !='y' ? true : false
end

#---Main loop
begin 
  system 'clear'
  deck, total_bet = initialize_game
  loop do
    system 'clear'
    player_hand, dealer_hand =  deal_first_hands(deck, [], [])
    stay, bust, player_blackjack, bet_amount = player_play(player_hand, dealer_hand, deck, total_bet)
    dealer_play(stay, player_blackjack, player_hand, dealer_hand, deck)
    who_won = winner?(player_hand, dealer_hand)
    display_winner(who_won, player_hand, dealer_hand)
    total_bet, nil_balance = check_balance?(total_bet, bet_amount, who_won)
    break if nil_balance
    puts "Your total remaining amount is :#{total_bet}"
    puts "Press any key to continue ... "
    gets.chomp
  end
  exit_game = play_again?
end while !exit_game
puts "Thanks for playing! Good bye.... "