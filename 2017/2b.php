<?php
  // Advent of Code 2017: Day 2


  // Capture input from text file
  $inputTextFile = file_get_contents('inputs/2.txt');
  
  // Zero counter for adding checksum values
  $total = 0;
  
  // Split text file by new line (or 'row' in the 'spreadsheet')
  $rows = explode("\n", $inputTextFile);
    
  // Split each 'row' into 'cells'
  foreach ($rows as $row) {
    $cells = explode("\t", $row);
      // Loop through each cell, comparing it with every other cell
      foreach ($cells as $valA) {
        foreach ($cells as $valB) {
          // Avoid comparing one cell with itself
          if ($valA == $valB) {
            continue;
          }
          // Divide the result and check if result is whole number
          // If so, add it to total
          $result = $valA / $valB;
          if (is_int($result)) {
            $total += $result;
            break 2;
          }
        }
      }
  }
  
  // Echo result to the terminal
  echo("The checksum for the spreadsheet is ".$total.".\n");

?>