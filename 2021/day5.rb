#!/usr/bin/env ruby

require 'colorize'

input = File.read("input/day5.txt")

class Point
	attr_accessor :x, :y
	def initialize(x, y)
		@x, @y = x, y
	end
	def to_s
		"#{x},#{y}"
	end
end

class Line
	attr_accessor :a, :b
	def initialize(a, b)
		@a, @b = a, b
	end
	def to_s
		"#{a} -> #{b}"
	end
	def diagonal?
		return !((a.x == b.x) || (a.y == b.y))
	end
	def allPoints
		points = []
		
		if self.diagonal?
			xs = ([a.x,b.x].min..[a.x,b.x].max).to_a
			ys = ([a.y,b.y].min..[a.y,b.y].max).to_a
			xs = xs.reverse if (b.x < a.x)
			ys = ys.reverse if (b.y < a.y)
			xs.each_with_index do |x, i|
				points << Point.new(x,ys[i])
			end
		else
			if a.x == b.x
				x = a.x
				for y in [a.y,b.y].min..[a.y,b.y].max
					points << Point.new(x,y)
				end
			else
				y = a.y
				for x in [a.x,b.x].min..[a.x,b.x].max
					points << Point.new(x,y)
				end
			end
		end
		return points
	end
end

# Make a square 2D array filled with 0s
maxSize = input.scan(/\d+/).map!(&:to_i).max
diagram = Array.new(maxSize+1) {
	Array.new(maxSize+1) { 0 }
}

# Make an array of lines from input
lines = []
input.split("\n").each do |line|
	coords = line.scan(/\d+/).map!(&:to_i)
	a = Point.new(coords[0], coords[1])
	b = Point.new(coords[2], coords[3])
	lines << Line.new(a, b)
end

puts "\nPart 1".red.on_black.underline

lines.each do |line|
	if !line.diagonal?
		points = line.allPoints()
		points.each do |point|
			diagram[point.x][point.y] += 1
		end
	end
end

allPositions = diagram.flatten
dangerCount = allPositions.select{|n| n > 1 }.count

puts "There are #{dangerCount} points where 2+ lines overlap."


puts "\nPart 2".red.on_black.underline

lines.each do |line|
	if line.diagonal?
		points = line.allPoints()
		points.each do |point|
			diagram[point.x][point.y] += 1
		end
	end
end

allPositions = diagram.flatten
dangerCount = allPositions.select{|n| n > 1 }.count

puts "There are #{dangerCount} points where 2+ lines overlap."
