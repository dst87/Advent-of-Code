#!/usr/bin/env ruby

require 'colorize'
require 'set'

notes = File.read("Input/day16.txt").split("\n\n")

rules_strings = notes[0].split("\n")

my_ticket_string = notes[1]

puts "\nPart 1".red.on_black.underline

# For part 1, let's just build an array of all valid values for any field

$valid_values = []

rules_strings.each do |rule_str|
	rule_parts = rule_str.match /([\s\S]+): (\d+)-(\d+) or (\d+)-(\d+)/
	# 1 = field
	# 2 - 3 = first range
	# 4 - 5 = second range
	a = rule_parts[2].to_i
	b = rule_parts[3].to_i
	x = rule_parts[4].to_i
	y = rule_parts[5].to_i
		
	(a..b).each do |i|
		$valid_values << i unless $valid_values.include?(i)
	end
	(x..y).each do |i|
		$valid_values << i unless $valid_values.include?(i)
	end
end

invalid_values = []

all_values = notes[2].split("\n")[1..-1].join(",").split(",")

all_values.each do |n|
	invalid_values << n.to_i unless $valid_values.include?(n.to_i)
end
answer = invalid_values.inject(0, :+)
puts "Ticket scanning error rate: #{answer}."

puts "\nPart 2".red.on_black.underline

valid_tickets = []

def is_valid?(ticket)
	valid = true
	ticket.split(",").each do |i|
		valid = false unless $valid_values.include?(i.to_i)
	end
	return valid
end

tickets = notes[2].split("\n")[1..-1]

tickets.each do |ticket|
	if is_valid?(ticket)
		ticket_a = ticket.split(",")
		new_ticket = ticket_a.map { |n| n.to_i }
		valid_tickets << new_ticket
	end
end

# Let's go through each 'rule' and find the index of the field that matches.
# For subsequent fields, skip fields in the positions that have been matched already.
# Store this in a Hash in the form field_id >> ticket_index

field_map = Hash.new

rules_strings.each do |rule_str|
	rule_parts = rule_str.match /([\s\S]+): (\d+)-(\d+) or (\d+)-(\d+)/
	# 1 = field
	# 2 - 3 = first range
	# 4 - 5 = second range
	field_name = rule_parts[1]
	a = rule_parts[2].to_i
	b = rule_parts[3].to_i
	x = rule_parts[4].to_i
	y = rule_parts[5].to_i
	
	possible_fields = Set[]
	
	(0..rules_strings.count-1).each do |i|
		skip = false
		next if field_map.has_value?(i)
		valid_tickets.each do |ticket|
			skip = true unless ((ticket[i] >= a && ticket[i] <= b) || (ticket[i] >= x && ticket[i] <= y))
			break if skip
		end
		possible_fields << i unless skip
	end
	field_map[field_name] = possible_fields
end


field_map_final = Hash.new
assigned = Set[]
sorted_field_possibilities = (field_map.sort_by { |name, array| array.count })

sorted_field_possibilities.each do |field|
	answer = field[1] - assigned
	assigned << answer.to_a[0]
	field_map_final[field[0]] = answer.to_a[0]
end

required_fields = []
field_map_final.each do |k, v|
	required_fields << v if k.match?(/^departure/)
end


my_ticket = my_ticket_string.split("\n")[1].split(",").map { |n| n.to_i }

values_to_multiple = []
my_ticket.each_with_index do |n, i|
	values_to_multiple << n if required_fields.include?(i)
end

answer = values_to_multiple.inject(:*)

puts "Product of fields starting with \"departure\": #{answer}"