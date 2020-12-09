#!/usr/bin/env ruby

require 'colorize'
require 'set'

program = File.read("input/day8.txt").split("\n")

puts "\nPart 1".red.on_black.underline

def execute(program, noisy = false)
	acc = 0
	index = 0
	prog_size = program.count
	
	index_log = []

	while true
		if index_log.include? index
			puts "🔴 Program error. Value at termination: #{acc}." if noisy
			break
		end
		if index >= program.count
			puts "✅  Program executed successfully. Status: #{acc}."
			break
		end
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
end

execute(program, true)

puts "\nPart 2".red.on_black.underline

program.each_with_index do | instruction, index |
	
	if instruction[0..2] == "jmp"
		new_ins = instruction.clone
		new_ins[0..2] = "nop"
		
		new_prog = program.clone
		new_prog[index] = new_ins
		
		execute(new_prog)
		next
	end
	if instruction[0..2] == "nop"
		new_ins = instruction.clone
		new_ins[0..2] = "jmp"
		
		new_prog = program.clone
		new_prog[index] = new_ins
		
		execute(new_prog)
		next
	end
end 