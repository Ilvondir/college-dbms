<?php
session_start();

$server = "localhost";
$user = "root";
$password = "";
$database = "college";

try {
    $connect = new PDO("mysql:host=$server;dbname=$database", $user, $password);
    $connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $sql = "call getKierunki()";

    $result = $connect->prepare($sql);
    $result->execute();
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}
?>

<!DOCTYPE html>
<html lang="pl-PL">

<head>
    <title>College Database Management System</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">

    <script src="js/libs/jquery.min.js" defer></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" defer></script>

    <script src="js/navbar.js" defer></script>

    <link rel="shortcut icon" href="img/icon.ico">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/libs/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

    <div class="wrapper d-flex align-items-stretch">
        <nav id="sidebar">
            <div class="custom-menu">
                <button type="button" id="sidebarCollapse" class="btn btn-primary">
                    <i class="fa fa-bars"></i>
                    <span class="sr-only">Toggle Menu</span>
                </button>
            </div>
            <h1><a href="index.php" class="logo">College DBMS</a></h1>
            <ul class="list-unstyled components mb-5">
                <li class="active">
                    <a href="index.php"><span class="fa fa-home mr-3"></span> Strona główna</a>
                </li>
                <li>
                    <a href="searching.php"><span class="fa fa-filter mr-3"></span> Wyszukiwanie</a>
                </li>
                <?php
                if (isset($_SESSION["logged"])) {
                    if ($_SESSION["logged"]) echo '<li>
                        <a href="inserting.php"><span class="fa fa-plus mr-3"></span> Wstawianie</a>
                        </li>';
                }
                ?>
                <li>
                    <a href="export.php"><span class="fa fa-book mr-3"></span> Eksport</a>
                </li>
                <li>
                    <?php
                    if (isset($_SESSION["logged"])) {
                        if ($_SESSION["logged"]) echo '<a href="php/logout.php">';
                        else echo '<a href="login.php">';
                    } else echo '<a href="login.php">';

                    echo '<span class="fa fa-address-book mr-3"></span>';

                    if (isset($_SESSION["logged"])) {
                        if ($_SESSION["logged"]) echo " Wyloguj się";
                        else echo " Logowanie";
                    } else echo " Logowanie";

                    echo "</a>";
                    ?>
                </li>
            </ul>

        </nav>


        <div id="content" class="pl-4 pr-4 pl-md-5 pr-md-5 pt-5">
            <div class="containerToTable">
                <h2>Lista kierunków studiów</h2>
                <p>Jeśli szukanego kierunku studiów tu brakuje należy go najpierw zaimportować.</p>

                <table class="table">
                    <tr>
                        <th>ID</th>
                        <th>Kierunek</th>
                    </tr>
                    <?php while ($row = $result->fetch()) { ?>
                        <tr>
                            <td><?php echo $row["ID"] ?></td>
                            <td><?php echo $row["Nazwa"] ?></td>
                        </tr>
                    <?php } ?>
                </table>

            </div>

</body>

</html>