#!/usr/bin/env ruby
require 'colorize'

steps = File.read("input/day10.txt").split("\n")

puts "\nPart 1".red.on_black.underline

cycles = [1]
x = 1

steps.each do |step|
	step = step.match(/(?<instruction>noop|addx) ?(?<value>-?\d*)/)
	case step[:instruction]
	when "noop"
		cycles << x
	when "addx"
		2.times { cycles << x }
		x += step[:value].to_i
	end
end

puts 20*cycles[20] + 60*cycles[60] + 100*cycles[100] + 140*cycles[140] + 180*cycles[180] + 220*cycles[220]

puts "\nPart 2".red.on_black.underline

pixels = ""
cycles.shift
cycles.each_with_index do |spriteCentrePos, i|
	spritePositions = (spriteCentrePos-1..spriteCentrePos+1).to_a
	rowPosition = i%40
	pixel = spritePositions.include?(rowPosition) ? "█" : " "
	pixels << pixel
	pixels << "\n" if rowPosition == 39
end

puts pixels
