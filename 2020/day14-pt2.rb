#!/usr/bin/env ruby

require 'colorize'

$program = File.read("input/day14.txt").split("\n")
$memory = Hash.new
$mask_str = ""
$mask_init = 0
$indices_of_x = []
$permutations = []

def process_mask(mask)
	$permutations = []
	$mask_str = mask
	$mask_init = mask.gsub(/X/,"0").to_i(2)
	
	$indices_of_x = []
	perm_count_2 = ""
	mask.length
	mask.length.times {|i| $indices_of_x << i if mask[i] == 'X'}
	mask.length.times {|i| perm_count_2 << "1" if mask[i] == 'X'}
	(0..perm_count_2.to_i(2)).each do |i|
		permutation = i.to_s(2).split("")
		while permutation.count < perm_count_2.length
			permutation.unshift("0")
		end
		$permutations << permutation
	end
end

def get_addresses(address)
	address_mod = address | $mask_init
	address = address_mod.to_s(2)
	
	while address.length < $mask_str.length
		address.prepend("0")
	end

	addresses = []
	
	$permutations.each do |permutation|
		add = address.clone
		$indices_of_x.each_with_index do |i, z|
			add[i] = permutation[z]
		end
		addresses << add.to_i(2)
	end	
	return addresses
end

def update_memory(instruction)
	parts = instruction.match /\[(\d+)\] = (\d+)/
	address = parts[1].to_i
	value = parts[2].to_i
	addresses = get_addresses(address)
	addresses.each do |address|
		$memory[address] = value
	end
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


puts "\nPart 2".red.on_black.underline
main_program()
puts "Sum of values in memory: #{$memory.values.reduce(:+)}."
