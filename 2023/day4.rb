#!/usr/bin/env ruby

require 'colorize'
testData = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11"

cardsRaw = File.read("input/day4.txt").split("\n")
# cardsRaw = testData.split("\n")

puts "\nPart 1".red.on_black.underline

points = 0

cards = []

cardsRaw.each do |card|
	cardNumber = card.scan(/Card\s+(\d+)/).join("").to_i
	card.sub!(/Card\s+\d+:\s+/, "")
	card = card.split(/\s+\|\s+/)
	winNums = card[0].split(/\s+/).map(&:to_i)
	plrNums = card[1].split(/\s+/).map(&:to_i)
	hits = winNums & plrNums
	
	# Re-factored Pt. 1 to store this data type to track the cards for part 2
	cards << {:no => cardNumber, :winNums => winNums, :plrNums => plrNums, :hits => hits, :value => 1}
	
	# … but I was too lazy to do any additional re-factoring of Pt. 1 
	thisPoints = (hits.count > 0 ? 1*2**(hits.count-1) : 0)
	points += thisPoints
end

puts "The lucky elf has scratchcards worth a staggering #{points} points!"

puts "\nPart 2".red.on_black.underline

(cards.count-1).downto(0).each do |i| # Loop through the cards backwards
	wins = cards[i][:hits].count # This is the number of matches (or the number of new cards added)
	next if wins == 0
	(i+1..i+wins).each do |j|
		# For each new card spawned, add the cards spawned for that card
		# to the value for THIS card
		cards[i][:value] += cards[j][:value]
	end
end

totalCards = cards.reduce(0) { |sum, card| sum + card[:value] }
puts "The lucky elf ends up with #{totalCards} scratchcards!"
