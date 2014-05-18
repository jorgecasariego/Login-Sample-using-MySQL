<?

$con=mysqli_connect("localhost","sampleUser","sampleUser","sampleAppDB");

// Check connection
if (mysqli_connect_errno()) 
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

if(isset($_POST['Username']) && isset($_POST['Password']) && isset($_POST['Email']))
{
	$username = $_POST['Username'];
	$password = hash("sha256", $_POST['Password']);
	$email = $_POST['Email'];
	

	$result = mysqli_query($con,"INSERT INTO Users (Username, Password, Email)
	VALUES ('" . $username . "', '" . $password . "', '" . $email . "')");

	if(!$result)
	{
		echo 'Duplicate user detected. User: '.$username;
	}
	else
	{
		echo 'User added';
	}
}
else
{
	echo 'Missing Parameters';
}

mysqli_close($con);
?>