#!/usr/bin/env ruby

require 'colorize'

foodStores = File.read("input/day1.txt").split("\n\n").map { |e| e.split("\n").map!(&:to_i) }

puts "\nPart 1".red.on_black.underline

totalFood = []

foodStores.each do |stash|
	totalFood.append(stash.inject(:+))
end

puts "The elf with the most food is carrying #{totalFood.sort!.last} calories of delicious provisions."

puts "\nPart 2".red.on_black.underline

puts "The three elves with the most food are collectively carrying #{totalFood.sort![-3..-1].inject(:+)} calories of delicious provisions."
