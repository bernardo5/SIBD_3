<?php session_start(); ?>
<html>
	<body>
		<h3>Patient name successfully received!</h3>
		<p>Patient name given: <?php echo($_REQUEST['patient_name']); ?></p>
		
<?php
		$patient_nam=$_REQUEST['patient_name'];
		list($p_number, $p_name) = explode(" ", $patient_nam);
		$_SESSION['patient_name'] = $p_name;
		$_SESSION['patient_number']=$p_number;
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
		
		$sql = "SELECT P.number, P.name, W.pan, W.start, W.end FROM Patient as P, Wears as W WHERE P.number='$p_number'
				AND W.patient=P.number";
		$result = $connection->query($sql);
		
		if ($result == FALSE)
		{
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}
		
		
		$nrows= $result->rowCount();
		if($nrows!=0){
			echo("Patient PAN's:<br/>");
			
			echo("<table border=\"1\">");
			echo("<tr><td>number</td><td>name</td><td>pan</td><td>start</td><td>end</td></tr>");
			foreach($result as $row)
			{
				echo("<tr><td>");
				echo($row['number']);
				echo("</td><td>");
				echo($row['name']);
				echo("</td><td>");
				echo($row['pan']);
				echo("</td><td>");
				echo($row['start']);
				echo("</td><td>");
				echo($row['end']);
				echo("</td></tr>");
			}
			echo("</table>");
		}else{
			echo("Patient was never connected to a PAN :)");
		}
		
		
		echo("<p></p> <p></p>");
		echo("Current PAN:");
		echo("<br/>");
		
		
		
		$sql = "SELECT P.number, P.name, W.pan, W.start, W.end FROM Patient as P, Wears as W WHERE P.number='$p_number'
				AND W.patient=P.number AND current_date<=W.end AND current_date>=W.start";
		$result = $connection->query($sql);
		
		if ($result == FALSE)
		{
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}
		
		$nrows= $result->rowCount();
		if($nrows!=0){ /*the patient is using a PAN at the moment*/
		
			echo("<table border=\"1\">");
			echo("<tr><td>number</td><td>name</td><td>pan</td><td>start</td><td>end</td></tr>");
			foreach($result as $row)
			{
				echo("<tr><td>");
				echo($row['number']);
				echo("</td><td>");
				echo($row['name']);
				echo("</td><td>");
				echo($row['pan']);
				$_SESSION['current_pan']=$row['pan'];
				echo("</td><td>");
				echo($row['start']);
				echo("</td><td>");
				echo($row['end']);
				echo("</td></tr>");
			}
			echo("</table>");
			
		}
		else
		{
			echo("<p>Patient has no PAN at the moment</p>");
		}
			
			
			
			echo("<p></p> <p></p>");
			echo("Previous PAN:");
			echo("<br/>");
			
			
			
			$sql = "SELECT P.number, P.name, W.pan, W.start, W.end FROM Patient as P, Wears as W WHERE P.number='$p_number'
					AND W.patient=P.number AND W.end>=all(SELECT W.end FROM Patient as P, Wears as W WHERE P.number='$p_number'
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
			
			
			
			$nrows= $result->rowCount();
			if($nrows!=0){
				echo("<table border=\"1\">");
				echo("<tr><td>number</td><td>name</td><td>pan</td><td>start</td><td>end</td></tr>");
				foreach($result as $row)
				{
					echo("<tr><td>");
					echo($row['number']);
					echo("</td><td>");
					echo($row['name']);
					echo("</td><td>");
					echo($row['pan']);
					$_SESSION['previous_pan']=$row['pan'];
					echo("</td><td>");
					echo($row['start']);
					echo("</td><td>");
					echo($row['end']);
					echo("</td></tr>");
				}
				echo("</table>");
			
			}else{
				echo("<p>No Previous PAN's</p>");
			}
			$connection = null;
			
		if($nrows!=0)
		{
			echo("<p><a href=\"transfer_session2.php\">Keep visualizing resultes </a></p>");
		}
?>
		<p></p>
		<p></p>
		<p></p>
		<a href="transfer_intermediate.php">Go back</a>
		<p></p>
		<p><a href="index__.php">Back to main menu</a></p>
	</body>
</html>
