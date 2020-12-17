#!/usr/bin/env ruby

require 'colorize'
require 'set'

starting_state = File.read("Input/day17.txt").split("\n")

puts "\nPart 2".red.on_black.underline

# The 'cube' can grow only one unit on each side per 'round'
# Tempting to make an initial cube that is the final size
# to make processing easier. [w][z][y][x]

# First, make the 'middle' layer.  The input is 8 x 8, so the
# final size needs to be 20 x 20, adding one in each dimension 
# every round (with 6 rounds)

expanded_layer = []

# Pad the rows of the input file with empty space (".")

starting_state.each do |row_string|
	row = row_string.split("")
	i = 1
	while i <= 6
		row.unshift(".")
		row.push(".")
		i += 1
	end
	expanded_layer << row
end

# Now, add the additional empty rows to complete the 'middle' layer

empty_row = Array.new(20, ".")

i = 1
while i <= 6
	expanded_layer.unshift(empty_row)
	expanded_layer.push(empty_row)
	i += 1
end

# Create an empty layer

$empty_layer = Array.new(20, empty_row)

# Create the overall dimension / layout with the expanded layer.
# then add 6 empty layers 'above' and 'below'.
# Final size is 13 x 20 x 20.

d_layout = [expanded_layer]
i = 1
while i <= 6
	d_layout.unshift($empty_layer)
	d_layout.push($empty_layer)
	i += 1
end

$empty_3d_layout = Array.new(13, $empty_layer)

layout = [d_layout]
i = 1
while i <= 6
	layout.unshift($empty_3d_layout)
	layout.push($empty_3d_layout)
	i += 1
end

# Method to process the input, returning the new layout.

def active_neighbours_count(w, z, y, x, layout)
	adjacent_states = []
	(w-1..w+1).each do |ww|
		next if ww < 0 || ww > 12
		(z-1..z+1).each do |zz|
			next if zz < 0 || zz > 12
			(x-1..x+1).each do |xx|
				next if xx < 0 || xx > 19
				(y-1..y+1).each do |yy|
					next if yy < 0 || yy > 19
					next if (w == ww) && (z == zz) && (y == yy) && (x == xx)
					adjacent_states << layout[ww][zz][yy][xx]
				end
			end
		end
	end
	return adjacent_states.count("#")
end

def cycle(input)
	new_layout = []
	input.each_with_index do |dimension, w|
		new_layout[w] ||= []
		dimension.each_with_index do |layer, z|
			new_layout[w][z] ||= []
			layer.each_with_index do |row, y|
				new_layout[w][z][y] ||= []
				row.each_with_index do |state, x|
					new_layout[w][z][y][x] ||= []
					count = active_neighbours_count(w, z, y, x, input)
					new_state = state.clone
					case state
					when "#" # Active
						new_state = "." unless (count == 2 || count == 3)
					when "." # Inactive
						new_state = "#" if count == 3
					else
						puts "Unknown state: #{state}."
					end
					new_layout[w][z][y][x] = new_state
				end
			end
		end
	end
	return new_layout
end

i = 1
while i <= 6
	layout = cycle(layout)
	i += 1
end

answer = layout.flatten.count("#")
puts "There are #{answer} active cubes after the 6th cycle."