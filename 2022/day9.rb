#!/usr/bin/env ruby
require 'colorize'
require 'set'

movements = File.read("input/day9.txt").split("\n").map { |m| m.split(" ") }

def moveTail(head, tail)
	newTail = tail
	
	if ( (head[:x]-tail[:x]).abs() <= 1 && (head[:y]-tail[:y]).abs() <= 1 )
		return newTail
	end
	
	if head[:y] > tail[:y]
		newTail[:y] += 1
	elsif head[:y] < tail[:y]
		newTail[:y] -= 1
	end
		
	if head[:x] > tail[:x]
		newTail[:x] += 1
	elsif head[:x] < tail[:x]
		newTail[:x] -= 1
	end
	
	return newTail
end

def moveHead(pos, dir)
	# L & R move on the x axis
	# U & D move on the y axis
	newHead = pos
	case dir
	when "R"
		newHead[:x] += 1
	when "L"
		newHead[:x] -= 1
	when "U"
		newHead[:y] += 1
	when "D"
		newHead[:y] -= 1
	end
	return newHead
end

puts "\nPart 1".red.on_black.underline

$tailVisitedPositions = Set.new
headPosition = {x: 0, y: 0}
tailPosition = {x: 0, y: 0}

$tailVisitedPositions << tailPosition

movements.each do |movement|
	direction = movement[0]
	distance = movement[1].to_i()
	
	distance.times do
		headPosition = moveHead(headPosition, direction)
		tailPosition = moveTail(headPosition, tailPosition)
		$tailVisitedPositions << tailPosition
	end
end

puts $tailVisitedPositions.size

puts "\nPart 2".red.on_black.underline

headPosition = {x: 0, y: 0}
tailNodes = [
	{x: 0, y: 0},
	{x: 0, y: 0},
	{x: 0, y: 0},
	{x: 0, y: 0},
	{x: 0, y: 0},
	{x: 0, y: 0},
	{x: 0, y: 0},
	{x: 0, y: 0},
	{x: 0, y: 0}
]

$tailVisitedPositions = Set.new
$tailVisitedPositions << tailNodes.last

movements.each do |movement|
	direction = movement[0]
	distance = movement[1].to_i()
	
	distance.times do
		headPosition = moveHead(headPosition, direction)
		
		tailNodes.each_with_index do |tailPosition, i|
			previousNodePos = i == 0 ? headPosition : tailNodes[i-1]
			tailNodes[i] = moveTail(previousNodePos, tailPosition)
		end
		$tailVisitedPositions << tailNodes.last
	end	
end

puts $tailVisitedPositions.size
