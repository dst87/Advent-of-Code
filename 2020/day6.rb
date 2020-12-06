#!/usr/bin/env ruby

require 'colorize'

family_responses = File.read("input/day6.txt").split("\n\n")

puts "\nPart 1".red.on_black.underline

count = 0

family_responses.each do |response|
	chars = response.split('').uniq
	chars.delete("\n")
	count += chars.count
end

puts "The answer is: #{count}."

puts "\nPart 2".red.on_black.underline

count = 0

family_responses.each do |response|
	members = response.split("\n")
	array_of_answers = []
	members.each do |member|
		chars = member.split('')
		array_of_answers.push(chars)
	end
	count += eval(array_of_answers.map(&:to_s).join("&")).count
end

puts "The answer is: #{count}."

