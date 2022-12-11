#!/usr/bin/env ruby
require 'colorize'

input = File.read("input/day11.txt")

def generateMonkeys(input)
	monkeyStrings = input.split("\n\n")
	monkeys = []
	monkeyStrings.each do |monkeyString|
		items = monkeyString.match(/items: (.+)/)[1].split(", ").map!(&:to_i)
		operationMatch = monkeyString.match(/old (?<operator>\+|\*) (?<value>\d+|old)/)
		testValue = monkeyString.match(/by (\d+)/)[1].to_i
		trueMonkey = monkeyString.match(/true:.* (\d+)/)[1].to_i
		falseMonkey = monkeyString.match(/false:.* (\d+)/)[1].to_i
		monkeys << {
			items: items,
			operation: operationMatch,
			testValue: testValue,
			trueMonkey: trueMonkey,
			falseMonkey: falseMonkey,
			inspectionCount: 0
		}
	end
	return monkeys
end

puts "\nPart 1".red.on_black.underline

monkeys = generateMonkeys(input)

20.times do
	monkeys.each do |monkey|
		monkey[:items].size.times do
			item = monkey[:items].shift
			opVal = monkey[:operation][:value] == "old" ? item : monkey[:operation][:value].to_i
			case monkey[:operation][:operator]
			when "+"
				item = item + opVal
			when "*"
				item = item * opVal
			end
			item = (item / 3).floor
			pass = item % monkey[:testValue] == 0
			luckyMonkey = pass ? monkey[:trueMonkey] : monkey[:falseMonkey]
			monkeys[luckyMonkey][:items].append(item)
			monkey[:inspectionCount] += 1
		end
	end
end

puts values = monkeys.map { |m| m[:inspectionCount] }.sort[-2...].inject(:*)


puts "\nPart 2".red.on_black.underline

monkeys = generateMonkeys(input)

# I would never in a million years have worked this out. Not my work.
magicNumber = monkeys.map { |m| m[:testValue] }.inject(:*)

10000.times do
	monkeys.each do |monkey|
		monkey[:items].size.times do
			item = monkey[:items].shift
			opVal = monkey[:operation][:value] == "old" ? item : monkey[:operation][:value].to_i
			case monkey[:operation][:operator]
			when "+"
				item = item + opVal
			when "*"
				item = item * opVal
			end
			# The reason this works is a bit beyond me. Not my work.
			item = item % magicNumber
			pass = item % monkey[:testValue] == 0
			luckyMonkey = pass ? monkey[:trueMonkey] : monkey[:falseMonkey]
			monkeys[luckyMonkey][:items].append(item)
			monkey[:inspectionCount] += 1
		end
	end
end

puts values = monkeys.map { |m| m[:inspectionCount] }.sort[-2...].inject(:*)