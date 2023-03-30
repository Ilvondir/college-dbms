<?php
    if (isset($_GET["id"])) {
        $id = $_GET["id"];

        $server = "localhost";
        $user = "root";
        $password = "";
        $database = "college";
    
        $connect = new PDO("mysql:host=$server;dbname=$database", $user, $password);
        $connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "call deleting(?);";
        $result = $connect->prepare($sql);
        $result->execute([$id]);
    }


    header("Location: ../searching.php");
?>