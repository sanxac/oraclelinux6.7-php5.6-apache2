<!-- Simple PHP app to test functionality of LAMP stack -->
<!-- Sanja Rogers sanja9@gmail.com -->
<h1>Test Page</h1>
<hr><h2>OS</h2>
<?php
  echo php_uname('s');
?>

<hr><h2>Server</h2>
<?php
  echo $_SERVER['SERVER_SOFTWARE'];
?>

<hr><h2>PHP Info</h2>
<?php

  phpinfo();

?>

<hr><h2>MySQL</h2>
<?php
$link = mysqli_connect("127.0.0.1", "root", "root", "app");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    exit;
}

echo "Success: A proper connection to MySQL was made!" . PHP_EOL;
echo "Host information: " . mysqli_get_host_info($link) . PHP_EOL;
mysqli_close($link);

?>
