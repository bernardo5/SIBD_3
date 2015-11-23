<?php session_start(); ?>

<html>
	<body>
		<h2>Transfered devices:</h2>
		<?php
			foreach($_REQUEST as $key => $value)
			{
				if($key=='Device')
				{
					foreach($_REQUEST[$key] as $Dev)
					{
						echo("<p>$key=$Dev</p>");
					}
				}
			}
		?>
	</body>
</html>
