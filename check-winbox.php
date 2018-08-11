<!DOCTYPE HTML>  
<html>
<head>
<style>
.error {color: #FF0000;}
</style>
</head>
<body>  

<?php
// define variables and set to empty values
$nameErr = $name = $output = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  if (empty($_POST["name"])) {
    $nameErr = "Masukkan IP atau Segmen IP yg diinginkan";
  } else {
    $name = test_input($_POST["name"]);
    // check if name only contains letters and whitespace
    if ( preg_match('~^(?:[0-9]{1,3}\.){3}[0-9]{1,3}/[0-9][0-9]~',$name) || preg_match('~^(?:[0-9]{1,3}\.){3}[0-9]{1,3}~',$name) ) {
	    $output = shell_exec("./ex.sh $name");
    } else {
        $nameErr = "Bukan merupakan IP atau Segmen IP "; 
	}
  }
}

function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}
?>

<h2>Pengecekan Exploit Winbox MikroTik</h2>
<p><span class="error">* required field</span></p>
<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">  
  IP/Subnet: <input type="text" name="name" value="<?php echo $name;?>">
  <span class="error">* <?php echo $nameErr;?></span>
  <br><br>
  <input type="submit" name="submit" value="Submit">  
</form>

<?php
echo "<h2>Hasil scan MikroTik : $name </h2>";
echo "<pre>$output</pre>"
?>

</body>
</html>
