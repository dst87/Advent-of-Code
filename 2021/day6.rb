#!/usr/bin/env ruby

require 'colorize'

fish = File.read("input/day6.txt").split(",").map!(&:to_i)

fishCount = []

fishCount[0] = fish.count(0)
fishCount[1] = fish.count(1)
fishCount[2] = fish.count(2)
fishCount[3] = fish.count(3)
fishCount[4] = fish.count(4)
fishCount[5] = fish.count(5)
fishCount[6] = fish.count(6)
fishCount[7] = fish.count(7)
fishCount[8] = fish.count(8)

puts "\nPart 1".red.on_black.underline

def advance(fish)
	newFish = []
	fish.each do |f|
		case f
		when 1..8
			newFish << f-1
		when 0
			newFish << 6
			newFish << 8
		end
	end
	return newFish
end

days = 80

for i in 1..days
	fish = advance(fish)
end

puts "After #{days} days there will be #{fish.length} fish."
		
		
puts "\nPart 2".red.on_black.underline

days = 256

def advanceCounts(counts)
	newCounts = counts
	newFish = newCounts.shift
	newCounts[6] += newFish
	newCounts.push newFish
	return newCounts
end

for i in 1..days
	fishCount = advanceCounts(fishCount)
end

puts "After #{days} days there will be #{fishCount.sum} fish."
