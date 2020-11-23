#!/usr/bin/env ruby

=begin
I decided to re-do Day 1 in Ruby as I've never used
Ruby before and wanted to get a wee taste of it.

I may use Ruby for AoC 2020!!
=end

require 'colorize'

arrayOfModuleMasses = File.read("input/day1.txt").split

if arrayOfModuleMasses.length != nil
	puts "File loaded successfully!"
	
	puts "\nPart 1".red.on_black.underline
	
	fuelRequired = 0
	
	arrayOfModuleMasses.each do |moduleMass|
		fuelforModule = (moduleMass.to_f/3).floor - 2
		fuelRequired += fuelforModule
	end
	
	puts "Total fuel required: #{fuelRequired}"
	
	puts "\nPart 2".red.on_black.underline
	
	fuelRequired = 0
	
	arrayOfModuleMasses.each do |moduleMassString|
		moduleMass = moduleMassString.to_f
		
		while moduleMass > 0 do
			fuelforModule = (moduleMass.to_f/3).floor - 2
			if fuelforModule > 0
				fuelRequired += fuelforModule
			end
			moduleMass = fuelforModule
		end
	end
	
	puts "Total fuel required: #{fuelRequired}"
	
end