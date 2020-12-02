#!/usr/bin/env ruby

require 'colorize'

arrayOfExpenseStrings = File.read("input/day1.txt").split

target = 2020

puts "\nPart 1".red.on_black.underline

highExpenses = []
lowExpenses = []

arrayOfExpenseStrings.each do |expenseString|
	expense = expenseString.to_i
	if expense > target/2
		highExpenses.push expense
	else
		lowExpenses.push expense
	end 
end

highExpenses.each do |highExpense|
	lowExpenses.each do |lowExpense|
		if highExpense + lowExpense == target
			product = highExpense * lowExpense
			puts "The required entries are #{highExpense} and #{lowExpense}."
			puts "The required answer is #{product}."
		end	
	end
end

puts "\nPart 2".red.on_black.underline

allExpenses = []

arrayOfExpenseStrings.each do |expenseString|
	expense = expenseString.to_i
	allExpenses.push expense
end

allExpenses.sort!

allExpenses.each do |exp1|
	allExpenses.each do |exp2|
		next if exp2 == exp1
		allExpenses.each do |exp3|
			next if exp3 == exp2
			if exp1 + exp2 + exp3 == target
				product = exp1 * exp2 * exp3
				puts "The required entries are #{exp1}, #{exp2}, and #{exp3}."
				puts "The required answer is #{product}."
			end
		end
	end
end
	