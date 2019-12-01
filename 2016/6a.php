
<?php
	// Advent of Code:  Day 6, part 1

	$inputSource = file_get_contents('inputs/6a.txt');
	echo $input;
	
	$input = explode("\n", $inputSource);
	
	$numberOfLetters = strlen($input[0]);
	$numberOfLines = count($input);
	
	$thePassword = "";
	// First loop for each character in the password
	
	for ($passPos = 0; $passPos < $numberOfLetters; $passPos++) {
		
		$possibleLetters = array();
		
		for ($lineNumber = 0; $lineNumber < $numberOfLines; $lineNumber++) {
			
			//Loop through each letter, adding to a count
			$thisLetter = substr($input[$lineNumber], $passPos, 1);

			if (array_key_exists($thisLetter, $possibleLetters)) {
				$possibleLetters[$thisLetter]++;
			}
			else{
				$possibleLetters[$thisLetter] = 1;
			}
			
		}

		// Sort array by descending value and get the first item in array
		
		arsort($possibleLetters);
		
		$thePassword .= array_keys($possibleLetters)[0];
					
	}

	echo "The password you are looking for is ".$thePassword.".\n";
	
?>