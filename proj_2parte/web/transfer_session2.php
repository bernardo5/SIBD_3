<?php session_start(); ?>

<html>
	<body>
		<h3>Devices connected to the actual pan:<br/></h3>
		<?php
		$patient_nam=$_SESSION['patient_name'];
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
				P.name like '%$patient_nam%' AND W.patient=P.number
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
		
		
		
		
		
		echo("<p></p> <p></p>");
		echo("Previous PAN:");
		echo("<br/>");
		
		
		
		$sql = "SELECT P.number, P.name, W.pan, W.start, W.end FROM Patient as P, Wears as W WHERE P.name like '%$patient_nam%'
				AND W.patient=P.number AND W.end>=all(SELECT W.end FROM Patient as P, Wears as W WHERE P.name like '%$patient_nam%'
			    AND W.patient=P.number AND W.end<current_date AND W.end!='2999-12-31')
				AND W.end<current_date AND 	W.end!='2999-12-31'
				";
		$result = $connection->query($sql);
		
		if ($result == FALSE)
		{
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}
		
		echo("Actual:<br/>");
		
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
		
		
		
		$connection = null;
?>

		<p></p>
		<p></p>
		<p></p>
		<a href="transfer.php">Go back</a>
		<p></p>
		<p><a href="index__.html">Back to main menu</a></p>
	</body>
</html>
