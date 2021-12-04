#!/usr/bin/env ruby

require 'colorize'

arrayOfDepths = File.read("input/day1.txt").split.map!(&:to_i)

puts "\nPart 1".red.on_black.underline

increaseCount = 0
for i in 1..arrayOfDepths.length-1
	if arrayOfDepths[i] > arrayOfDepths[i-1]
		increaseCount += 1 
	end
end

puts "There are #{increaseCount} measurements larger than the previous measurement."

puts "\nPart 2".red.on_black.underline
increaseCount = 0
arrayOfWindows = []
for i in 0..arrayOfDepths.length-3
	arrayOfWindows.push(arrayOfDepths[i]+arrayOfDepths[i+1]+arrayOfDepths[i+2])
end

for i in 1..arrayOfWindows.length-1
	if arrayOfWindows[i] > arrayOfWindows[i-1]
		increaseCount += 1 
	end
end

puts "There are #{increaseCount} groups larger than the previous group."
