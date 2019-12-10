import Foundation

// **************
// Inputs & Setup
// **************

let inputURL: URL = URL(fileURLWithPath: "input/day8.txt")
var input: String = ""
if let loadedFile = try? String(contentsOf: inputURL, encoding: .utf8) {
	input = loadedFile
    print("File loaded successfully\n")		
} else { print("Error loading file\n") }

let height: Int = 6
let width: Int = 25

let pixelsPerLayer: Int = width * height

let numberOfLayers: Int = input.count / pixelsPerLayer

print(numberOfLayers)

// ****************
// Processing Input
// ****************

var layers: [String] = []

for _ in 0...numberOfLayers-1 {
	layers.append(String(input.prefix(pixelsPerLayer)))
	input.removeFirst(pixelsPerLayer)
}

// **********************
// Get the Answer (Pt. 1)
// **********************

print("Part 1")

// Get layer with fewest 0 digits

var zeroCounts: [Int] = []

for layer in layers {
	let stringWithZeros = layer.filter { $0 == "0" }
	let count = stringWithZeros.count
	zeroCounts.append(count)
}

let sortedCounts = zeroCounts.sorted()
let winningLayerIndex: Int! = zeroCounts.firstIndex(of:sortedCounts[0])

print(String(format:"The winning layer is %d at index %d",winningLayerIndex+1, winningLayerIndex))

// On that layer, number of 1 digits * number of 2 digits

let winningLayer = layers[winningLayerIndex]

let oneCount: Int = winningLayer.filter { $0 == "1" }.count
let twoCount: Int = winningLayer.filter { $0 == "2" }.count

let result: Int = oneCount * twoCount

print(String(format:"Checksum for image verification is %d.\n", result))

// **********************
// Get the Answer (Pt. 2)
// **********************

print("Part 2")

var imageString = ""

for i in 0...pixelsPerLayer-1 {
	for layer in layers {
		let layerString: String = String(layer)
		let charIndex = layerString.index(layerString.startIndex, offsetBy:i)
		let char = layerString[charIndex]
		if char == "0" || char == "1" {
			let pixel = char == "0" ? " " : "■"
			imageString += String(pixel)
			break
		}
	}
}

for _ in 0..<height {
	print(imageString.prefix(width))
	imageString.removeFirst(width)
}