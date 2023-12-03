#!/usr/bin/env ruby

require 'colorize'
testData = "467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598.."

$schematic = File.read("input/day3.txt").split("\n")
# $schematic = testData.split("\n")
$maxHeight = $schematic.count
$maxLength = $schematic[0].length


def parseLine(line)
	arrayOfMatches = []
	line.scan(/(\d+)/) do |match|	
		partNoString = match[0]
		length = partNoString.length
		index = $~.offset(0)[0]
		arrayOfMatches.push({:n => partNoString.to_i, :l => length, :i => index})
	end
	return arrayOfMatches
end

def goodPart?(m, lineNumber)
	goodPart = false
	lStart = [lineNumber-1, 0].max
	lEnd = [lineNumber+1, $maxHeight-1].min
	
	iStart = [m[:i]-1,0].max
	iEnd = [m[:i]+m[:l],$maxLength-1].min

	(lStart..lEnd).each do |l|
		(iStart..iEnd).each do |i|
			goodPart = true if $schematic[l][i].match?(/[^\d.]/)
		end
	end
	
	return goodPart
end

partNumbers = []

$schematic.each_with_index do |line, i|
	matches = parseLine(line)
	matches.each do |match|
		partNumbers.push(match[:n]) if goodPart?(match, i)
	end
end

sumOfParts = partNumbers.inject(0, :+)

puts "\nPart 1".red.on_black.underline

puts "#{sumOfParts} is the sum of part numbers."

# puts "\nPart 2".red.on_black.underline
# 
# puts "#{sumOfParts} is the sum of part numbers."

