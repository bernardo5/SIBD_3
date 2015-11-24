<?php session_start(); ?>

<html>
	<body>
		<h3>Devices connected to the actual pan:<br/></h3>
			<form action='transfer_session3.php' method="post">
		<?php
		$patient_nam=$_SESSION['patient_name'];
		$p_number=$_SESSION['patient_number'];
		$host = "db.ist.utl.pt";
		$user = "ist175573";
		$pass = "swex6595";
		$dsn = "mysql:host=$host;dbname=$user";
		try
		{
			$connection = new PDO($dsn, $user, $pass);
		}
		catch(PDOException $exception)
		{
			echo("<p>Error: ");
			echo($exception->getMessage());
			echo("</p>");
			exit();
		}
		
		$sql = "SELECT P.number, P.name, W.pan, C.snum, C.manuf FROM Patient as P, Wears as W, Connects as C WHERE
				P.number='$p_number' AND W.patient=P.number
			    AND current_date<=W.end AND current_date>=W.start
			    AND W.pan=C.pan AND current_date<=C.end AND current_date>=C.start
				";
		$result = $connection->query($sql);
		
		if ($result == FALSE)
		{
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}
		
		echo("Actual:<br/>");
		
		$nrows= $result->rowCount();
		if($nrows!=0){		
			echo("<table border=\"1\">");
			echo("<tr><td>number</td><td>name</td><td>pan</td><td>device serial number</td><td>device manufacturer</td></tr>");
			foreach($result as $row)
			{
				echo("<tr><td>");
				echo($row['number']);
				echo("</td><td>");
				echo($row['name']);
				echo("</td><td>");
				echo($row['pan']);
				echo("</td><td>");
				echo($row['snum']);
				echo("</td><td>");
				echo($row['manuf']);
				echo("</td></tr>");
			}
			echo("</table>");
		}else{
			echo("<p>Actual PAN has no devices attached</p>");
		}
		
		
		
		
		
		echo("<p></p> <p></p>");
		echo("Previous PAN:");
		echo("<br/>");
		
		
		
		$sql = "SELECT P.number, P.name, W.pan, C.snum, C.manuf, C.end FROM Patient as P, Wears as W, Connects as C WHERE
						P.number='$p_number'
						AND W.patient=P.number AND
						W.end>=all(SELECT W.end FROM Patient as P, Wears as W WHERE P.number='$p_number'
						AND W.patient=P.number AND W.end<current_date AND W.end!='2999-12-31')
						AND W.end<current_date AND 	W.end!='2999-12-31'
						 AND W.pan=C.pan AND (C.start<=W.end AND W.end<=C.end)
				";
		$result = $connection->query($sql);
		
		if ($result == FALSE)
		{
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}
		/******************Verify if previous pan is in use****************************/
		$sql = "SELECT * FROM Wears WHERE end='2999-12-31' 
										AND pan in(SELECT W.pan FROM Patient as P, Wears as W, Connects as C WHERE
													P.number='$p_number'
													AND W.patient=P.number AND
													W.end>=all(SELECT W.end FROM Patient as P, Wears as W WHERE P.number='$p_number'
													AND W.patient=P.number AND W.end<current_date AND W.end!='2999-12-31')
													AND W.end<current_date AND 	W.end!='2999-12-31'
													AND W.pan=C.pan AND (C.start<=W.end AND W.end<=C.end))
										AND patient not in (SELECT P.number FROM Patient as P, Wears as W, Connects as C WHERE
													P.number='$p_number'
													AND W.patient=P.number AND
													W.end>=all(SELECT W.end FROM Patient as P, Wears as W WHERE P.number='$p_number'
													AND W.patient=P.number AND W.end<current_date AND W.end!='2999-12-31')
													AND W.end<current_date AND 	W.end!='2999-12-31'
													AND W.pan=C.pan AND (C.start<=W.end AND W.end<=C.end))
				";
		
		$result_verify = $connection->query($sql);
							
		if ($result_verify == FALSE)
		{
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}
		/***********************/
		$nrows= $result_verify->rowCount();		
		/******************************************************************************/
	
	
		
		echo("<table border=\"1\">");
		echo("<tr><td>number</td><td>name</td><td>pan</td><td>device serial number</td><td>device manufacturer</td><td>inserir?</td></tr>");
		foreach($result as $row)
		{
			echo("<tr><td>");
			echo($row['number']);
			echo("</td><td>");
			echo($row['name']);
			echo("</td><td>");
			echo($row['pan']);
			echo("</td><td>");
			echo($row['snum']);
			echo("</td><td>");
			echo($row['manuf']);
			echo("</td><td>");
			$device=$row['snum'];
			$device.=' ';
			$device.=$row['manuf'];
			if(($row['end']=='2999-12-31')&&($nrows==0))
			{
				echo("<input type=\"checkbox\" name=\"Device[]\" value=\"$device\" />");
			}
			echo("</td></tr>");
		}
		echo("</table>");
		
		$connection = null;
?>



		<p><input type="submit" value="Submit"/></p>
		<p></p>
		<p></p>
		<p></p>
		<p></p>
		<p><a href="index__.php">Back to main menu</a></p>
		</form>
	</body>
</html>
