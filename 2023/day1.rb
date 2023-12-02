#!/usr/bin/env ruby

require 'colorize'

lines = File.read("input/day1.txt").split("\n")

puts "\nPart 1".red.on_black.underline

numbers = []

lines.each do |line|
	numOnly = line.gsub(/\D/, "")
	numStr = numOnly.chars.first + numOnly.chars.last
	numbers.push(numStr.to_i)
end

total = numbers.inject(0, :+)

puts "#{total} is the sum of all of the calibration values."

puts "\nPart 2".red.on_black.underline

numbers = []
map = {
	'one' => '1',
	'two' => '2',
	'three' => '3',
	'four' => '4',
	'five' => '5',
	'six' => '6',
	'seven' => '7',
	'eight' => '8',
	'nine' => '9',
	}

lines.each do |line|
	numsOnly = line.scan(/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/)
	numsOnly = numsOnly.join("")
	map.each {|k,v| numsOnly.gsub!(k,v)}
	numStr = numsOnly.chars.first + numsOnly.chars.last
	numbers.push(numStr.to_i)
end

total = numbers.inject(0, :+)

puts "#{total} is the sum of all of the calibration values."
