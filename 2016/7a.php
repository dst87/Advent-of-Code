
<?php
	// Advent of Code:  Day 7, part 1
	
	// Capture input from txt file, and make array
	$inputSource = file_get_contents('inputs/7a.txt');
	$input = explode("\n", $inputSource);
	
	//print_r($input);
	// Counter for number of matching IP addresses
	$counter = 0;
	
	
	// Regex to match the squence
	$regex = '/([a-z])(?!\1)([a-z])\2\1/i';
	
	//print_r(preg_match($regex, "mxtkrysovotkuyekba"));
	
	foreach ($input as $thisLine) {
		$skipThis = false;
		$splitString = preg_split("/[\[\]]/", $thisLine);
		//print_r($splitString);
		for ($i = 1; $i < count($splitString); $i+=2) {
			if (preg_match($regex, $splitString[$i])){
				$skipThis = true;
			}
		}
		if ($skipThis) continue;
		for ($i = 0; $i < count($splitString); $i+=2) {
			if (preg_match($regex, $splitString[$i])){
				$counter++;
				break;
			}
		}
	}
	
	echo $counter;
?>