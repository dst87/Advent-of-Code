<?php
	// Advent of Code:  Day 8, parts 1 & 2

	// Capture input from txt file, and make array
	$inputTextFile = file_get_contents('inputs/8.txt');
	$instructionsArray = explode("\n", $inputTextFile);

	// Regex strings
	// Rect will have width in results[2] and height in results[4].
	$regexRect = '/(rect\s)(\d*)(x)(\d*)/i';
	// Rotate will have axis (x|y) in results[3], ident in [5], and displacement in [7]
	$regexRotate = '/(rotate\s)(row\s|column\s)(x|y)(=)(\d*)(\sby\s)(\d*)/i';

	// Create array to represent a 50x6 display.  0 = pixel off; 1 = pixel on
	// These will be 0-indexed, so the bottom-right pixel = $littleScreen[5][49]
	$widthInPixels = 50;
	$heightInPixels = 6;

	$littleScreen = [];

	for ($currentRow = 0; $currentRow < $heightInPixels; $currentRow++)
	{
		for ($currentColumn = 0; $currentColumn < $widthInPixels; $currentColumn++)
		{
			// Set each pixel on the display to the off position to start with.
			$littleScreen[$currentRow][$currentColumn] = 0;
		}
	}

	// Loop though each line & identify the instruction to be parsed
	printScreen();
	foreach ($instructionsArray as $thisInstruction)
	{
		if (preg_match($regexRect, $thisInstruction, $results))
		{
			$rectWidth = $results[2];
			$rectHeight = $results[4];
			drawRect($rectWidth, $rectHeight);
		}

		elseif (preg_match($regexRotate, $thisInstruction, $results))
		{
			$axis = $results[3];
			$ident = $results[5];
			$displacement = $results[7];
			rotate($axis, $ident, $displacement);
		}
		printScreen();
		usleep(25000);
	}





	// Functions to be called to do transformations on array

	function drawRect($width, $height)
	{
		/*
		Function to be called to create a block x*y in top right hand corner
		These pixels should be on = 1
		*/

		global $littleScreen;

		for ($y = $height; $y > 0; $y--)
		{
			for ($x = $width; $x > 0; $x--)
			{
				$littleScreen[$y-1][$x-1] = 1;
			}
		}
		return;
	}


	function rotate($axis, $ident, $displacement)
	{
		/*
		$axis should be a string 'x' or 'y'
		$ident (int) should be the array index to be transformed
		$displacement (int) should be the number of spaces to transform
		*/

		global $littleScreen, $widthInPixels, $heightInPixels;

		if ($axis == "y")
		{
			// Get which index should now be at position 0
			$newZero = $widthInPixels - ($displacement % $widthInPixels);


			// Move the first item to the end of array this number of times
			while ( $newZero > 0 )
			{
				$tempItem = array_shift($littleScreen[$ident]);
				$littleScreen[$ident][] = $tempItem;
				$newZero--;
			}

		}

		else if ($axis == "x")
		{
			//Create an array to work on, and fill it
			$newArray = [];
			foreach ($littleScreen as $rowOfPixels)
			{
				$newArray[] = $rowOfPixels[$ident];
			}

			// Get which index should now be at position 0
			$newZero = $heightInPixels - ($displacement % $heightInPixels);


			// Move the first item to the end of array this number of times
			while ( $newZero > 0 )
			{
				$tempItem = array_shift($newArray);
				$newArray[] = $tempItem;
				$newZero--;
			}

			// Replace each item in the original array with the corresponding item in the new array

			for ($i = 0; $i < count($newArray); $i++)
			{
				$littleScreen[$i][$ident] = $newArray[$i];
			}

		}

		else
		{
			// Report an error with the function; echo the parameters passed.
			echo "Something went wrong with rotate function.  Axis: ".$axis." Ident: ".$ident." Displacement: ".$displacement."\n";

		}

		return;
	}

	// Function to draw out the array

	function printScreen()
	{
		global $littleScreen;

		foreach($littleScreen as $thisRow)
		{
			foreach($thisRow as $thisPixel)
			{
				if($thisPixel == 0) echo " ";
				if($thisPixel == 1) echo "#";
			}
			echo "\n";
		}
		echo "******END*******\n\n";

	}



	// Cycle through the array and add up all of the 'on' pixels = 1

	$onPixelCounter = 0;

	foreach($littleScreen as $thisRow)
	{
		foreach($thisRow as $thisPixel)
		{
			$onPixelCounter += intval($thisPixel);
		}
	}

	echo "The number of pixels in the on state is ".$onPixelCounter."!\n";



?>
