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

$partNumbers = []
$possibleGears = Hash.new

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

def processPart(m, lineNumber)
	goodPart = false
	lStart = [lineNumber-1, 0].max
	lEnd = [lineNumber+1, $maxHeight-1].min
	
	iStart = [m[:i]-1,0].max
	iEnd = [m[:i]+m[:l],$maxLength-1].min

	(lStart..lEnd).each do |l|
		(iStart..iEnd).each do |i|
			goodPart = true if $schematic[l][i].match?(/[^\d.]/)
			if $schematic[l][i] == "*"
				$possibleGears["#{l},#{i}"] = [] if $possibleGears["#{l},#{i}"] == nil
				$possibleGears["#{l},#{i}"] << m[:n]
			end
		end
	end
	
	$partNumbers.push(m[:n]) if goodPart
end



$schematic.each_with_index do |line, i|
	matches = parseLine(line)
	matches.each do |match|
		processPart(match,i)
	end
end

sumOfParts = $partNumbers.inject(0, :+)

puts "\nPart 1".red.on_black.underline

puts "#{sumOfParts} is the sum of part numbers."

puts "\nPart 2".red.on_black.underline

sumOfGearRatios = 0

$possibleGears.each do |k,v|
	if v.count == 2
		sumOfGearRatios += v.inject(:*)
	end
end

puts "#{sumOfGearRatios} is the sum of all of the gear ratios."
