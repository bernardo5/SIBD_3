<html>
	<body>
		<h3>Patient name successfully received!</h3>
		<p>Patient name given: <?php echo($_REQUEST['patient_name']); ?></p>
		<p>Patient info:</p>
<?php
		$patient_nam=$_REQUEST['patient_name'];
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
		
		$sql = "SELECT number,name, address FROM Patient WHERE name like '%$patient_nam%'";
		$result = $connection->query($sql);
		
		if ($result == FALSE)
		{
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}
		
		echo("<table border=\"1\">");
		echo("<tr><td>number</td><td>name</td><td>address</td></tr>");
		foreach($result as $row)
		{
			echo("<tr><td>");
			echo($row['number']);
			echo("</td><td>");
			echo($row['name']);
			echo("</td><td>");
			echo($row['address']);
			echo("</td></tr>");
		}
		echo("</table>");
		$connection = null;
		
		
		
		echo("	<p>Patient Readings:</p>");
		
		
		
		
		
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
		
		$sql = "SELECT DISTINCT W.patient, C.snum, C.manuf, R.datetime, R.value, S.units FROM Wears as W, Connects as C, Reading as R, Device as D, Sensor as S
				WHERE(
					(R.snum=C.snum AND R.manuf= C.manuf) AND (R.datetime>=C.start AND R.datetime<=C.end)
					AND
					(R.datetime>=W.start AND R.datetime<=W.end)
					AND
					((R.snum=S.snum AND R.manuf= S.manuf))
					AND
					(C.pan= W.pan) AND (W.patient IN (SELECT number FROM Patient WHERE name like '%$patient_nam%'))
				)";
		$result = $connection->query($sql);
		
		if ($result == FALSE)
		{
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}
		
		echo("<table border=\"1\">");
		echo("<tr><td>Patient</td><td> device serial number</td><td> device manufacturer</td><td>time</td><td>value</td><td>units</td></tr>");
		foreach($result as $row)
		{
			echo("<tr><td>");
			echo($row['patient']);
			echo("</td><td>");
			echo($row['snum']);
			echo("</td><td>");
			echo($row['manuf']);
			echo("</td><td>");
			echo($row['datetime']);
			echo("</td><td>");
			echo($row['value']);
			echo("</td><td>");
			echo($row['units']);
			echo("</td></tr>");
		}
		echo("</table>");
		$connection = null;
		
		
		
		echo("	<p>Patient Settings:</p>");
		
		
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
		
		$sql = "SELECT DISTINCT W.patient, C.snum, C.manuf, S.datetime, S.value, A.units FROM Wears as W, Connects as C, Setting as S, Device as D, Actuator as A
				WHERE(
					(S.snum=C.snum AND S.manuf= C.manuf) AND (S.datetime>=C.start AND S.datetime<=C.end)
					AND
					(S.datetime>=W.start AND S.datetime<=W.end)
					AND
					((S.snum=A.snum AND S.manuf= A.manuf))
					AND
					(C.pan= W.pan) AND (W.patient IN (SELECT number FROM Patient WHERE name like '%$patient_nam%'))
				)";
		$result = $connection->query($sql);
		
		if ($result == FALSE)
		{
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}
		
		echo("<table border=\"1\">");
		echo("<tr><td>Patient</td><td> device serial number</td><td> device manufacturer</td><td>time</td><td>value</td><td>units</td></tr>");
		foreach($result as $row)
		{
			echo("<tr><td>");
			echo($row['patient']);
			echo("</td><td>");
			echo($row['snum']);
			echo("</td><td>");
			echo($row['manuf']);
			echo("</td><td>");
			echo($row['datetime']);
			echo("</td><td>");
			echo($row['value']);
			echo("</td><td>");
			echo($row['units']);
			echo("</td></tr>");
		}
		echo("</table>");
		$connection = null;
		
		
		
?>
	<p></p>
	<a href="http://web.ist.utl.pt/ist175573/Readings_Settings.html">Go back</a>
	<p></p>
	<p><a href="http://web.ist.utl.pt/ist175573/index__.html">Back to main menu</a></p>
	</body>
</html>
