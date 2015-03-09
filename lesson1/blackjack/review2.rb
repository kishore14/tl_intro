require 'pry'

# create a deck of cards
def deck_of_cards
  deck  = [] 
  suits = ["\u2660", "\u2663", "\u2665", "\u2666"]
  ranks = %w{Ace 2 3 4 5 6 7 8 9 10 Jack Queen King}
  suits.each do |suit|
    ranks.each_with_index do |rank, index|
      index = 9 if index > 9 # max value on card is 10
      deck << {'rank' => rank, 'suit' => suit, 'value' => index + 1}
    end
  end
  p deck
  exit
end

# print to screen format for a hand
def hand_to_s(hand)
  string = []
  if hand.length > 1
    hand.each do |card|
      string << "#{card['rank']} of #{card['suit'].encode('utf-8')}"
    end
    string.join(' and ')
  else
    string
  end
end

# shuffle the deck of cards
def shuffle_deck(deck)
  puts ".....Shuffling cards....."
  5.times do
    print "....."
    sleep 1 
  end
  puts ""
  deck.shuffle! 
end

# check value of cards in a hand
def check_value(hand)
  sum = 0
  hand.each do |card|
    if card['rank'] == 'Ace'
      sum += 11
    else
      sum += card.values.last
    end
  end

  # correct for multiple Aces
  hand.select {|card| card['rank'] == 'Ace'}.count.times do
    sum -= 10 if sum > 21
  end
  sum
end

# deal a card from deck (mutates the caller)
def deal_card(deck)
  deck.pop
end

# player round
def player_round(hand, deck, name)
  puts "Your cards are #{hand_to_s(hand)}. Your total value is #{check_value(hand)}."

  case
  when blackjack?(hand)  
    puts "You got Blackjack!"
  when busted?(hand)
    puts "Sorry #{name}, you're busted!"
  else
    print "Would you like a hit or stay #{name}? (H/S)"
    player_choice = gets.chomp.downcase

    if player_choice == 'h'
      hand << deal_card(deck)
      player_round(hand, deck, name)
    end
  end
  check_value(hand)
end

# dealer round
def dealer_round(hand, deck)
  puts "The dealer's cards are #{hand_to_s(hand)}. Their total value is #{check_value(hand)}."

  case 
  when blackjack?(hand) 
    puts "Dealer has Blackjack!"
  when busted?(hand)
    puts "Dealer has busted."
  when check_value(hand).between?(17, 21) 
    sleep 1
    puts "=> Dealer stays"
  else
    puts "=> Dealer takes a hit"
    sleep 1
    hand << deal_card(deck)
    dealer_round(hand, deck)
  end
  check_value(hand)
end

def blackjack?(hand)
  check_value(hand) == 21 ? true : false
end

def busted?(hand)
  check_value(hand) > 21 ? true : false
end

# determine winner cases
def winner(player, dealer)
  case
  when player > dealer || dealer > 21 # player == 21 && dealer < 21 || 
    puts "You win!"
  when dealer == 21 || player < dealer  #&& player < 21 || player < dealer 
    puts "You lose!"
  else 
    puts "Push"
  end
end

# play blackjack
def play_blackjack

  puts "Welcome to Blackjack!"
  print "Howdy stranger, what's your name? "

  name = gets.chomp

  puts "Nice to meet you #{name}. Let's play some Blackjack!"
  puts ""

  begin 
    deck = []

    # three decks of cards protects against card counting
    3.times {deck += deck_of_cards} 
    shuffle_deck(deck)
    puts ""

    player_hand = []
    dealer_hand = []

    # deal cards in an alternate manner
    2.times do
      player_hand << deal_card(deck)
      dealer_hand << deal_card(deck)
    end

    # show dealer's face up card, the last card dealt
    puts "Dealer's face up card is a #{dealer_hand.last['rank']} of #{dealer_hand.last['suit'].encode('utf-8')}"

    player_value = player_round(player_hand, deck, name)

    # dealer only plays out hand when player does not bust
    if player_value <= 21 
      dealer_value = dealer_round(dealer_hand, deck)
      winner(player_value, dealer_value)
    end

    # ask player to play again
    print "Would you like to play again? (Y/N) "
    play_again = gets.chomp.downcase

    system 'clear' 
  end until play_again == 'n'

  puts "Thanks for playing #{name}!"
end

play_blackjack