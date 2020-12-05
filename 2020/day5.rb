#!/usr/bin/env ruby

require 'colorize'

seatStrings = File.read("input/day5.txt").split("\n")

puts "\nPart 1".red.on_black.underline

seatIDs = []

seatStrings.each do |seatString|
	seat = seatString.match /([FB]{7})([RL]{3})/
	replace = {
		"F" => "0",
		"L" => "0",
		"B" => "1",
		"R" => "1"
	}
	row = seat[1].gsub!(/\w/, replace).to_i(2)
	col = seat[2].gsub!(/\w/, replace).to_i(2)
	seatID = (row * 8) + col
	seatIDs.push(seatID)
end

seatIDs.sort!

puts "The highest seat ID is #{seatIDs.last}."

puts "\nPart 2".red.on_black.underline

seat = seatIDs[0]
highest = seatIDs.last

allseats = []

while seat <= highest do
	allseats.push(seat)
	seat += 1
end

myseat = allseats - seatIDs

puts "My seat ID is #{myseat[0]}. 🛫"