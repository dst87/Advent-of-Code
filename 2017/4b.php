<?php
  // Advent of Code 2017: Day 4


  // Capture input from text file
  $inputTextFile = file_get_contents('inputs/4.txt');
  
  // Counter for invalid passphrases
  $invalidCount = 0;
  
  // Split raw text into array by line break
  $passphrases = explode("\n", $inputTextFile);
  
  // Loop through all each phrases, comparing every
  // word against every other word  
  foreach ($passphrases as $passphrase) {
    $words = explode(" ", $passphrase);
    $wordCount = count($words);
    
    // Sort the letters in each word alphabetically
    // to test for anagrams in part b
    foreach ($words as &$word) {
      $sortedWord = "";
      $letters = str_split($word);
      sort($letters);
      $word = implode("", $letters);
    }
    
    for ($i = 0; $i < $wordCount; $i++) {
      for ($j = $i+1; $j < $wordCount; $j++) {
        if ($words[$i] == $words[$j]) {
          $invalidCount++;
          break 2;
        }
      }
    }
  }
  
  // Output results
  $totalPhraseCount = count($passphrases);
  $validPhraseCount = $totalPhraseCount - $invalidCount;
  
  echo("There are ".$validPhraseCount." valid phrases.\n");
?>