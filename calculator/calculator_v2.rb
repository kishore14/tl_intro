# I want to enhance calculator.rb by making sure the number inputs are numbers
#Improvements 1) check if the inputs entered are numeric or not 
#2) In the first attempt, if user enters invalid selection force them to enter between 1 and 4 instead of asking Y/y

#calculator.rb
require 'pry'
def show_menu
  puts "Select a Math operation for two numbers. "
  puts "1. Add"
  puts "2. Subtract"
  puts "3. Multiply"
  puts "4. Division"
end

def get_valid_input
  begin
    input=gets.chomp
    is_valid =  Float(input) rescue false
   # binding.pry
    if !is_valid
      puts "Invalid input! Please enter a decimal number!!"
    else
      return input
    end
  end while !is_valid
end 

def is_number?
  self.to_f == self
end

begin # Main logic
  show_menu
  
  
  begin #validate selection
    selection = gets.chomp
    is_valid = selection.to_i.between?(1,4) rescue false
    if is_valid == false
      puts "Invalid Selection! Please choose options 1 through 4 only !!"
    end
 end while !is_valid
  
  case selection 
    when '1' # ADD
      puts  "Enter First Number: "
      num1 = get_valid_input
      puts  "Enter Second Number: "
      num2 = get_valid_input
      result = num1.to_f+num2.to_f
      puts "The sum of two numbers is #{result}"
    
    when '2' # SUBTRACTION
      puts  "Enter First Number: "
      num1 = get_valid_input
      puts  "Enter Second Number, to subtract from first number: "
      num2 = get_valid_input
      result = num1.to_f-num2.to_f
      puts "The difference of two numbers is #{result}"
  
    when '3' # MULTIPLICATION
      puts  "Enter First Number: "
      num1 = get_valid_input
      puts  "Enter Second Number, to multiply with first number: "
      num2 = get_valid_input
      result = num1.to_f*num2.to_f
      puts "The product of two numbers is #{result}"
    
    when '4' # DIVISION
      puts  "Enter First Number (Dividend): "
      num1 = get_valid_input
      puts  "Enter Second Number(Divisor): "
      num2 = get_valid_input
      result = num1.to_f/num2.to_f
      puts "The result of division is  #{result}"
    
     #else
      # puts "Invalid Choice. Please choose options 1 through 4 only!!"
   end #case end
  
   puts "Do you wish to make another selection? Enter Y/y: " 
   option = gets.chomp
end while option.downcase == 'y'