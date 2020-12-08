#!/usr/bin/env ruby

require 'colorize'
require 'set'

program = File.read("input/day8.txt").split("\n")

puts "\nPart 1".red.on_black.underline

acc = 0
index = 0

index_log = []

while true
	break if index_log.include? index
	index_log.push(index)
	
	instruction = program[index][0..2]
	movement = program[index][4..].to_i
	
	case instruction
	when "acc"
		acc += movement
		index += 1
	when "jmp"
		index += movement
	when "nop"
		index += 1
	else
		puts "⚠️ Invalid Instruction"
		break
	end 
end

puts "Accumulator value at corrupt line: #{acc}"


	