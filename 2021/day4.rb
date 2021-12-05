#!/usr/bin/env ruby

require 'colorize'
require 'set'

input = File.read("input/day4.txt").split("\n\n")
calls = input.shift.split(",").map!(&:to_i)

boardStrings = input.map! { |board| board.split("\n") }

boards = [] # An array of all boards, each a 2D array representing the game board
boardsLines = [] # Array of all boards, each containing sets of game lines for that board

boardStrings.each do |boardLines|
	board = []
	lines = []
	boardLines.each do |line|
		matches = line.scan(/\d+/).map!(&:to_i)
		board << matches
		lines << matches
	end
	lines += lines.transpose
	lines.map!(&:to_set)
		
	boards << board
	boardsLines << lines
end

puts "\nPart 1".red.on_black.underline

winners = []
callAtWin = []

for c in 4..calls.length-1
	called = calls[0..c].to_set
	done = false
	boardsLines.each_with_index do |board, i|
		next if winners.include?(i)
		board.each do |line|
			if line.subset?(called)
				winners << i
				callAtWin << calls[c]
				done = true
				break
			end
		end
	end
end

firstWinner = winners.first
boardForFirstWinner = boards[firstWinner].flatten.to_set
callForFirstWinner = callAtWin.first

callsAtFirstWin = calls[0..calls.find_index(callForFirstWinner)].to_set
remainingSquaresForFirstWinner = boardForFirstWinner.subtract(callsAtFirstWin).to_a
score = remainingSquaresForFirstWinner.sum * callForFirstWinner

puts "Board #{firstWinner} won with a score of #{score} after the number #{callForFirstWinner} was called."


puts "\nPart 2".red.on_black.underline

finalWinner = winners.last
boardForLastWinner = boards[finalWinner].flatten.to_set
callForLastWinner = callAtWin.last

callsAtLastWin = calls[0..calls.find_index(callForLastWinner)].to_set
remainingSquaresForLastWinner = boardForLastWinner.subtract(callsAtLastWin).to_a
score = remainingSquaresForLastWinner.sum * callForLastWinner

puts "Final board to finish is #{finalWinner} with a score of #{score} after the number #{callForLastWinner} was called."