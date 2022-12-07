#!/usr/bin/env ruby

require 'colorize'
require 'set'

lines = File.read("input/day7.txt").split("\n")

currentPath = []
dirSizes = Hash.new

lines.each do |line|
	next if line.match?(/dir|\$ ls/) # We can just ignore dir and ls
	
	if line.match?(/\$ cd/)
		newDir = line.match(/\$ cd (.*)/)[1]
		if newDir == ".."
			currentPath.pop
		else
			currentPath.append(newDir)
		end
	end
	
	if line.match?(/\d*/)
		size = line.match(/(\d*)/)[1].to_i
		path = ""
		currentPath.each do |d|
			path = path + d
			path = path + "/" unless d == "/"
			
			if dirSizes.has_key?(path)
				dirSizes[path] += size
			else
				dirSizes[path] = size
			end
		end
	end
end


puts "\nPart 1".red.on_black.underline

answer = dirSizes.values.reduce(0) { |sum, x| 
	if x <= 100000
		sum + x
	else
		sum
	end
}

puts answer

puts "\nPart 2".red.on_black.underline

updateSize = 30000000
diskSize = 70000000
freeSpace = diskSize - dirSizes["/"]
needToFree = updateSize - freeSpace

puts dirSizes.values.sort.find { |n| n >= needToFree }
