
<?php
	$doorID = "cxdnnyjw";
	$password = [" "," "," "," "," "," "," "," "];
	$passLen = 0;
	
	for ($i = 0; $passLen < 8; $i++) {
		
		$stringToHash = $doorID.$i;
		$hash = md5($stringToHash);
				
		if (strcmp(substr($hash, 0, 5), "00000") == 0 && ctype_digit(substr($hash,5,1)) && substr($hash,5,1) < 8)
		{
			if (strcmp($password[substr($hash, 5, 1)], " ") == 0){	
				$password[substr($hash,5,1)] = substr($hash,6,1);
				$passLen++;
			}
		}
	}
	$passwordString = "";
	foreach ($password as $character) {
		$passwordString .= $character;
	}
	
	echo "The password for this door is: ".$passwordString."\n";
?>