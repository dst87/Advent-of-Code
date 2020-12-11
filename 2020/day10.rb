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

# I had no idea how to do this, so my part 2 solution is an implementation
# of a solution I found on Reddit here:
# https://www.reddit.com/r/adventofcode/comments/ka8z8x/2020_day_10_solutions/gf9pg9n
# It's very elegant, and I can work out how and why it works, but I'd never
# have arrived at the solution myself.

number_of_links = Hash.new
number_of_links[0] = 1

ratings.each do |rating|
	next if rating == 0
	a = number_of_links[rating-1] || 0
	b = number_of_links[rating-2] || 0
	c = number_of_links[rating-3] || 0
	
	number_of_links[rating] = a + b + c
end

puts "There are #{number_of_links[ratings.last]} possible ways of connecting my device to the outlet. 🔌📱"
