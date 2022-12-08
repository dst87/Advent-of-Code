#!/usr/bin/env ruby
require 'colorize'

$lines = File.read("input/day8.txt").split("\n").map {|r| r.split("").map!(&:to_i)}
$yLines = $lines.transpose

$ySize = $lines.size
$xSize = $yLines.size

def visible?(x,y)
	# Edges are always visible and have a x or y that is 0 or size-1
	return true if x == 0 || x == $xSize-1
	return true if y == 0 || y == $ySize-1
	
	treeHeight = $lines[x][y]
	
	leftTrees = $lines[x][0..y-1]
	rightTrees = $lines[x][y+1..$ySize]
	
	upTrees = $yLines[y][0..x-1]
	downTrees = $yLines[y][x+1..$ySize]
		
	return true if leftTrees.none? { |h| h >= treeHeight }
	return true if rightTrees.none? { |h| h >= treeHeight }
	return true if upTrees.none? { |h| h >= treeHeight }
	return true if downTrees.none? { |h| h >= treeHeight }
	
	return false
end

def score(x,y)
	# Edges always score 0
	return 0 if x == 0 || x == $xSize-1
	return 0 if y == 0 || y == $ySize-1

	treeHeight = $lines[x][y]
	
	leftTrees = $lines[x][0..y-1].reverse
	rightTrees = $lines[x][y+1..$ySize]
	
	upTrees = $yLines[y][0..x-1].reverse
	downTrees = $yLines[y][x+1..$ySize]
	
	leftTreesScore=0	
	rightTreesScore=0
	
	upTreesScore=0
	downTreesScore=0

	leftTrees.each do |h|
		leftTreesScore += 1
		break if (h>=treeHeight)
	end
	
	rightTrees.each do |h|
		rightTreesScore += 1
		break if (h>=treeHeight)
	end

	upTrees.each do |h|
		upTreesScore += 1
		break if (h>=treeHeight)
	end

	downTrees.each do |h|
		downTreesScore += 1
		break if (h>=treeHeight)
	end

	return leftTreesScore * rightTreesScore * upTreesScore * downTreesScore
end


puts "\nPart 1".red.on_black.underline

count = 0

(0..$ySize-1).each do |y|
	(0..$xSize-1).each do |x|
		count += 1 if visible?(x,y)
	end
end

puts count

puts "\nPart 2".red.on_black.underline

bestScore = 0

(0..$ySize-1).each do |y|
	(0..$xSize-1).each do |x|
		score = score(x,y)
		bestScore = score if score > bestScore
	end
end

puts bestScore