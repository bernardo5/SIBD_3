<html>
	<body>
		<form action="Patient.php" method="post">
<?php
		$patient_nam=$_REQUEST['patient_name'];
		$host = "db.ist.utl.pt";
		$user = "ist175573";
		$pass = "xxxx";
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
		
		$sql = "SELECT number, name FROM Patient WHERE name like '%$patient_nam%'";
		$result = $connection->query($sql);
		
		if ($result == FALSE)
		{
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}
		
		$nrows= $result->rowCount();
		if($nrows!=0){
		
			echo("Select Patient:<br/>");
			
			echo("<table border=\"1\">");
			echo("<tr><td>number</td><td>name</td><td>is this one?</td></tr>");
			foreach($result as $row)
			{
				echo("<tr><td>");
				echo($row['number']);
				echo("</td><td>");
				echo($row['name']);
				echo("</td><td>");
				$numb=$row['number'].' ';
				$numb.=$row['name'];
				echo("<input type=\"radio\" name=\"patient_name\" value=\"$numb\" />");
				echo("</td></tr>");
			}
			echo("</table>");
			
			echo("<p><input type=\"submit\" value=\"Submit\"/></p>");
		}else{
			echo("No patients with given characters... :(");
		}
?>
		<p></p>
		<p></p>
		<p></p>
		<a href="Readings_Settings.html">Go back</a>
		<p></p>
		<p><a href="index__.php">Back to main menu</a></p>
		</form>
	</body>
</html>
