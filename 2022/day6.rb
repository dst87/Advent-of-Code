#!/usr/bin/env ruby

require 'colorize'
require 'set'

buffer = File.read("input/day6.txt")

def isMarker?(marker)
	return marker.split("").to_set.size == marker.size
end

def packetMarkerForBuffer(input)
	input.size.times do |i|
		return i+4 if isMarker?(input[i,4])
	end
end

def messageMarkerForBuffer(input)
	input.size.times do |i|
		 return i+14 if isMarker?(input[i,14])
	end
end

puts "\nPart 1".red.on_black.underline

puts "The first packet marker appears after #{packetMarkerForBuffer(buffer)} characters."


puts "\nPart 2".red.on_black.underline

puts "The first message marker appears after #{messageMarkerForBuffer(buffer)} characters."

