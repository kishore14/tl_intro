#blackjack.rb
#First attempt

require 'pry'
cards = ['A','2','3','4','5','6','7','8','9','10','J','Q','K']
suite = {'S'=> 'Spades', 'C' => 'Clubs', 'D' => 'Diamonds', 'H' => 'Hearts'}
card_values = {
    'A' => 11, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' =>7, '8' => 8, '9' => 9,
    '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10  
  }
card_display = {
  'A' => 'Ace', '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' =>7, '8' => 8, '9' => 9,
  '10' => 10, 'J' => 'Jack', 'Q' => 'Queen', 'K' => 'King'  
  }

#Method to create a deck.
#This could be reusable method once I create multi-deck version
def create_deck(number,cards)
  deck=[]
  number.times do 
    deck << cards
  end
  deck.flatten!
end

#Method to display welcome message
def welcome
  puts "Welcome to blackjack!!"
  #puts " S => Spade, C => Clubs, D => Diamond, H => Heart"
end

#Method to create a card
def create_card(deck, suite, card_values)
  card = []
  card << deck.sample
  card << suite.keys.sample
  card << card_values[card[0]]
  deck.delete(card[0])
  puts "--- Removed #{card[0]} from deck"
  p deck
  return card
end


#Method to create a hand
def create_hand(deck, suite, card_values)
  card_1 = create_card(deck, suite, card_values)
  card_2 = create_card(deck, suite, card_values)
   
 # card_1 = ["A","C", 11]
 # card_2 = ["A","S", 11]
  hand = []
  hand <<  card_1
  hand << card_2
  puts "--- HAND ---"
  p hand
  hand
end

# Method to display the hand
def display_hand(hand, card_display, suite)
  hand.each do | card |
    puts "\t\t#{card[0]} of #{suite[card[1]]}" 
  end
end

# Method to compute value of hand
def get_hand_value(hand)
  #check if there any aces in the hand
  #hand_value = hand.keys
  aces_in_hand = 0
  hand.each do | card|
    #aces_in_hand += card.count('A')
    if card[0]=='A'
      aces_in_hand += 1
    end
  end
  puts "Aces count : #{aces_in_hand}"
  if aces_in_hand == 2 #if there are two aces in the first two cards then change the value of the first card to 1.
    hand[0][2] = 1
    puts "--changing Ace to 11"
    p hand
  end
  
  hand_value = 0
  hand.each do | card|
    #aces_in_hand += card.count('A')
    hand_value += card[2]
  end
  
   return hand_value
end

begin
  bust = false
  hit = false
  stay = false
  #Display welcome message
  welcome 
  #create deck
  deck = create_deck(1,cards)
  #Create players first hand
  player_hand = create_hand(deck, suite, card_values) 
  player_hand_value = get_hand_value(player_hand)
  puts "\tYour hand value is:  #{player_hand_value}" 
  #Display Hand
  puts "\tYour hand is:" 
  display_hand(player_hand, card_display, suite)
  #Create computer first hand
  computer_hand = create_hand(deck, suite, card_values) 
  
  
  bust = true
 # binding.pry
end until bust==true || stay==true