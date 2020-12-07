#!/usr/bin/env ruby

require 'colorize'
require 'set'

bag_descriptions = File.read("input/day7.txt").split("\n")

puts "\nPart 1".red.on_black.underline

# Match container using /(.+)(?= bags contain)/
# Match each bag using /(\d+) (\D+) bag/

my_bag = "shiny gold"

$rules = Hash.new

bag_descriptions.each do |item|
	name = item.match /(.+)(?= bags contain)/
	results = item.scan /(\d+) (\D+) bag/
	$rules[name[1]] = results
end

# I'm not super happy with part 1, as I got help 
# and still don't fully understand it. 🙁

def get_bags_that_contain(bags)
	containers = bags.clone
	bags.each do |target_bag|
		$rules.each do |bag, contents|
			contents.each do |rule|
				if rule[1] == target_bag
					containers.add(bag)
				end
			end
		end
	end
	if bags == containers
		return containers
	else 
		return get_bags_that_contain(containers)
	end
	
end

pt1_answer = get_bags_that_contain(Set[my_bag]).count-1
puts "There are #{pt1_answer} outer bags I can use to contain my #{my_bag} bag! 🛄"


puts "\nPart 2".red.on_black.underline

def bags_within(bag)
	count = 0
	bags_in_bag = $rules[bag]
	bags_in_bag.each do |bag_type|
		qty = bag_type[0].to_i
		name = bag_type[1]
		count += qty
		count += qty * bags_within(name)
	end
	return count
end

pt2_answer = bags_within(my_bag)

puts "There are #{pt2_answer} bags inside my #{my_bag} bag! 💪"
