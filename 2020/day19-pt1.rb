#!/usr/bin/env ruby

require 'colorize'
require 'set'

input = File.read("Input/day19.txt").split("\n\n")

puts "\nPart 1".red.on_black.underline

# Parse input into rules

$rules = Hash.new
rules_strings = input[0].split("\n")
rules_strings.each do |rule_string|
	rules_arr = rule_string.match /(\d+): (.+)/
	$rules[rules_arr[1]] = rules_arr[2].split(" ")
end

# Function to recursively provide a Regex string

def regex_for(rule_key)
	return "|" if rule_key == "|"
	rule = $rules[rule_key]
	if rule.count == 1
		return rule[0][1] if rule[0][0] == "\""
		return regex_for(rule[0])
	else
		string = ""
		string << "(" if rule.include?("|")
		rule.each do |r|
			string << regex_for(r)
		end
		string << ")" if rule.include?("|")
		return string
	end
end

regex = "^"
regex << regex_for("0")
regex << "$"

valid = 0

input[1].split("\n").each do |thing|
	valid += 1 if thing.match?(Regexp.new(regex))
end
puts "There are #{valid} solutions."