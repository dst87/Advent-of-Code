#!/usr/bin/env ruby

require 'colorize'
require 'set'

assignments = File.read("input/day4.txt").split("\n").map { |str| str.split(",") }

puts "\nPart 1".red.on_black.underline

count = 0

assignments.each do |assignment|
	elf1 = assignment[0].split("-").map!(&:to_i)
	elf2 = assignment[1].split("-").map!(&:to_i)
	
	if elf1[0] <= elf2[0] && elf1[1] >= elf2[1]
		count += 1
		next
	end
	
	if elf1[0] >= elf2[0] && elf1[1] <= elf2[1]
		count += 1
	end
end

puts "There are #{count} badly planned elf worker pairs."

puts "\nPart 2".red.on_black.underline

count = 0

assignments.each do |assignment|
	range1 = assignment[0].split("-").map!(&:to_i)
	range2 = assignment[1].split("-").map!(&:to_i)
	
	set1 = Set.new(range1[0]..range1[1])
	set2 = Set.new(range2[0]..range2[1])

	intersection = set1 & set2
	
	count += 1 if intersection.size > 0
	
end

puts "There are #{count} elf worker pairs with overlapping work."
