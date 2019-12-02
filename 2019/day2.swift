import Foundation

// Inputs
let inputURL: URL = URL(fileURLWithPath: "input/day2.txt")
let target: Int = 19690720


func getOutputFrom(array:[Int]) -> Int {
	var Intcode = array
	var i = 0
	while i < Intcode.count {
		switch Intcode[i] {
		case 1 :
			// Addition
			let addend1 = Intcode[Intcode[i+1]]
			let addend2 = Intcode[Intcode[i+2]]
			let result = addend1 + addend2
			Intcode[Intcode[i+3]] = result
		case 2 :
			// Multiplication
			let factor1 = Intcode[Intcode[i+1]]
			let factor2 = Intcode[Intcode[i+2]]
			let result = factor1 * factor2
			Intcode[Intcode[i+3]] = result
		case 99 :
			i = Intcode.count
		default :
			print("Error: Unknown opcode.")
			i = Intcode.count
		}
		i += 4
	}
	return Intcode[0]
}

func part1(_ array:[Int]) -> String {
	
	var Intcode: [Int] = array
	Intcode[1] = 12
	Intcode[2] = 2
	
	// Given Examples
	//Intcode = [1,0,0,0,99]
	//Intcode = [2,3,0,3,99]
	//Intcode = [2,4,4,5,99,0]
	//Intcode = [1,1,1,4,99,5,6,0,99]
	let answer = getOutputFrom(array:Intcode)
	return String(format: "The result at position 0 is %d", answer)
}

func part2(_ array: [Int], target: Int) -> String {
	
	var Intcode: [Int] = []
	
	var noun: Int = 0
	var verb: Int = 0
	
	for n in 0...99 {
		for v in 0...99 {
			Intcode = array
			Intcode[1] = n
			Intcode[2] = v
			
			let result: Int! = getOutputFrom(array:Intcode)
			if result == target {
				noun = n
				verb = v
			}
		}
	}
	
	let answer = 100 * noun + verb
	return String(format: "Target: %d \n Noun: %d \n Verb: %d \n Answer: %d", target, noun, verb, answer)
}


if let inputString = try? String(contentsOf: inputURL, encoding: .utf8) {
    print("File loaded successfully\n")
		
	let arrayOfStrings = inputString.split(separator: ",")
	var Intcode: [Int] = []
	for string in arrayOfStrings {
		let intFromString: Int! = Int(string)
		Intcode.append(intFromString)
	}
			
	print("Part 1")
	print(part1(Intcode)+"\n")
	
	print("Part 2")
	print(part2(Intcode, target: target)+"\n")

		
} else { print("Error loading file\n") }

