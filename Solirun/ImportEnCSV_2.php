<table>
  <thead>
    <tr>
      <th>Colonne 1</th>
      <th>Colonne 2</th>
      <th>Colonne 3</th>
      <th>Colonne 3</th>
      <th>Colonne 3</th>
      <th>Colonne 3</th>
      <!-- Ajoutez d'autres en-têtes de colonne si nécessaire -->
    </tr>
  </thead>
  <tbody>
    <?php
    // Chemin d'accès au fichier CSV
    $csvFile = 'classes.csv';

    // Ouvrir le fichier CSV
    if (($handle = fopen($csvFile, 'r')) !== false) {
      // Lire chaque ligne du fichier CSV
      while (($data = fgetcsv($handle, 1000, ',')) !== false) {
        // Afficher chaque ligne dans une nouvelle ligne de tableau
        echo '<tr>';
        // Parcourir chaque champ de la ligne
        foreach ($data as $field) {
          // Afficher chaque champ dans une nouvelle cellule de tableau
          echo '<td>', htmlspecialchars($field), '</td>';
        }
        echo '</tr>';
      }
      // Fermer le fichier CSV
      fclose($handle);
    }
    ?>
  </tbody>
</table>