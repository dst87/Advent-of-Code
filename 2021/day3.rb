#!/usr/bin/env ruby

require 'colorize'

arrayOfNumbers = File.read("input/day3.txt").split("\n")
count = arrayOfNumbers.length
length = arrayOfNumbers[0].length

def modeCharsAtIndex (arr, i)
	target = arr.length / 2
	zeroCount = 0
	arr.each do |number|
		zeroCount += 1 if number[i] == "0"
	end
	return zeroCount > target ? ["0","1"] : ["1","0"]
end


puts "\nPart 1".red.on_black.underline

# I refactored part 1 after reading part two.
# Originally I did not use modeCharAtIndex.

g = "" # Construct a new binary string
e = ""

for i in 0..length-1
	mode = modeCharsAtIndex(arrayOfNumbers, i)[0]
	case mode
	when "0"
		g << "0"
		e << "1"
	when "1"
		g << "1"
		e << "0"
	else
		puts "Unexpected value from modeCharAtIndex"
	end
end

gamma = g.to_i(base=2)
epsilon = e.to_i(base=2)

puts "The power consumption is #{gamma*epsilon}."


puts "\nPart 2".red.on_black.underline

# Type Values:
# OXY = oxygen generator rating (most common)
# CO2 = CO2 scrubber rating (least common)
def getRating (type, arr, i = 0)
	
	return arr[0] if arr.length == 1
	
	mode = modeCharsAtIndex(arr, i)
	case type
	when "OXY"
		keep = mode[0]
	when "CO2"
		keep = mode[1]
	else
		puts "Invalid type '#{type}' for getRating."
	end
	
	newArr = []
	arr.each do |n|
		if n[i] == keep
			newArr << n
		end
	end
	
	i += 1
	return getRating(type, newArr, i)
end

oxygenRating = getRating("OXY", arrayOfNumbers).to_i(base=2)
CO2Rating = getRating("CO2", arrayOfNumbers).to_i(base=2)
lifeSupportRating = oxygenRating*CO2Rating
puts "The life support rating of the submarine is #{lifeSupportRating}."
