<?php
	// Advent of Code:  Day 8, part 2
	
	/* **** NOTES ON PART 2 *****
	
	Have string length counter = 0
	Have string position counter = 0
	
	Repeat until... string position counter = input string length?
	
	1) Get positiong of first (, and add length of string to counter
	2) Get string relating to first marker.  
	3) If no further markets, do the sum, and add to counter
	4) If market, evaluate as with 
	
	*/
	
	// Capture input from txt file
	$inputTextFile = file_get_contents('inputs/9.txt');
		
	// *** Regex string ***
	// $array[0][1] = Position of opening ( in marker
	// $array[1][0] = String length to repeat
	// $array[2][0] = Number of times to repeat
	// $array[3][1] = Position of closing ) in marker 
	$regexIdMarker = '/\((\d*)x(\d*)(\))/i';
	
	// Define string to be concatenated into for final result
	$finalString = "";
		
	// Loop until input string has been fully processed
	while (strlen($inputTextFile) > 0)
	{	
		if (preg_match($regexIdMarker, $inputTextFile, $results, PREG_OFFSET_CAPTURE))
		{
			$positionOfMarker 		  = $results[0][1]; 
			$numberOfCharsToRepeat    = $results[1][0];
			$numberOfTimesToRepeat    = $results[2][0];
			$positionOfRepeatedString = $results[3][1] + 1;
			
			if ($positionOfMarker > 0)
			{
				// Account for any string before the marker
				$priorStringToAppend = substr($inputTextFile, 0, $positionOfMarker);
				$finalString .= $priorStringToAppend;
			}
			
			$stringToRepeat = substr($inputTextFile, $positionOfRepeatedString, $numberOfCharsToRepeat);
			$stringToAppend = str_repeat($stringToRepeat, $numberOfTimesToRepeat);
			
			$finalString .= $stringToAppend;
			
			// Clean up by removing the 'used' characters from start
			
			$startOfNewString = $numberOfCharsToRepeat + $positionOfRepeatedString;
			$inputTextFile = substr($inputTextFile, $startOfNewString);
		}
		
		else
		{
			// When there are no more markers, concatenate remaining
			// string to the output and clear input to end loop.
			$finalString .= $inputTextFile;
			$inputTextFile = "";
		}
	}
	
	$lengthOfFinalString = strlen($finalString);
	echo "The decompressed length of the file is: ".$lengthOfFinalString."\n";
	
?>