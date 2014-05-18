<?php

$con=mysqli_connect("localhost","sampleUser","sampleUser","sampleAppDB");

// Check connection
if (mysqli_connect_errno()) 
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

if(isset($_POST['Username']) && isset($_POST['Password']))
{
	$username = $_POST['Username'];
	$password = hash("sha256", $_POST['Password']);
	$sql = "SELECT Password FROM Users where Username = '" . $username . "' ";

	$result = mysqli_query($con,$sql);

	$number_rows = mysqli_num_rows($result);

	if($number_rows	> 0)
	{
		while($row = mysqli_fetch_array($result)) {
		  if($row['Password'] == $password)
		  {
		  	echo 'Logged in!';
		  }
		  else
		  {
		  	echo 'Loggin Faile!';
		  }
		}
	}		
	else
	{
		echo 'Loggin Faile!';
	}
}
else
{
	echo 'Missing parameters';
}

mysqli_close($con);
	
?>