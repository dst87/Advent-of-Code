import Foundation

// **************
// Inputs & Setup
// **************

let inputURL: URL = URL(fileURLWithPath: "input/day10.txt")
var input: String = ""
if let loadedFile = try? String(contentsOf: inputURL, encoding: .utf8) {
	input = loadedFile
    print("File loaded successfully\n")		
} else { print("Error loading file\n") }


// ****************
// Processing Input
// ****************

var space: [[String]] = []

let inputRows = input.split(separator: "\n")

for row in inputRows {
	var array: [String] = []
	var mutableRow = row
	for _ in 0..<row.count {
		array.append(String(mutableRow.prefix(1)))
		mutableRow.removeFirst(1)
	}
	space.append(array)
}

var asteroidLocations =  Set<[String: Int]>()

var y: Int = 0

while y < space.count {
	var x: Int = 0
	while x < space[y].count {
		if space[y][x] == "#" {
			asteroidLocations.insert(["x": x, "y": y])
		}
		x += 1
	}
	y += 1
}
//print(asteroidLocations)
// ****************
// Part 1
// ****************

// For each point, loop through each other point
// - Calculate the line on which both points rest
// - If no point on same line between two points, +1 to count

var counts: [Int] = []

for station in asteroidLocations {
	let stationx: Int! = station["x"]
	let stationy: Int! = station["y"]
	var asteroidCount: Int = 0
	
	
	for asteroid in asteroidLocations {
		if station == asteroid { continue }
		let asteroidx: Int! = asteroid["x"]
		let asteroidy: Int! = asteroid["y"]
		var isReachable: Int = 1
		
		if asteroidx == stationx {
			// Asteroid and Station are vertically aligned
			for blocker in asteroidLocations {
				if blocker == asteroid || blocker == station { continue }
				let blockerx: Int! = blocker["x"]
				let blockery: Int! = blocker["y"]
				if blockerx == asteroidx {
					 if (stationy < blockery && blockery < asteroidy) ||
					    (stationy > blockery && blockery > asteroidy) {
					    	isReachable = 0
							break
					    }
				}
			}
		}
		else if asteroidy == stationy {
			// Asteroid and Station are horizontally aligned
			for blocker in asteroidLocations {
				if blocker == asteroid || blocker == station { continue }
				let blockerx: Int! = blocker["x"]
				let blockery: Int! = blocker["y"]
				if blockery == asteroidy {
					 if (stationx < blockerx && blockerx < asteroidx) ||
					    (stationx > blockerx && blockerx > asteroidx) {
					    	isReachable = 0
							break
					    }
				}
			}
		}
		else {
			let slope = (Float(asteroidy-stationy)/Float(asteroidx-stationx))
			for blocker in asteroidLocations {
				if blocker == asteroid || blocker == station { continue }
				let blockerx: Int! = blocker["x"]
				let blockery: Int! = blocker["y"]
				if (stationx < blockerx && blockerx < asteroidx && stationy < blockery && blockery < asteroidy) ||
				   (stationx < blockerx && blockerx < asteroidx && stationy > blockery && blockery > asteroidy) ||
				   (stationx > blockerx && blockerx > asteroidx && stationy < blockery && blockery < asteroidy) ||
				   (stationx > blockerx && blockerx > asteroidx && stationy > blockery && blockery > asteroidy) {
					// Potential Blocker (In range)
					let lhs = Float(blockery - stationy)
					let rhs = Float(slope * Float(blockerx - stationx))
					if lhs == rhs {
						// Asteroid is not reachable from station
						isReachable = 0
						break
					}
				}
			}
		}
		asteroidCount += isReachable
	}
	counts.append(asteroidCount)
}
//print(counts)
let sortedCounts = counts.sorted(by: >)
print(String(format:"The maximum number of asteroid is: %d"),sortedCounts[0])
