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

puts "\nPart 1".red.on_black.underline

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
	c = ""
	iBefore = m[:i] - 1
	iBefore = nil if iBefore < 0
	iAfter = m[:i] + m[:l]
	iAfter = nil if iAfter > $maxLength
	iStart = iBefore || 0
	iEnd = iAfter || $maxLength-1
	
	# Get chars on same line
	c << $schematic[lineNumber][iStart..iEnd]
	
	# Get chars on the previous line
	if lineNumber-1 >= 0
		c << $schematic[lineNumber-1][iStart..iEnd]
	end
	
	if lineNumber+1 < $maxHeight
		c << $schematic[lineNumber+1][iStart..iEnd]
	end
	return c.match?(/[^\d.]/)
end

partNumbers = []

$schematic.each_with_index do |line, i|
	matches = parseLine(line)
	matches.each do |match|
		partNumbers.push(match[:n]) if goodPart?(match, i)
	end
end

sumOfParts = partNumbers.inject(0, :+)

puts "#{sumOfParts} is the sum of part numbers."

