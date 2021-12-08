#!/usr/bin/env ruby

require 'colorize'

lines = File.read("input/day8.txt").split("\n")

puts "\nPart 1".red.on_black.underline

goodLengths = [2,3,4,7]
count = 0

lines.each do |line|
	displays = line.split(" | ")[1]
	displays.split.each do |display|
		if goodLengths.include?(display.length)
			count += 1
		end
	end
end

puts "Digits 1, 4, 7, or 8 appear #{count} times."

# puts "\nPart 2".red.on_black.underline
