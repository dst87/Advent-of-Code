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

var count: Int = 0

for (_, object) in tree {
	count += object.orbitCount()
}
print(count)