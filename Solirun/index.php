<?php
define('MYSQL_HOST', '172.16.119.4');
define('MYSQL_USERNAME', 'solirun');
define('MYSQL_PASSWORD', 'solirunsioadmin');
define('MYSQL_DATABASE', 'Solirun');

session_start(); // Start the session

$login = false;
$uname = '';
$psw = '';

/* Mode bavard (toutes les erreurs affichées) */
error_reporting(E_ALL);
ini_set('display_errors', 1);
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

$mysql = new mysqli(MYSQL_HOST, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DATABASE);    // Connexion à la base

if (isset($_POST['uname']) && isset($_POST['psw'])) {

    $uname = $_POST['uname'];
    $psw = $_POST['psw'];

    if (!empty($uname) && !empty($psw)) {

        // Requête avec paramètres
        $query = $mysql->prepare("SELECT `login`,motDePasse FROM utilisateurs WHERE `login`= ?");
        $query->bind_param('s', $uname);

        $query->execute();                // Exécution
        $result = $query->get_result();

        if ($result->num_rows === 1) {
            $row = $result->fetch_assoc();
            if (md5($psw) === $row['motDePasse']) {
                $_SESSION['username'] = $uname;
                $login = true;
            }
            else{
                echo("Tu t'es trompé");
            }
        }

        
        
    }
}
else {
    if (isset($_SESSION['username'])) {
        $login = true;
        $uname = $_SESSION['username'];
    }
}

if ($login) {    // Connecté
    $sortie_html = file_get_contents('Admin.html'); 
    // Récupération contenu fichier Admin.html

    $result = $mysql->execute_query("SELECT * FROM vueProf");
    //var_dump($result);

    foreach ($result as $row) {
        //var_dump($row);die;
        $html .= "<tr><td>".$row["nomClasse"]."</td>"."<td>".$row["nbEtudiant"]."</td>"."<td>"."<button name='button' a href='AjoutClasse.html'>Supprimer</button>"."</td></tr>";
    }

    $sortie_html = preg_replace("/##liste##/", $html, $sortie_html);

    $mysql->close();
    // Fermeture connexion MySQL

} else {    // Pas connecté
    $sortie_html = file_get_contents('Authentification.html');   
    // Récupération contenu fichier Authentification.html
}



echo $sortie_html;
