#!/usr/bin/env ruby

require 'colorize'

games = File.read("input/day2.txt").split("\n")

puts "\nPart 1".red.on_black.underline

maxRed = 12
maxGreen = 13
maxBlue = 14

possibleGames = []

games.each do |game|
	possible = true
	blues = game.scan(/(\d+) blue/).flatten(1).map(&:to_i)
	reds = game.scan(/(\d+) red/).flatten(1).map(&:to_i)
	greens = game.scan(/(\d+) green/).flatten(1).map(&:to_i)
	gameID = game.scan(/Game (\d+)/).join("").to_i
	blues.each do |blue|
		if blue > maxBlue
			possible = false
		end
		break if !possible
	end
	next if !possible
	
	reds.each do |red|
		if red > maxRed
			possible = false
		end
		break if !possible
	end	
	next if !possible

	greens.each do |green|
		if green > maxGreen
			possible = false
		end
		break if !possible
	end	
	
	if possible
		possibleGames.push(gameID)
	end
end

sumOfIDs = possibleGames.inject(0, :+)

puts "#{sumOfIDs} is the sum of IDs of possible games."

puts "\nPart 2".red.on_black.underline

gamePowers = []

games.each do |game|
	blues = game.scan(/(\d+) blue/).flatten(1).map(&:to_i)
	reds = game.scan(/(\d+) red/).flatten(1).map(&:to_i)
	greens = game.scan(/(\d+) green/).flatten(1).map(&:to_i)
	
	gamePowers.push(blues.max * reds.max * greens.max)
end

sumOfPowers = gamePowers.inject(0, :+)

puts "#{sumOfPowers} is the sum of powers of each set."
