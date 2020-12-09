#!/usr/bin/env ruby

require 'colorize'
require 'set'

list_str = File.read("input/day9.txt").split("\n")
list = list_str.map(&:to_i)


puts "\nPart 1".red.on_black.underline

first_index_offset = -25
last_index_offset = -1
preamble_length = 25
target = 0

list.each_with_index do |number, i|
	next if i < preamble_length
	ok = false
	previous_25 = list[i+first_index_offset..i+last_index_offset]
	previous_25.each_with_index do |a, x|
		break if ok
		previous_25.each_with_index do |b, y|
			break if ok
			next if y <= x 
			if a + b == number
				ok = true
			end
		end
	end
	
	if not ok
		target = number
		puts "#{target} is the first number that isn't the sum of the previous 25!"
		break
	end
end

puts "\nPart 2".red.on_black.underline

done = false

list.each_with_index do |a, x|
	break if done
	break if a == target
	sum = a
	list.each_with_index do |b, y|
		next if y <= x
		break if done
		sum += b
		if sum == target
			done = true
			subset = list[x..y]
			answer = subset.min + subset.max
			puts "The encryption weakness is #{answer}."
		end
		break if sum > target
	end
end
				