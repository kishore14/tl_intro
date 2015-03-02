#and this code can be cleaned up alot. 
=begin
dictionary = {
  nouns: ['dog','car','clown','hat'],
  verbs: ['catwalk','spin'],
  adjectives: ['giant','red']
  }
=end
#read nouns, verbs, adjectives from files

nouns = File.open('nouns.txt','r') do |f|
  f.read
  end.split # THIS IS NEAT !!

verbs = File.open('verbs.txt','r') do |f|
  f.read
  end.split # THIS IS NEAT !!

adjectives = File.open('adjectives.txt','r') do |f|
  f.read
  end.split # THIS IS NEAT !!



dictionary = {
  nouns: nouns,
  verbs: verbs,
  adjectives: adjectives
  }

def say(msg)
  puts " => #{msg}"
end
=begin
#This is typical way of doing with if. this can be put into one line as below.
if ARGV.empty?
  say "No Input file!"
  exit
end

if !File.exists?(ARGV[0])
  say "Input file doesn't exist"
  exit
end
=end

=begin
#writing this way seems okay, but hte exit doesnt work. putting exit in a method worked as below
say("No Input File!") && exit if ARGV.empty?
say("File doesnt exist!") && exit if !File.exists?(ARGV[0])
=end

def exit_with(msg)
  say (msg)
  exit
end

exit_with("No Input File") if ARGV.empty?
exit_with("File doesnt exist") if !File.exists?(ARGV[0])

contents = File.open(ARGV[0],'r') do |file|
  file.read
end

=begin
#above substitution picks a sample and uses that sample for all the nouns. below one uses different nouns
contents.gsub!('NOUN', dictionary[:nouns].sample)
contents.gsub!('VERB', dictionary[:verbs].sample)
contents.gsub!('ADJECTIVE', dictionary[:adjectives].sample)
p contents
=end

#below uses enumerator to achieve non-repetition of sample
#contents.gsub!('NOUN', dictionary[:nouns].sample)

contents.gsub!('NOUN').each do #|noun| = parameter is not needed
 #'hi'
  #dictionary[:nouns].sample
  
  puts "Input a noun:"
  STDIN.gets.chomp
  
end


contents.gsub!('VERB').each do #|noun| = parameter is not needed
 #'hi'
  dictionary[:verbs].sample
end

contents.gsub!('ADJECTIVE').each do #|noun| = parameter is not needed
 #'hi'
  dictionary[:adjectives].sample
end
p contents




