#!/usr/bin/env ruby

require 'colorize'

arrayOfCommands = File.read("input/day2.txt").split("\n")

puts "\nPart 1".red.on_black.underline

h = 0 # Horizontal Position
d = 0 # Depth

arrayOfCommands.each do |command|
	command = command.split()
	direction = command[0]
	units = command[1].to_i
	case direction
	when "forward"
		h += units # Full Ahead!
	when "up"
		d -= units
	when "down"
		d += units # Dive! Dive! Dive!
	else
		puts "Unknown Instruction"
	end
end

puts "Position: #{h}. Depth: #{d}."
puts "Position x Depth = #{h*d}."

puts "\nPart 2".red.on_black.underline

h = 0 # Horizontal Position
d = 0 # Depth
a = 0 # Aim

arrayOfCommands.each do |command|
	command = command.split()
	direction = command[0]
	units = command[1].to_i
	case direction
	when "forward"
		h += units
		d += a * units
	when "up"
		a -= units
	when "down"
		a += units
	else
		puts "Unknown Instruction"
	end
end

puts "Position: #{h}. Depth: #{d}."
puts "Position x Depth = #{h*d}."
