#!/usr/bin/env ruby

require 'colorize'
require 'set'

sums = File.read("Input/day18.txt").split("\n")

puts "\nPart 1".red.on_black.underline

class Integer
	def /(obj) 
		return self+obj
	end
	def -(obj)
		return self*obj
	end
end

answers = []

sums.each do |sum|
	answers << eval(sum.tr("+", "/"))
end

puts answers.inject(:+)

puts "\nPart 2".red.on_black.underline

answers = []

sums.each do |sum|
	answers << eval(sum.tr("+*", "/-"))
end

puts answers.inject(:+)
