import Foundation

// **************
// Inputs & Setup
// **************

let userInput: Int = 1
let inputURL: URL = URL(fileURLWithPath: "input/day5.txt")
var input: String = ""
if let loadedFile = try? String(contentsOf: inputURL, encoding: .utf8) {
	input = loadedFile
    print("File loaded successfully\n")		
} else { print("Error loading file\n") }

// ******************
// Required Functions
// ******************

// Parse Input
// Return [Int] in format [Opcode, mode1, mode2, mode3]

func parseInstruction(_ instruction: String) -> [Int] {
	let instructionLength: Int = instruction.count
	switch instructionLength {
	case 1 :
		let opcode: Int! = Int(instruction)
		return [opcode, 0, 0, 0]
	case 2 :
		let opcode: Int! = Int(instruction) // Should only be 99
		return [opcode, 0, 0, 0]
	case 3 :
		let opcode: Int! = Int(instruction.suffix(2))
		let mode1: Int! = Int(instruction.prefix(1))
		return [opcode, mode1, 0, 0]
	case 4 :
		let array = Array(instruction)
		let opcode: Int! = Int(instruction.suffix(2))
		let mode2: Int! = Int(instruction.prefix(1))
		let mode1Char: Character = array[1]
		var mode1 = 0
		if let mode1Char = Int(String(mode1Char)){
			mode1 = mode1Char
		}
		return [opcode, mode1, mode2, 0]
	default : 
		print("Something went wrong.")
		return [555]
	}
}

// ****************
// Processing Input
// ****************

let programStrings: [String.SubSequence] = input.split(separator:",")
var intcode: [Int] = [] 
for string in programStrings {
	let intFromString: Int! = Int(string)
	intcode.append(intFromString)
}

var i: Int = 0
loop: while i < intcode.count {
	
	let instruction: [Int] = parseInstruction(String(intcode[i]))
	
	let pos1IsValue: Bool = instruction[1] == 0 ? false : true
	let pos2IsValue: Bool = instruction[2] == 0 ? false : true
	let pos3IsValue: Bool = instruction[3] == 0 ? false : true
	
	switch instruction[0] {
	case 1 :
		// Addition
		let addend1 = pos1IsValue ? intcode[i+1] : intcode[intcode[i+1]]
		let addend2 = pos2IsValue ? intcode[i+2] : intcode[intcode[i+2]]
		let result = addend1 + addend2
		intcode[intcode[i+3]] = result
		i += 4
	case 2 :
		// Multiplication
		let factor1 = pos1IsValue ? intcode[i+1] : intcode[intcode[i+1]]
		let factor2 = pos2IsValue ? intcode[i+2] : intcode[intcode[i+2]]
		let result = factor1 * factor2
		intcode[intcode[i+3]] = result
		i += 4
	case 3 :
		intcode[intcode[i+1]] = userInput
		i += 2
	case 4 :
		let output = pos1IsValue ? intcode[i+1] : intcode[intcode[i+1]]
		print(String(format:"The diagnostic code is %d", output))
		i += 2
	case 99 :
		print("End of program (99)")
		break loop
	default :
		print("Something went wrong")
		break loop
 	}
}





