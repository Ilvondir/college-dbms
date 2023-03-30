<?php
session_start();

$server = "localhost";
$user = "root";
$password = "";
$database = "college";

try {
    $connect = new PDO("mysql:host=$server;dbname=$database", $user, $password);
    $connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $sql = "call searching(?, ?, ?, ?)";

    if (isset($_GET["phrase"]) && isset($_GET["type"])) {
        if ($_GET["phrase"] == "" && ($_GET["minMean"]=="" && $_GET["maxMean"]=="")) {
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

    $result = $connect->prepare($sql);
    $result->execute([$condition, $phrase, $minMean, $maxMean]);
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
    <script src="js/script.js" defer></script>

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
                <li>
                    <a href="index.php"><span class="fa fa-home mr-3"></span> Strona główna</a>
                </li>
                <li class="active">
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

                <h2>Wyszukaj</h2>

                <div class="d-flex justify-content-center">
                    <form action="#" method="GET" class="form w-50">
                        <label for="type" class="label">Wybierz kryterium:</label>
                        <select name="type" class="form-control" id="type" onchange="displays()">
                            <option>Imię</option>
                            <option selected>Nazwisko</option>
                            <option>Numer albumu</option>
                            <option>Kierunek studiów</option>
                            <option>Temat pracy magisterskiej</option>
                            <option>Średnia ocen</option>
                        </select>

                        <div class="" id="fd1">
                            <label for="phrase" class="label">Wpisz poszukiwaną frazę:</label>
                            <input type="text" id="phrase" name="phrase" class="form-control">
                        </div>
                        <div class="d-none" id="fd2">
                            <label class="label">Wybierz zakres średniej:</label><br>
                            <div class="input-group">
                                <input type="number" class="form-control" min="2" max="5" value="2" step="0.01" name="minMean">
                                <div class="input-group-append input-group-prepend">
                                    <div class="input-group-text"> do </div>
                                </div>
                                <input type="number" class="form-control" min="2" max="5" value="5" step="0.01" name="maxMean">
                            </div>
                        </div>

                        <div class="text-center">
                            <input type="submit" class="btn btn-primary mt-3" value="Szukaj">
                        </div>
                    </form>
                </div>


                <table class="table mt-5 table-striped">
                    <tr>
                        <th>ID</th>
                        <th>Nazwisko</th>
                        <th>Imię</th>
                        <th>Numer albumu</th>
                        <th>Kierunek studiów</th>
                        <th>Praca magisterska</th>
                        <th>Średnia ocen</th>
                    </tr>
                    <?php while ($rows = $result->fetch()) { ?>
                        <tr onclick="window.location = 'student.php?id=<?php echo $rows["IDStudenta"] ?>'">
                            <td><?php echo $rows["IDStudenta"] ?></td>
                            <td><?php echo $rows["Nazwisko"] ?></td>
                            <td><?php echo $rows["Imie"] ?></td>
                            <td><?php echo $rows["NrAlbumu"] ?></td>
                            <td><?php echo $rows["Kierunek"] ?></td>
                            <td><?php echo $rows["NazwaProjektu"] ?></td>
                            <td><?php echo $rows["SredniaOcen"] ?></td>
                        </tr>
                    <?php } ?>
                </table>
            </div>
        </div>
    </div>

</body>

</html>