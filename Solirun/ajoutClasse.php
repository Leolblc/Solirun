<?php
define('MYSQL_HOST', '172.16.119.4');
define('MYSQL_USERNAME', 'solirun');
define('MYSQL_PASSWORD', 'solirunsioadmin');
define('MYSQL_DATABASE', 'Solirun');

error_reporting(E_ALL);
ini_set('display_errors', 1);
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

$mysql = new mysqli(MYSQL_HOST, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DATABASE);

if(isset($_POST['classe']) && isset($_POST['nbEleve'])) {
    $classe = $_POST['classe'];
    $nbEl = $_POST['nbEleve'];

    if (!empty($classe) && !empty($classe)) {
        $query = $mysql->prepare("INSERT INTO Classes(nomClasse, nbEtudiant) VALUES (?,?) ");

        $query->bind_param("si", $classe, $nbEl);
        $query->execute(); 


        if ($query->errno) {
            echo "Erreur lors de l'exécution de la requête : " . $query->error;
        } 
        
        else {
            echo '<script>alert("La classe a été ajoutée")</script>';
        }

        $query->close();

    }
}
$mysql->close();

echo file_get_contents('index.php');

?>