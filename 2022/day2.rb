#!/usr/bin/env ruby

require 'colorize'

rounds = File.read("input/day2.txt").split("\n").map { |e| e.split(" ") }

puts "\nPart 1".red.on_black.underline

score = 0

rounds.each do |round|
	me = round[1]
	you = round[0]
	
	case me
	when "X"
		score += 1
		score += 3 if you == "A"
		score += 6 if you == "C"
	when "Y"
	  score += 2
		score += 3 if you == "B"
		score += 6 if you == "A"
	when "Z"
		score += 3
		score += 3 if you == "C"
		score += 6 if you == "B"
	end
	
end

puts "I score #{score}."

puts "\nPart 2".red.on_black.underline

score = 0

rounds.each do |round|
	outcome = round[1]
	you = round[0]
	
	case outcome
	when "X" # I lose
		score += 3 if you == "A"
		score += 1 if you == "B"
		score += 2 if you == "C"
	when "Y" # It's a draw
		score += 3
		score += 1 if you == "A"
		score += 2 if you == "B"
		score += 3 if you == "C"
	when "Z" # I win
		score += 6
		score += 2 if you == "A"
		score += 3 if you == "B"
		score += 1 if you == "C"
	end
	
end

puts "I score #{score}."
