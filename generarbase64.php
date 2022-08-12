#!/usr/bin/php
<?php
    if ($argc != 2 ) {
        echo "Uso: " . $argv[0] . " \"/ruta/de/la/imagen\"\n";
    } else {
        $path = $argv[1];
        $type = pathinfo($path, PATHINFO_EXTENSION);
        $data = file_get_contents($path);
        $base64 = 'data:image/' . $type . ';base64,' . base64_encode($data);
        echo "$base64";
    }
?>
