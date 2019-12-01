<?php
  // Advent of Code 2017: Day 2


  // Capture input from text file
  $inputTextFile = file_get_contents('inputs/2.txt');
  
  // Zero counter for adding checksum values
  $total = 0;
  
  // Split text file by new line (or 'row' in the 'spreadsheet')
  $rows = explode("\n", $inputTextFile);
    
  // Split each 'row' into 'cells', and add the difference between
  // min and max values of each row to the $total variable.
  foreach ($rows as $row) {
    $cells = explode("\t", $row);
    $minVal = min($cells);
    $maxVal = max($cells);
    $diff = $maxVal - $minVal;
    $total += $diff;
  }
  
  // Echo result to the terminal
  echo("The checksum for the spreadsheet is ".$total.".\n");

?>