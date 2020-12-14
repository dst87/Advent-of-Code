#!/usr/bin/env ruby

require 'colorize'

$program = File.read("input/day14.txt").split("\n")
$memory = Hash.new
$add_mask = 0
$or_mask = 0

def process_mask(mask)
	$or_mask = mask.gsub(/X/,"0").to_i(2)
	$and_mask = mask.gsub(/X/,"1").to_i(2)
end

def update_memory(instruction)
	parts = instruction.match /\[(\d+)\] = (\d+)/
	address = parts[1].to_i
	value = parts[2].to_i
	value = value & $and_mask
	value = value | $or_mask
	$memory[address] = value
end

def main_program()
	$program.each do |instruction|
		case instruction[0..2]
		when "mas"
			process_mask(instruction[7..])
		when "mem"
			update_memory(instruction)
		else
			puts "Invalid instruction #{instructions}."
		end
	end
end

main_program()
puts $memory.values.reduce(:+)
