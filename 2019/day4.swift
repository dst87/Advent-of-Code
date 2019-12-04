import Foundation

// **************
// Inputs & Setup
// **************

var input: String = "146810-612564"

// ****************
// Processing Input
// ****************

let passwordRange = input.split(separator:"-")
let lowerLimit: Int! = Int(passwordRange[0])
let upperLimit: Int! = Int(passwordRange[1])

var matches1: Int = 0
var part1Matches: [String] = []
// ******
// Part 1
// ******

for attempt in lowerLimit...upperLimit {
		
	let attemptAsString: String = String(attempt)
	if (attemptAsString.range(of: #"(\d)\1"#, options: .regularExpression) != nil) {
		let attemptCharArray = Array(attemptAsString)
		let sortedCharArray = attemptCharArray.sorted()
		
		if attemptCharArray == sortedCharArray {
			matches1 += 1
			part1Matches.append(attemptAsString)
		}
	}
}

print(String(format:"There are %d possible passwords for part 1", matches1))

// ******
// Part 2
// ******

var matches2: Int = 0

for attemptString in part1Matches {
	let attempt = Array(attemptString)
	var pass: Bool = false
	for i in 0..<attempt.count-1 {
		switch i {
		case 0 :
			if (attempt[i] == attempt[i+1]) && (attempt[i] != attempt[i+2]) {
				pass = true
			}
		case 4 :
			if (attempt[i] == attempt[i+1]) && (attempt[i] != attempt[i-1]) {
				pass = true
			}
		default :
			if (attempt[i] == attempt[i+1]) && (attempt[i] != attempt[i-1]) && (attempt[i] != attempt[i+2])  {
				pass = true
			}
		}
		if pass {
			matches2 += 1
			break
		}
	}
}

print(String(format:"There are %d possible passwords for part 2", matches2))
