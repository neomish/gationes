#!/usr/bin/php
<?php
    if ($argc != 2 ) {
        echo "Uso: " . $argv[0] . " \"Clave super secreta\"\n";
    } else {
       echo password_hash( $argv[1], PASSWORD_DEFAULT)."\n";
    }
?>
