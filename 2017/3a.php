<?php
  // Advent of Code 2017: Day 3


  // Capture input from text file
  $input = "312051";
  
  // Calculate grid size
  $gridSize = ceil(sqrt($input));
    
  // Bottom-right square
  $maxSquare = $gridSize*$gridSize;
  
  
  $difference = $maxSquare - $input;
  
  // First calculate stepts to centreline
  $maxStepsToAxes = ($gridSize-1)/2;
  $stepsToPrevCorner = $difference % ($gridSize-1);
  if ($stepsToPrevCorner < $maxStepsToAxes) {
    $steps = $maxStepsToAxes - $stepsToPrevCorner;
  }
  else if ($stepsToPrevCorner > $maxStepsToAxes) {
    $steps = $stepsToPrevCorner - $maxStepsToAxes;
  }
  else {
    $steps = 0;
  }
  
  // Then add steps to centre of square
  
  $steps += $maxStepsToAxes;
  
  echo("Total number of steps to reach origin: ".$steps."\n");
  
  
  
  

  /* RANDOM NOTES / WORKING
  1 x 1 = 1
  3 x 3 = 8
  5 x 5 = 16
  6 x 6 = 20
  7 x 7 = 24
  8 x 8 = 28
  9 x 9 = 32

  Bottom right number = width of square ^ 2

  100

  2x + 2(x-2)

  312051 is on a grid 559 x 559

  First number on a new square is far right and one from the bottom.  Grid will go w-1 up, then w-1 along, then w-1 down, then w-1

  311,364 = final number
  */
  
?>