import Foundation

// **************
// Inputs & Setup
// **************

let inputURL: URL = URL(fileURLWithPath: "input/day3.txt")
var input: String = ""
if let loadedFile = try? String(contentsOf: inputURL, encoding: .utf8) {
	input = loadedFile
    print("File loaded successfully\n")		
} else { print("Error loading file\n") }

//input = "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83"
//input = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
//input = "R8,U5,L5,D3\nU7,R6,D4,L4"

// ****************
// Processing Input
// ****************

let firstPathString = String(input.split(separator:"\n")[0])
let secondPathString = String(input.split(separator:"\n")[1])

func createInstructionsFrom(pathString:String) -> [(direction:String, distance:Int)] {
	var returnArray: [(direction:String, distance:Int)] = []
	let instructionStrings = pathString.split(separator:",")
	
	for instructionString in instructionStrings {
		let direction = String(instructionString.prefix(1))
		let distance: Int! = Int(instructionString.suffix(instructionString.count-1))
		let instruction: (direction:String, distance:Int) = (direction, distance)
		returnArray.append(instruction)
	}
	return returnArray
}

let firstPathInstructions = createInstructionsFrom(pathString:firstPathString)
let secondPathInstructions = createInstructionsFrom(pathString:secondPathString)

// ******************
// Mapping each route
// ******************

func visitedCoordinatesForRouteWith(instructions:[(direction:String, distance:Int)]) -> [[Int]] {
	let instructions = instructions
	
	var x: Int = 0
	var y: Int = 0
	
	var returnCoordinates: [[Int]] = []
	
	for instruction in instructions {
		switch instruction.direction {
		case "U" : 
			for _ in 1...instruction.distance {
				y += 1
				let newCoordinate: [Int] = [x,y]
				returnCoordinates.append(newCoordinate)
			}
		case "D" :
			for _ in 1...instruction.distance {
				y -= 1
				let newCoordinate: [Int] = [x,y]
				returnCoordinates.append(newCoordinate)
			}
		case "R" :
			for _ in 1...instruction.distance {
				x += 1
				let newCoordinate: [Int] = [x,y]
				returnCoordinates.append(newCoordinate)
			}
		case "L" :
			for _ in 1...instruction.distance {
				x -= 1
				let newCoordinate: [Int] = [x,y]
				returnCoordinates.append(newCoordinate)
			}
		default : 
			print("Failed Instructions")	
		}
	}
	return returnCoordinates
}

let firstPathCoordinates: [[Int]] = visitedCoordinatesForRouteWith(instructions:firstPathInstructions)
let secondPathCoordinates: [[Int]] = visitedCoordinatesForRouteWith(instructions:secondPathInstructions)

// *********************
// Finding Intersections
// *********************

let intersections = firstPathCoordinates.filter(secondPathCoordinates.contains)
var distances: [Int] = []
for intersection in intersections {
	distances.append(abs(intersection[0])+abs(intersection[1]))
}
let shortestDistance = distances.sorted()[0]
print(String(format:"The closest intersections is at distance: %d",shortestDistance))