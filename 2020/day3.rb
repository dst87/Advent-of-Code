#!/usr/bin/env ruby

require 'colorize'

arrayOfRows = File.read("input/day3.txt").split("\n")

puts "\nPart 1".red.on_black.underline

treeCount = 0
repeatInterval = arrayOfRows[0].length # Returns 31?
tree = "#"


arrayOfRows.each_with_index do |row, i|
	next if i == 0
	col = (3 * i) % repeatInterval
	if row[col] == tree
		treeCount += 1
	end
end

puts "There are #{treeCount} pesky trees in the way."

puts "\nPart 2".red.on_black.underline


def treesOnRoute(right, down, arrayOfRows, tree)
	repeatInterval = arrayOfRows[0].length
	treeCount = 0
	jumpCount = 0
	arrayOfRows.each_with_index do |row, i|
		next if i == 0
		next if i % down != 0
		jumpCount += 1
		col = (right * jumpCount) % repeatInterval
		if row[col] == tree
				treeCount += 1
		end
	end
	puts "There are #{treeCount} pesky trees in the way."
	return treeCount

end

route1 = treesOnRoute(1,1,arrayOfRows,tree)
route2 = treesOnRoute(3,1,arrayOfRows,tree)
route3 = treesOnRoute(5,1,arrayOfRows,tree)
route4 = treesOnRoute(7,1,arrayOfRows,tree)
route5 = treesOnRoute(1,2,arrayOfRows,tree)

answer = route1 * route2 * route3 * route4 * route5

puts "The product is #{answer}!"