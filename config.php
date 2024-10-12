<?php

// Configurazione del database con ENV variables.

// Looks for ENV['BLAH'] and if it fails will take the default string set after.
$db_host = getenv('DB_HOST')  ?: 'localhost';
$db_name = getenv('DB_NAME')  ?: 'image_catalog_default';
$db_user = getenv('DB_USER')  ?: 'appmod-phpapp-user';
$db_pass = getenv('DB_PASS')  ?: '_PWD_SCONOSCIUTA_';

try {
    $pdo = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Errore di connessione: " . $e->getMessage());
}

session_start();
?>
