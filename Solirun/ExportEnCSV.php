<?php


$servername = "mariadb";
$username = "Solirun";
$password = "solirunsioadmin";
$dbname = "Solirun";

$conn = new mysqli($servername, $username, $password, $dbname);

// Vérification de la connexion
if ($conn->connect_error) {
    die("Échec de la connexion à la base de données : " . $conn->connect_error);
}

$sql = "SELECT nomClasse, nbEtudiant, nbTours, surnom FROM Classe";
$result = $conn->query($sql);

//Création du fichier CSV
$csv_filename = "export_classe.csv"; //attention, il faut peut-être créer le fichier avant
header('Content-Type: text/csv');
header('Content-Disposition: attachment; filename="' . $csv_filename . '"');

// Ouvrir le fichier en écriture
$output = fopen('php://output', 'w');

// Écrire l'en-tête CSV
fputcsv($output, array('nomClasse', 'nbEtudiant', 'nbTours', 'surnom'));

while ($row = $result->fetch_assoc()) {
    fputcsv($output, $row);
}

fclose($output);

$conn->close();

?>