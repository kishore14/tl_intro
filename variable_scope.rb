#2/26/15
#re-assign the variable to something else

x=4
loop do
  x='hey'
  break
end

puts x # here, i think x =4 will be printed.

# I dint notice that it was  a loop, need to wake up.
puts "--------------------------"
#call a method that doesn't mutate the caller

def no_mutate(arr)
  arr.uniq
end
my_arr=[1,2,2,3]
no_mutate(my_arr)
p my_arr #This will print [1,2,2,3]
# it did print [1,2,2,3]
# this is because the call was made by pass-by-value
puts "--------------------------"
#call a method that mutates the caller
def yes_mutate(arr)
  arr.uniq!
end
new_arr=[1,2,2,3,3]
yes_mutate(new_arr)
p new_arr # i think it will print [1,2,3], because call will be made by pass-by-reference
#it did print [1,2,3]
puts "--------------------------"
#scope for methods
x="hi"
def my_method
  puts x
end
my_method # i think this will print hi
#hmm didnt even heed the hint. I got an error. This is good to know.