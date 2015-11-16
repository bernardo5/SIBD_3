<html>
	<body>
	<h3>Accounts</h3>
<?php
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
	$sql = "SELECT * FROM account";
	$result = $connection->query($sql);
	if ($result == FALSE)
	{
		$info = $connection->errorInfo();
		echo("<p>Error: {$info[2]}</p>");
		exit();
	}
	echo("<table border=\"0\" cellspacing=\"5\">\n");
	foreach($result as $row)
	{
		echo("<tr>\n");
		echo("<td>{$row['account_number']}</td>\n");
		echo("<td>{$row['balance']}</td>\n");
		echo("<td><a href=\"newbalance.php?account_number=");
		echo($row['account_number']);
		echo("\">Change balance</a></td>\n");
		echo("</tr>\n");
	}
	echo("</table>\n");
	$connection = null;
?>
	</body>
</html>
