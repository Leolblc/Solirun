<?php

define('MYSQL_HOST', '172.16.119.4');
define('MYSQL_USERNAME', 'solirun');
define('MYSQL_PASSWORD', 'solirunsioadmin');
define('MYSQL_DATABASE', 'Solirun');

// Connexion à la base de données MySQL
$mysql = new mysqli(MYSQL_HOST, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DATABASE);

// Vérification de la connexion
if ($mysql->connect_error) {
    die("La connexion à la base de données a échoué : " . $mysql->connect_error);
}

// Chemin du fichier CSV à importer
$chemin_fichier_csv = '\';

// Vérification de l'existence du fichier
if (!file_exists($chemin_fichier_csv)) {
    die("Le fichier CSV n'existe pas.");
}

// Ouverture du fichier en lecture
$fichier_csv = fopen($chemin_fichier_csv, 'r');

// Vérification de l'ouverture du fichier
if (!$fichier_csv) {
    die("Impossible d'ouvrir le fichier CSV.");
}

// Lecture et insertion des données dans la base de données
while (($ligne = fgetcsv($fichier_csv)) !== false) {
    // Utilisez les données de chaque ligne comme nécessaire
    $nom = $ligne[0];
    $prenom = $ligne[1];
    $login = $ligne[2];

    // Exécutez votre requête d'insertion ici
    $query = $mysql->prepare("INSERT INTO utilisateurs (nom, prenom, login) VALUES (?, ?, ?)");
    $query->bind_param('sss', $nom, $prenom, $login);
    $query->execute();
}

// Fermeture du fichier CSV
fclose($fichier_csv);

// Fermeture de la connexion à la base de données MySQL
$mysql->close();

echo "Importation CSV terminée.";

?>
