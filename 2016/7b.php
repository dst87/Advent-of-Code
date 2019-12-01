<?php
	// Advent of Code:  Day 7, part 2
	// NOT 260 (Too high)
	
	// Capture input from txt file, and make array
	$inputSource = file_get_contents('inputs/7a.txt');
	//$inputSource = 'qmmiampdlhjhsscnqml[ymselibefbqnqakirdw]uzxhisxyqljsdvhfe[jhjnivjqnqgqdfyeqcea]nxbqpgyhtqnqnzcwoptq[frlnwadwwyfnndeqv]qcbefaxmhgspalprcdo';
	
	$input = explode("\n", $inputSource);
	
	//print_r($input);
	// Counter for number of matching IP addresses
	$counter = 0;
	
	
	// Regex to match the squence
	$regex = '/([a-z])(?!\1)([a-z])\1/i';
	
	//print_r(preg_match($regex, "mxtkrysovotkuyekba"));
	
	// Function to invert a three letter string in the form BAB into ABA
	
	function invertString($originalString) {
		$newString = substr($originalString, 1, 2);
		$newString .= substr($originalString, 1, 1);
		return $newString;
	}
	
	
	
	foreach ($input as $thisLine) {
		$skipThis = false;
		$splitString = preg_split("/[\[\]]/", $thisLine);
		
		$matchedStringsArray = [];

		for ($i = 0; $i < count($splitString); $i+=2) {
			$positionInString = 0;
			while( preg_match($regex, $splitString[$i], $results, PREG_OFFSET_CAPTURE, $positionInString) ) {
				
				// Get the matched string, invert it, and add to array
				$matchedString = $results[0][0];
				$invertedString = invertString($matchedString);
				$matchedStringsArray[] = $invertedString;
				
				// Reset the position to search from to the index of the result + 1
				// to account for overlapping results
				$positionInString = $results[0][1] + 1;
			}
		}
		
		// Skip part 2 if there are no results to test against
		if (count($matchedStringsArray) == 0) continue;
		
		
		for ($i = 1; $i < count($splitString); $i+=2) {
			
			$continue = false;
			
			foreach ($matchedStringsArray as $matchedString){
				$regexPt2 = '/'.$matchedString.'/i';
				if (preg_match($regexPt2, $splitString[$i])){
					$continue = true;
					$counter++;
					break;
				}
			}
			
			if($continue) break;
			
			
		}
	}
	
	echo $counter."\n";
?>