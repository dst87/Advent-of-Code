import Foundation

let inputURL: URL = URL(fileURLWithPath: "input/day1.txt")

if let inputString = try? String(contentsOf: inputURL, encoding: .utf8) {
    print("File loaded successfully\n")
	
	// Do stuff here
	
	print("Part 1")
	let arrayOfModuleMasses = inputString.split(separator: "\n")
	var fuelRequired: Float = 0
	
	for moduleMassString in arrayOfModuleMasses {
		let moduleMass: Float! = Float(moduleMassString)
		let fuelForModule = floor(moduleMass/3) - 2
		fuelRequired  += fuelForModule
	}
	
 	print("Total fuel required: " + String(fuelRequired) + "\n")
		
	print("Part 2")
	
	fuelRequired = 0
	
	for moduleMassString in arrayOfModuleMasses {
		
		var moduleMass: Float! = Float(moduleMassString)
		
		while moduleMass > 0 {
			let fuelForModule = floor(moduleMass/3) - 2
			if fuelForModule > 0 {
				fuelRequired  += fuelForModule
			}
			moduleMass = fuelForModule
		}
	}
	
 	print("Total fuel required: " + String(fuelRequired) + "\n")
		
} else { print("Error loading file\n") }
