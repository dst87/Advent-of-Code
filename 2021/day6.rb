#!/usr/bin/env ruby

require 'colorize'

fish = File.read("input/day6.txt").split(",").map!(&:to_i)

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

