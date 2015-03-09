#My comments: I understood this. It was little confusing at first though...
require 'pry'

INT_VALUE = { "A" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5,
              "6" => 6, "7" => 7, "8" => 8, "9" => 9, "10" => 10,
              "J" => 10, "Q" => 10, "K" => 10 }

def initial_cards
# -> Array of Hashes, [{suit: s, value: v, count: c}, ...]
  suits = ["Spade", "Heart", "Diamond", "Club"]
  values_array = (2..10).to_a.map! { |number| number.to_s }
  values_array << "J" << "Q" << "K" << "A"

  cards = []
  num_decks = 2
  suits.each do |suit|
    values_array.each do |value|
      cards << { suit: suit, value: value, count: num_decks }
    end
  end

  return cards 
end

def initial_deal!(cards, dealer_cards, player_cards)
  2.times { deal_a_card!(cards, dealer_cards) }
  2.times { deal_a_card!(cards, player_cards) }
end

# both arguments will be mutated
def deal_a_card!(cards, someone_cards)
# [{suit: s, value: v, count: c}, ...], [{suit: s, value: v}, ...]
  card_to_deal = cards.select { |card| card[:count] >= 1 }.sample.clone
  cards[cards.index(card_to_deal)][:count] -= 1
    p  card_to_deal
  card_to_deal.delete_if { |key,val| key == :count }
   
  someone_cards << card_to_deal
  p  someone_cards
end

def total_value(someone_cards) # -> Integer
# [{suit: s, value: v}, ...]
  total = 0
  someone_cards.each { |card| total += INT_VALUE[card[:value]] }

  number_of_ace = someone_cards.select { |card| card[:value] == "A" }.count
  return total if number_of_ace == 0

  # if there are aces in someone_card and total + 10 doesnt bust
  # than change the value of ace with 11 (i.e., total += (11 - 1))
  while number_of_ace > 0
    break if total + (11 - 1) > 21
    total += (11 - 1)
    number_of_ace -= 1
  end

  return total
end

def blackjack?(someone_cards)
# [{suit: s, value: v}, ...]
  total = 0
  someone_cards.each { |card| total += INT_VALUE[card[:value]] }
  return true if total == 21

  number_of_ace = someone_cards.select { |card| card[:value] == "A" }.count
  while number_of_ace > 0 && total != 21
    total += (11 - 1)
    number_of_ace -= 1
  end

  return total == 21 ? true : false
end

def busted?(someone_cards)
# [{suit: s, value: v}, ...]
  total = 0
  someone_cards.each { |card| total += INT_VALUE[card[:value]] }
  return total > 21 ? true : false
end

def display_cards(dealer_cards, player_cards, state = {}) # -> nil
# [{suit: s, value: v}, ...], [{suit: s, value: v}, ...], {}
  system 'clear'

  puts "Dealer has:"
  if state[:game_over]
    dealer_cards.each { |card| puts "#{card[:suit]} #{card[:value]}" }
    puts "=> " + total_value(dealer_cards).to_s

  else
    puts "#{dealer_cards[0][:suit]} #{dealer_cards[0][:value]} and *"
  end
  puts "-" * 10

  puts "You have:"
  player_cards.each { |card| puts "#{card[:suit]} #{card[:value]}" }
  puts "=> " + total_value(player_cards).to_s if state[:game_over]
  puts "-" * 10
end

puts "Welcome to Blackjack!"
print "What's your name? "
name = gets.chomp

begin  
  cards, dealer_cards, player_cards = initial_cards, [], []
  initial_deal!(cards, dealer_cards, player_cards)

  while !busted?(player_cards) && !blackjack?(player_cards)
    display_cards(dealer_cards, player_cards)

    while true
      puts "Hit or Stay? (h/s)"
      player_choice = gets.chomp.downcase
      if !['h', 's'].include? player_choice
        puts "Error: you must enter 'h' or 's' (without quotes)"
      else
        break
      end      
    end

    case player_choice
    when 'h' then deal_a_card!(cards, player_cards)
    when 's' then break
    end
  end

  if blackjack?(player_cards)
    display_cards(dealer_cards, player_cards, game_over: true)
    puts "Blackjack! #{name} won!"

  elsif busted?(player_cards)
    display_cards(dealer_cards, player_cards, game_over: true)
    puts "You busted! Dealer won!"

  else
    while total_value(dealer_cards) < 17
      deal_a_card!(cards, dealer_cards)
    end

    display_cards(dealer_cards, player_cards, game_over: true)
    if blackjack?(dealer_cards)
      puts "Blackjack! Dealer won!"

    elsif busted?(dealer_cards)
      puts "Dealer busted! #{name} won!"

    else
      if total_value(player_cards) > total_value(dealer_cards)
        puts "#{name} won!"
      elsif total_value(player_cards) < total_value(dealer_cards)
        puts "Dealer won!"
      else
        puts "It's a tie!"
      end
    end
  end

  loop do 
    puts "#{name}, play again? (y/n)"
    player_choice = gets.chomp.downcase
    if !['y', 'n'].include? player_choice
      puts "Error: you must enter 'y' or 'n' (without quotes)"
      next
    else 
      break
    end
  end
end until player_choice == 'n'