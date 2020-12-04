#!/usr/bin/env ruby

require 'colorize'

passportStrings = File.read("input/day4.txt").split("\n\n")

puts "\nPart 1".red.on_black.underline

passDicts = []
fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]

passportStrings.each do |passportString|
	passport = { }
	fields.each do |fieldID|
		data = passportString.match /#{fieldID}:(\S+)/
		if data != nil
			passport[fieldID] = data[1]
		end
	end
	passDicts.push(passport)
end

validPassportCount = 0
requiredFields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
validPassDicts = []

passDicts.each do |passport|
	if (requiredFields - passport.keys).empty?
		validPassportCount += 1
		validPassDicts.push(passport)
	end
end

puts "Total number of passports: #{passDicts.length}"
puts "Number of valid(ish) passports: #{validPassportCount}"

puts "\nPart 2".red.on_black.underline

def byrValid?(value)
	value = value.to_i
	return (value >= 1920 and value <= 2002)
end

def iyrValid?(value)
	value = value.to_i
	return (value >= 2010 and value <= 2020)
end

def eyrValid?(value)
	value = value.to_i
	return (value >= 2020 and value <= 2030)
end

def hgtValid?(value)
	data = value.match /(\d+)(cm|in)/
	if data == nil
		return false
	end
	height = data[1].to_i
	unit = data[2]
	case unit
	when "cm"
		return (height >= 150 and height <= 193)
	when "in"
		return (height >= 59 and height <= 76)
	else
		return false
	end
end

def hclValid?(value)
	return value.match(/#[0-9a-f]{6}/)
end

def eclValid?(value)
	valid_ecl = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
	return valid_ecl.include? value
end


def pidValid?(value)
	return value.match(/^[0-9]{9}$/)
end

validPassportCount = 0

validPassDicts.each do |passport|
	valid = true
	passport.each do |fieldID, value|
		break if not valid
		case fieldID
		when "byr"
			valid = byrValid?(value)
		when "iyr"
			valid = iyrValid?(value)
		when "eyr"
			valid = eyrValid?(value)
		when "hgt"
			valid = hgtValid?(value)
		when "hcl"
			valid = hclValid?(value)
		when "ecl"
			valid = eclValid?(value)
		when "pid"
			valid = pidValid?(value)
		else
			next
		end
	end
	if valid
		validPassportCount += 1
	end
end

puts "Number of valid passports: #{validPassportCount}"