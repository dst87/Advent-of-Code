#!/usr/bin/env ruby

require 'colorize'

starting_set = File.read("input/day15.txt").split(",")
starting_set.map!(&:to_i)

puts "\nPart 1".red.on_black.underline


def play_game_to(target, starting_set)
	lookup = Hash.new
	history = starting_set.clone
	
	starting_set.each_with_index do |n, i|
		lookup[n] = [i+1]
	end
	
	(starting_set.count+1..target).each do |i|
		previous = history.last
		if lookup[previous].count == 1
			history << 0
			lookup[0].unshift(i)
		else
			number = lookup[previous][0] - lookup[previous][1]
			history << number
			if lookup.has_key?(number)
				lookup[number].unshift(i)
			else
				lookup[number] = [i]
			end
		end
	end
	puts "After #{target} turns in the game the number is #{history.last}."
end

play_game_to(2020, starting_set)

puts "\nPart 2".red.on_black.underline
play_game_to(30000000, starting_set)
