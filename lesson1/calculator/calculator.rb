#calculator.rb
require 'pry'
def show_menu
  puts "Select a Math operation for two numbers. "
  puts "1. Add"
  puts "2. Subtract"
  puts "3. Multiply"
  puts "4. Division"
end

begin
  show_menu
  selection = gets.chomp
  
  case selection 
    when '1' # ADD
      puts  "Enter First Number: "
      num1 = gets.chomp
      puts  "Enter Second Number: "
      num2 = gets.chomp
      result = num1.to_f+num2.to_f
      puts "The sum of two numbers is #{result}"
    
    when '2' # SUBTRACTION
      puts  "Enter First Number: "
      num1 = gets.chomp
      puts  "Enter Second Number, to subtract from first number: "
      num2 = gets.chomp
      result = num1.to_f-num2.to_f
      puts "The difference of two numbers is #{result}"
  
    when '3' # MULTIPLICATION
      puts  "Enter First Number: "
      num1 = gets.chomp
      puts  "Enter Second Number, to multiply with first number: "
      num2 = gets.chomp
      result = num1.to_f*num2.to_f
      puts "The product of two numbers is #{result}"
    
    when '4' # DIVISION
      puts  "Enter First Number (Dividend): "
      num1 = gets.chomp
      puts  "Enter Second Number(Divisor): "
      num2 = gets.chomp
      result = num1.to_f/num2.to_f
      puts "The result of division is  #{result}"
    
     else
       puts "Invalid Choice. Please choose options 1 through 4 only!!"
   end #case end
  
   puts "Do you wish to make another selection? Enter Y/y: " 
   option = gets.chomp
end while option.downcase == 'y'