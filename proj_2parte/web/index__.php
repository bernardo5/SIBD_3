<?php session_start(); 
session_destroy();
?>
<html>
	<head><h2>Hi! Welcome to X Health Care Center Platform!</h2></head>
	<body>
		<hr/>
		<p>Please select the action you want to perform</p>
		<p></p>
		<ul>
			<li>Information check
				<ul>
				<li><a href="Readings_Settings.html">Readings and Settings of a patient</a></li>				
				</ul>
			</li>
			<li>Database changes
				<ul>
					<li><a href="Transfer_device.html">Transfer a device to another PAN</a></li>
				</ul>
			</li>
		</ul>
	</body>
</html>
