#!/usr/bin/env ruby

require 'colorize'
require 'set'

rating_str = File.read("input/day10.txt").split("\n")
ratings = rating_str.map(&:to_i)


puts "\nPart 1".red.on_black.underline

one_jolt_count = 0
thr_jolt_count = 0

ratings.push(0)
ratings.push(ratings.max + 3)
ratings.sort!

ratings.each_with_index do |rating, i|
	next if i == 0
	diff = rating - ratings[i-1]
	one_jolt_count += 1 if diff == 1
	thr_jolt_count += 1 if diff == 3
	if diff > 3
		puts "Unable to link adapters with difference of #{diff}"
		break
	end
end

puts "The answer to part 1 is #{one_jolt_count * thr_jolt_count}."

puts "\nPart 2".red.on_black.underline

