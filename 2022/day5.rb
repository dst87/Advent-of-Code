#!/usr/bin/env ruby

require 'colorize'
require 'set'


input = File.read("input/day5.txt").split("\n\n")
startString = input[0].split("\n")
instructions = input[1].split("\n").map { |str| str.scan(/move (\d+).+(\d+).+(\d+)/).flatten.map!(&:to_i) }

stacks = Hash.new

stackIDs = startString.pop

stackIDs.split("").each_with_index do |char, index|
	next if char == " "
	stacks[char.to_i] = []
	startString.each do |row|
		crate = row.split("")[index]
		if crate.match?(/[A-Z]/)
			stacks[char.to_i].append(crate)
		end
	end
end

stacks2 = Marshal.load(Marshal.dump(stacks))

puts "\nPart 1".red.on_black.underline

instructions.each do |instruction|
	qt = instruction[0]
	fr = instruction[1]
	to = instruction[2]
		
	qt.times do
		stacks[to].unshift(stacks[fr].shift)
	end

end

output = ""

stacks.each do |stack|
	output += stack[1][0]
end

puts output


puts "\nPart 2".red.on_black.underline

instructions.each do |instruction|
	qt = instruction[0]
	fr = instruction[1]
	to = instruction[2]
	new = stacks2[fr].shift(qt) + stacks2[to]
	stacks2[to] = new

end

output = ""

stacks2.each do |stack|
	output += stack[1][0]
end

puts output