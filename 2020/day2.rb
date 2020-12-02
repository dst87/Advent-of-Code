#!/usr/bin/env ruby

require 'colorize'

arrayOfEntries = File.read("input/day2.txt").split("\n")

puts "\nPart 1".red.on_black.underline

validCounter = 0

arrayOfEntries.each do |entry|
	groups = entry.match /(\d+(?=-))-(\d+(?= )) ([a-z]): ([a-z]+)/
	minCount = groups[1].to_i
	maxCount = groups[2].to_i
	reqChar = groups[3]
	password = groups[4]
		
	if minCount <= password.count(reqChar) && password.count(reqChar) <= maxCount
		validCounter += 1
	end
end

puts "🔐 There are #{validCounter} valid passwords."

puts "\nPart 2".red.on_black.underline

validCounter = 0

arrayOfEntries.each do |entry|
	groups = entry.match /(\d+(?=-))-(\d+(?= )) ([a-z]): ([a-z]+)/
	firstIndex = groups[1].to_i - 1
	secondIndex = groups[2].to_i - 1
	reqChar = groups[3]
	password = groups[4]
		
	if (password[firstIndex] == reqChar) ^ (password[secondIndex] == reqChar)
		validCounter += 1
	end
end

puts "🔐 There are #{validCounter} valid passwords."
