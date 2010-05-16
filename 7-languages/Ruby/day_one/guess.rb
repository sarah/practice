#!/usr/local/bin/ruby -w


puts "Hello, what is your name? "
name = gets
if name  == "\n"
  name = "Captain Kirk"
  puts "Hello,I see you like to be private."
  puts "We'll call you #{name}"
else
  puts "Hello, #{name}"
end

number = rand(10)

puts "I would like to play with you. "
puts "So, I've picked a number from 1 to 10"

puts "What number?"

guesses = 0
while guess  = gets.to_i
  guesses = guesses + 1
  break if guess  == number
  puts "Sorry, #{name}"
  if guess > number
   puts "Too High. Guess again."
  else
   puts "Too low. Guess again."
  end 
end
if guesses == 1
  puts "OMG. #{name}, you must be psychic! That was my number!"
elsif (2..4).include? guesses
  puts "That's right. Reasonable guessing. But nothing to write home about."
else
  puts "You guessed it. But you could have raised a couple of children in the meantime!"
end
