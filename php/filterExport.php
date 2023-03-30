<?php

$server = "localhost";
$user = "root";
$password = "";
$database = "college";

$connect = new PDO("mysql:host=$server;dbname=$database", $user, $password);
$connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

if (isset($_GET["phrase"]) && isset($_GET["type"])) {
    if ($_GET["phrase"] == "" && ($_GET["minMean"] == "" && $_GET["maxMean"] == "")) {
        $phrase = "";
        $condition = "Nazwisko";
        $minMean = 2;
        $maxMean = 5;
    } else {
        $phrase = $_GET["phrase"];
        $condition = $_GET["type"];
        $minMean = $_GET["minMean"];
        $maxMean = $_GET["maxMean"];
    }
} else {
    $phrase = "";
    $condition = "Nazwisko";
    $minMean = 2;
    $maxMean = 5;
}

$sql = "call searching(?, ?, ?, ?);";
$result = $connect->prepare($sql);
$result->execute([$condition, $phrase, $minMean, $maxMean]);

$filename = "filterExport.csv";

$file = fopen($filename, "w");

fprintf($file, chr(0xEF) . chr(0xBB) . chr(0xBF));

$headers = ["ID", "Imie", "Nazwisko", "Album", "Kierunek", "Srednia", "Dysertacja"];
fputcsv($file, $headers);

while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
    fputcsv($file, $row);
}

fclose($file);

header('Content-Disposition: archive; filename="'.$filename.'"');
readfile($filename);
unlink($filename);
exit();

if (isset($_SERVER["QUERY_STRING"])) header("Location: ../searching.php?" . $_SERVER["QUERY_STRING"]);
else header("Location: ../searching.php");

