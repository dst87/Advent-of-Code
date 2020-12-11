#!/usr/bin/env ruby

require 'colorize'
require 'set'

$layout = File.read("input/day11.txt").split("\n")

puts "\nPart 1".red.on_black.underline

$height = $layout.count
$width =  $layout[1].length

def adjacent_positions_to(row, col, map)
	array_of_results = []
	(row-1..row+1).each do |row_i|
		next if row_i < 0 || row_i >= $height
		(col-1..col+1).each do |col_i|
			next if col_i < 0 || col_i >= $width
			next if col_i == col && row_i == row
			array_of_results.push map[row_i][col_i]
		end
	end
	return array_of_results
end

def stable_layout_for(map)
	new_map = []
	map.each_with_index do |row, row_i|
		new_row = ""
		locs = row.split("")
		locs.each_with_index do |loc, col_i|
			comparison = adjacent_positions_to(row_i, col_i, map)
			occupied_seats = comparison.count("#")
			case loc
			when "L"
				char = occupied_seats == 0 ? "#" : "L"
				new_row << char
			when "#"
				char = occupied_seats >= 4 ? "L" : "#"
				new_row << char
			when "."
				new_row << "."
			else
				puts "Error! #{loc}"
				break
			end
		end
		new_map.push(new_row)
	end
	if map == new_map
		return map
	else
		return stable_layout_for(new_map)
	end
end

stable_layout = stable_layout_for($layout)
layout_str = stable_layout.join("")
count = layout_str.count("#")
puts "There are #{count} occupied seats in the stable layout."

puts "\nPart 2".red.on_black.underline

def visible_positions_to(row, col, map)
	height = map.count
	width =  map[1].length
	
	
	array_of_results = []
	(-1..1).each do |x_dir|
		(-1..1).each do |y_dir|
			next if (x_dir == 0) && (y_dir == 0)
			found = false
			distance = 1
			until found == true
				target_y = row+distance*y_dir
				target_x = col+distance*x_dir
				if target_y < 0 || target_y >= height || target_x < 0 || target_x >= width
					found = true
					array_of_results.push "."
					next
				end
				pos = map[target_y][target_x]
				if (pos == "L") | (pos == "#")
					array_of_results.push pos
					found = true
				end
				distance += 1
			end
		end
	end
	return array_of_results
end

def revised_stable_layout_for(map)
	new_map = []
	map.each_with_index do |row, row_i|
		new_row = ""
		locs = row.split("")
		locs.each_with_index do |loc, col_i|
			comparison = visible_positions_to(row_i, col_i, map)
			occupied_seats = comparison.count("#")
			case loc
			when "L"
				char = occupied_seats == 0 ? "#" : "L"
				new_row << char
			when "#"
				char = occupied_seats >= 5 ? "L" : "#"
				new_row << char
			when "."
				new_row << "."
			else
				puts "Error! #{loc}"
				break
			end
		end
		new_map.push(new_row)
	end
	if map == new_map
		return map
	else
		return revised_stable_layout_for(new_map)
	end
end


revised_stable_layout = revised_stable_layout_for($layout)
layout_str = revised_stable_layout.join("")
count = layout_str.count("#")
puts "There are #{count} occupied seats in the stable layout."


