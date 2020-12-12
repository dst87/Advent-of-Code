#!/usr/bin/env ruby

require 'colorize'

instructions = File.read("input/day12.txt").split("\n")
test_input = "F10
N3
F7
R90
F11"

test_inst = test_input.split("\n")

puts "\nPart 1".red.on_black.underline

# *****************
# **  Movements  **
# *****************
#
# North: position[1] +=
# South: position[1] -=
# East: position[0] +=
# West: position[0] -=

def turn(dir, val)
	i_now = $directions.index($direction)
	i_change = dir == "R" ? (val / 90 * 1) : (val / 90 * -1)
	i_new = (i_now + i_change) % 4
	$direction = $directions[i_new]
end

def move(dir, val)
	case dir
	when "N"
		$position[1] += val
	when "S"
		$position[1] -= val
	when "E"
		$position[0] += val
	when "W"
		$position[0] -= val
	else
		"🔴 Unable to move ship #{dir} by #{val}."
	end
end

$directions = ["N", "E", "S", "W"]
$direction = "E"
$position = [0,0] 

instructions.each do |instruction|
	action = instruction[0]
	value = instruction[1..].to_i
	
	case action
	when "N", "E", "S", "W"
		move(action, value)
	when "R", "L"
		turn(action, value)
	when "F"
		move($direction, value)
	else
		"🔴  Invalid instruction #{action}."
	end
end

unsigned_position = $position.map { |n| n < 0 ? -n : n }
answer = unsigned_position.reduce(0, :+)
puts "Manhattan distance between here and where we started: #{answer}."


puts "\nPart 2".red.on_black.underline

$position = [0,0] 
$waypoint = [10,1]

def wp_move(dir, val)
	case dir
	when "N"
		$waypoint[1] += val
	when "S"
		$waypoint[1] -= val
	when "E"
		$waypoint[0] += val
	when "W"
		$waypoint[0] -= val
	else
		"🔴 Unable to move waypoint #{dir} by #{val}."
	end
end

def wp_turn(dir, val)
	x = $waypoint[0]
	y = $waypoint[1]
	
	unsigned_rad = val * (Math::PI / 180)
	rad = dir == "R" ? -unsigned_rad : unsigned_rad
	
	new_x = ((x * Math.cos(rad)) - (y * Math.sin(rad))).round
	new_y = ((x * Math.sin(rad)) + (y * Math.cos(rad))).round
	
	$waypoint[0] = new_x
	$waypoint[1] = new_y
end

def sh_move(val)
	$position[0] += (val * $waypoint[0])
	$position[1] += (val * $waypoint[1])
end

instructions.each do |instruction|
	action = instruction[0]
	value = instruction[1..].to_i

	case action
	when "N", "E", "S", "W"
		wp_move(action, value)
	when "R", "L"
		wp_turn(action, value)
	when "F"
		sh_move(value)
	else
		"🔴  Invalid instruction #{action}."
	end
end

unsigned_position = $position.map { |n| n < 0 ? -n : n }
answer = unsigned_position.reduce(0, :+)
puts "Manhattan distance between here and where we started: #{answer}."
