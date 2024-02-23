<?php
define('MYSQL_HOST', '172.16.119.4');
define('MYSQL_USERNAME', 'solirun');
define('MYSQL_PASSWORD', 'solirunsioadmin');
define('MYSQL_DATABASE', 'Solirun');

session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

// Établir une connexion à la base de données
$mysql = new mysqli(MYSQL_HOST, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DATABASE);


$mysql->close();
?>
