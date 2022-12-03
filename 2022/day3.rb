#!/usr/bin/env ruby

require 'colorize'
require 'set'

bags = File.read("input/day3.txt").split("\n").map { |str| str.partition(/.{#{str.size / 2}}/)[1,2] }

puts "\nPart 1".red.on_black.underline

leftovers = []

bags.each do |bag|
	comp1 = bag[0].split("").to_set
	comp2 = bag[1].split("").to_set
	
	leftovers.append((comp1 & comp2).to_a[0])	
end

priority = 0

letters = ('a'..'z').to_a + (('A'..'Z').to_a)

leftovers.each do |i|
	priority += letters.index(i)+1
end

puts "The sum of priorities of items appearing in both compartments of each rucksack is #{priority}."


puts "\nPart 2".red.on_black.underline

groups = File.read("input/day3.txt").scan(/(.+\n.+\n.+)/).flatten.map { |str| str.split("\n") }

badges = []

groups.each do |group|
	bag1 = group[0].split("").to_set
	bag2 = group[1].split("").to_set
	bag3 = group[2].split("").to_set
	
	badges.append((bag1 & bag2 & bag3).to_a[0])
end

priority = 0

badges.each do |i|
	priority += letters.index(i)+1
end

puts "The sum of priorities of all group badges is #{priority}."
