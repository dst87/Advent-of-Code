import Foundation

// **************
// Inputs & Setup
// **************

let inputURL: URL = URL(fileURLWithPath: "input/day6.txt")
var input: String = ""
if let loadedFile = try? String(contentsOf: inputURL, encoding: .utf8) {
	input = loadedFile
    print("File loaded successfully\n")		
} else { print("Error loading file\n") }

// ****************
// Processing Input
// ****************

let relationshipStrings = input.split(separator:"\n")
var relationships: [[String]] = []
for string in relationshipStrings {
	let subStrs = string.split(separator:")")
	let str1 : String = String(subStrs[0])
	let str2 : String = String(subStrs[1])
	relationships.append([str1,str2])
}

// *****************
// Class Definitions
// *****************

class Object {
	var name: String
	var orbiting: [Object] = []
	weak var orbits: Object?
	
	init(name: String) {
		self.name = name
	}
	
	func add(object: Object) {
		orbiting.append(object)
		object.orbits = self
	}
	
	func orbitCount(_ now: Int = 0) -> Int {
		if self.orbits == nil {
			return now
		}
		else {
			let total = self.orbits!.orbitCount(now)
			return total + 1
		}
	}
	
	func stepsBackTo(_ target: String, currentCount: Int = 0) -> Int? {
		if target == "COM" {
			return self.orbitCount()
		}
		else if self.name == target {
			return currentCount
		}
		else {
			let total = self.orbits!.stepsBackTo(target, currentCount:currentCount)
			return total! + 1
		}
	}
	
	func totalRoute(backTo target: String = "COM", currentRoute: [String] = []) -> [String] {
		if self.name == target {
			var route = currentRoute
			route.append(self.name)
			return route
		}
		else {
			var newRoute = self.orbits!.totalRoute(backTo:target, currentRoute:currentRoute)
			newRoute.append(self.name)
			return newRoute
		}
	}
}

extension Object: CustomStringConvertible {
	var description: String {
		var text = "\(name)"
		if !orbiting.isEmpty {
			text += " {" + orbiting.map { $0.name }.joined(separator:", ") + "} "
		}
		return text
	}
}

// ********************
// Function Definitions
// ********************

func distance(from: String, to: String) -> Int {
	let route1Full = tree[from]!.totalRoute()
	let route2Full = tree[to]!.totalRoute()
	
	let route1Set = Set(route1Full)
	let route2Set = Set(route2Full)
	
	let totalSet = route1Set.symmetricDifference(route2Set)
	
	return totalSet.count - 2
}


// ***********
// Create Tree
// ***********

var tree = [String: Object]()

for relationship in relationships {
	let parentID: String = relationship[0]
	let childID: String = relationship[1]
	if tree[parentID] != nil {
		if tree[childID] != nil {
			tree[parentID]!.add(object:tree[childID]!)
		}
		else {
			let newChild: Object = Object(name:childID)
			tree[childID] = newChild
			tree[parentID]!.add(object:tree[childID]!)
		}
	}
	else {
		if tree[childID] == nil {
			let newChild: Object = Object(name:childID)
			tree[childID] = newChild
		}
		let newParent: Object = Object(name:parentID)
		newParent.add(object:tree[childID]!)
		tree[parentID] = newParent
	}
}

// **********************
// Get the Answer (Pt. 1)
// **********************

print("Part 1")
var count: Int = 0

for (_, object) in tree {
	count += object.orbitCount()
}
print(String(format:"Total number of direct and indirect orbits: %d\n",count))

// **********************
// Get the Answer (Pt. 2)
// **********************

// Test: COM > ML7 > V6Q > TPY > 2YC > {SX6, DLT}

// for (_, object) in tree {
// 	print(object)
// }


print("Part 2")
let object1 = "YOU"
let object2 = "SAN"

let distanceInt: Int = distance(from:object1, to:object2)
print(String(format:"Total number of steps between YOU and SAN: %d",distanceInt))