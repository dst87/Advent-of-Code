<?php
  // Advent of Code 2017: Day 1

  // Capture input from text file
  $inputTextFile = file_get_contents('inputs/1.txt');
  //$inputTextFile = "12131415";

  // Set sum counter to zero
  $total = 0;

  $inputArray = str_split($inputTextFile);

  //print_r($inputArray);

  for($i = 0; $i < strlen($inputTextFile); $i++){
    $displacementRequired = 1;
      if($inputArray[$i] == comparisonDigit($i, $displacementRequired)){
          $total += intval($inputArray[$i]);
       }
  }
  // Function to take an array index and return the comparison digit at a set displacement
  function comparisonDigit($origin, $displacement){
    global $inputTextFile;
    global $inputArray;
    // Removing one from count to use as the modulo value for a zero-indexed array
    $strlenForModulo = strlen($inputTextFile);
    $target = $origin + $displacement;
    $indexTarget = $target % $strlenForModulo;
    return $inputArray[$indexTarget];
  }

  echo("The CAPTCHA is ".($total).".\n");
?>