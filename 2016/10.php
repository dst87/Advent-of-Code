<?php
	// Advent of Code:  Day 10, parts 1 & 2
	
	// Capture input from txt file, and make array
	$inputTextFile = file_get_contents('inputs/10.txt');
	$explodedInput = explode("\n", $inputTextFile);
	
	
	// *****************	
	// * Regex strings *
	// *****************
	
	// Comparison parser [1] = bot number, [2] and [4] are low/high
	// destination categories (bot/output) and [3] and [5] are low/high
	// destination identifiers
	$regexComparison = '/bot (\d*) gives low to (bot|output) (\d*) and high to (bot|output) (\d*)/i';
	// Input parser [1] = value token, [2] is the bot it goes to
	$regexInputs = '/value (\d*) goes to bot (\d*)/i';
	
	
	// ********************	
	// * Define Variables *
	// ********************
	
	// Array to store the contents of each robot
	$robotsArray = [];
	
	// Array to store the instructions of what each robot should do
	$instructionsArray = [];
	
	// Array to store the outputs
	$outputs = [];
	
	// String with the robot number to report
	$luckyRobot = "";
	
	
	// ************************
	// * Function definitions *
	// ************************
	function giveTokenToRobot($token, $robot)
	{
		global $robotsArray;
		
		if(!$robotsArray[$robot])
		{
			$robotsArray[$robot] = [$token];
			return;
		}
		
		elseif(count($robotsArray[$robot]) == 1)
		{
			$robotsArray[$robot][] = $token;
			sort($robotsArray[$robot]);
			getToWork($robot);
			return;
		}
		return;	
	}
	
	function getToWork($robot)
	{
		global $robotsArray, $outputs, $instructionsArray, $luckyRobot;
		$loNumber = $robotsArray[$robot][0];
		$hiNumber = $robotsArray[$robot][1];
		
		// Check to see if this is the winning robot!
		if($loNumber == 17 && $hiNumber == 61)
		{
			echo "Foud it!\n";
			$luckyRobot = $robot;
		}
		
		// Process the low number
		if($instructionsArray[$robot]["lo"]["cat"] == "bot")
		{
			giveTokenToRobot($loNumber, $instructionsArray[$robot]["lo"]["num"]);
		}
		elseif($instructionsArray[$robot]["lo"]["cat"] == "output")
		{
			$outputs[$instructionsArray[$robot]["lo"]["num"]] = $loNumber;
		}
		else
		{
			echo "Something went wrong with robot ".$robot." with lowNum: ".$loNumber.".\n";
		}
		
		// Process the high number
		if($instructionsArray[$robot]["hi"]["cat"] == "bot")
		{
			giveTokenToRobot($hiNumber, $instructionsArray[$robot]["hi"]["num"]);
		}
		elseif($instructionsArray[$robot]["hi"]["cat"] == "output")
		{
			$outputs[$instructionsArray[$robot]["hi"]["num"]] = $hiNumber;
		}
		else
		{
			echo "Something went wrong with robot ".$robot." with hiNum: ".$hiNumber.".\n";
		}
	}
		
	
	// *****************
	// * Main Run-time *
	// *****************
		
	// Sort the exploded input so all of the instructions can
	// be catalogued first
	
	sort($explodedInput, SORT_NATURAL);
	
	foreach($explodedInput as $line)
	{
		if(preg_match($regexComparison, $line, $results))
		{
			// Process the instructions into the catalogue of instructions
			$robot = $results[1];
			$loCat = $results[2];
			$loNum = $results[3];
			$hiCat = $results[4];
			$hiNum = $results[5];
			
			$instructionsArray[$robot]["lo"] = ["cat" => $loCat,"num" => $loNum];
			$instructionsArray[$robot]["hi"] = ["cat" => $hiCat,"num" => $hiNum];
		}
		
		elseif(preg_match($regexInputs, $line, $results))
		{
			// Give the starting tokens to the robots
			$robot = $results[2];
			$value = $results[1];
			
			giveTokenToRobot($value, $robot);
		}
	}
	
	print_r($output);
	$winingValue = $outputs[0] * $outputs[1] * $outputs[2];
	echo $winingValue."\n";
	
	echo "The lucky robot responsible for comparing 61 and 17 microchips is ".$luckyRobot."!\n";
	
?>
