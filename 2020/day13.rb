#!/usr/bin/env ruby

require 'colorize'

bus_notes = File.read("input/day13.txt").split("\n")

earliest_departure = bus_notes[0].to_i

puts "\nPart 1".red.on_black.underline

bus_numbers = []
(bus_notes[1].split(",")).each do |n|
	next if n == "x"
	bus_numbers.push n.to_i
end

bus_with_wait = Hash.new

bus_numbers.each do |bus|
	time_of_next_bus = (earliest_departure.to_f / bus.to_f).ceil.to_i * bus
	bus_with_wait[bus] = time_of_next_bus - earliest_departure
end

bus = bus_with_wait.sort_by { |bus, wait| wait }.first
answer = bus[0]*bus[1]

puts "I should get bus #{bus[0]} after waiting #{bus[1]} mins."
puts "The answer is #{answer}."

puts "\nPart 2".red.on_black.underline

# Build a dict of the bus numbers with required offset from t = 0

buses_with_offset = Hash.new
(bus_notes[1].split(",")).each_with_index do |n, i|
	next if n == "x"
	buses_with_offset[n.to_i] = i
end