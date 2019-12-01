
<?php
	$doorID = "cxdnnyjw";
	$password = "";
	$passLen = 0;
	
	for ($i = 0; $passLen < 8; $i++) {
		
		$stringToHash = $doorID+$i;
		$hash = md5($stringToHash);
				
		if (strcmp(substr($hash, 0, 5), "00000") == 0 )
		{
			$password .= substr($hash,5,1);
			$passLen++;
		}
	}
	
	echo "The password for this door is: ".$password."\n";
?>