#!/usr/bin/env ruby

require 'colorize'
require 'date'

@positions = File.read("input/day7.txt").split(",").map!(&:to_i)

puts "\nPart 1".red.on_black.underline

max = @positions.max
min = @positions.min

def fuelToPosition(t)
	fuelUsed = 0
	@positions.each do |p|
		fuelUsed += [t,p].max - [t,p].min
	end
	return fuelUsed
end

bestFuel = fuelToPosition(min)
position = min
(min+1..max).each do |t|
	newFuel = fuelToPosition(t)
	if newFuel < bestFuel
		bestFuel = newFuel
		position = t
	end
end

puts "The crabs should aim for position #{position}, using #{bestFuel} fuel."
	
puts "\nPart 2".red.on_black.underline

t1 = Time.now

def fuelToPositionV2(t)
	fuelUsed = 0
	@positions.each do |p|
		distance = [t,p].max - [t,p].min
		fuelUsed += (0..distance).to_a.sum
	end
	return fuelUsed
end

bestFuel = fuelToPositionV2(min)
position = min
(min+1..max).each do |t|
	newFuel = fuelToPositionV2(t)
	if newFuel < bestFuel
		bestFuel = newFuel
		position = t
	end
end

t2 = Time.now

puts "The crabs should aim for position #{position}, using #{bestFuel} fuel."
puts "(That took #{t2-t1} seconds.)"