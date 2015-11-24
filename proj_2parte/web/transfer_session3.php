<?php session_start(); ?>

<html>
	<body>
		<h2>Transfered devices:</h2>
		<?php
		$prev=$_SESSION['previous_pan'];
		$new=$_SESSION['current_pan'];
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
		
			foreach($_REQUEST as $key => $value)
			{
				if($key=='Device')
				{
					foreach($_REQUEST[$key] as $Dev)
					{
						list($snum, $manuf) = explode(" ", $Dev);
						echo("<p> serial number:$snum, Manufacturer:$manuf</p>");
						/*insert into Period the new time period referenced to the new connection*/
						$sql = "insert into Period values (current_date, '2999-12-31')";
						$result = $connection->query($sql);
						
						if ($result == FALSE)
						{
							$info = $connection->errorInfo();
							echo("<p>Error: {$info[2]}</p>");
							exit();
						}
						/***********************************************/
						
						/*gets the begin date of connection of the transfered device*/
						$sql = "SELECT start from Connects WHERE
									snum IN (SELECT C.snum FROM Patient as P, Wears as W, Connects as C WHERE
											P.name like '%$patient_nam%'
											AND W.patient=P.number AND
											W.end>=all(SELECT W.end FROM Patient as P, Wears as W WHERE P.name like '%$patient_nam%'
											AND W.patient=P.number AND W.end<current_date AND W.end!='2999-12-31')
											AND W.end<current_date AND 	W.end!='2999-12-31'
											 AND W.pan=C.pan AND (C.start<=W.end AND W.end<=C.end))
									AND manuf IN(SELECT C.manuf FROM Patient as P, Wears as W, Connects as C WHERE
											P.name like '%$patient_nam%'
											AND W.patient=P.number AND
											W.end>=all(SELECT W.end FROM Patient as P, Wears as W WHERE P.name like '%$patient_nam%'
											AND W.patient=P.number AND W.end<current_date AND W.end!='2999-12-31')
											AND W.end<current_date AND 	W.end!='2999-12-31'
											 AND W.pan=C.pan AND (C.start<=W.end AND W.end<=C.end))";
						$result = $connection->query($sql);
						
						if ($result == FALSE)
						{
							$info = $connection->errorInfo();
							echo("<p>Error: {$info[2]}</p>");
							exit();
						}
						
						foreach($result as $row)
						{
							/*updating Connection with previous pan*/
							$start=$row['start'];
							$sql = "insert into Period values ('$start', current_date)";
							$result = $connection->query($sql);
							
							if ($result == FALSE)
							{
								$info = $connection->errorInfo();
								echo("<p>Error: {$info[2]}</p>");
								exit();
							}
							
							$sql = "update Connects set end=current_date where start='$start' AND snum='$snum' AND
									manuf='$manuf' AND end='2999-12-31' AND pan='$prev'";
							$result = $connection->query($sql);
							
							if ($result == FALSE)
							{
								$info = $connection->errorInfo();
								echo("<p>Error: {$info[2]}</p>");
								exit();
							}
							/******************************************/
							
						}
						/**********************************************/
						
						/*setting the new connection*/
						
						$sql = "insert into Connects values (current_date, '2999-12-31', '$snum', '$manuf', '$new')";
							$result = $connection->query($sql);
							
							if ($result == FALSE)
							{
								$info = $connection->errorInfo();
								echo("<p>Error: {$info[2]}</p>");
								exit();
							}
					}
				}
			}
			
			
			
		?>
		<p></p>
		<p></p>
		<p></p>
		<a href="transfer_session2.php">Go back</a>
		<p></p>
		<p><a href="index__.html">Back to main menu</a></p>
	</body>
</html>
