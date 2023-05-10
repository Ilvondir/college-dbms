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

    $result = $connect->prepare($sql);
    $result->execute([$condition, $phrase, $minMean, $maxMean]);

    $counter = $result->rowCount();

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
                        <input type="number" value="1" name="page" style="display: none">

                        <div class="text-center">
                            <input type="submit" class="btn btn-primary mt-3" value="Szukaj">
                        </div>
                    </form>
                </div>


                <p class="mt-5 mb-0">
                    Odnaleziono <b><?php echo $counter ?></b> pasujących rekordów.
                </p>
                <div class="w-100 mt-0 text-right">
                    <?php if ($counter>0) { ?>
                        <button onclick="window.location = 'php/filterExport.php?<?php if (isset($_SERVER["QUERY_STRING"])) echo $_SERVER['QUERY_STRING'] ?>'" class="mt-3 btn btn-primary" style="cursor: pointer">Eksportuj wyniki wyszukiwania</btn>
                    <?php } ?>
                </div>
                <table class="table mt-4 table-striped">
                    <tr>
                        <th>ID</th>
                        <th>Nazwisko</th>
                        <th>Imię</th>
                        <th>Numer albumu</th>
                        <th>Kierunek studiów</th>
                        <th>Praca magisterska</th>
                        <th>Średnia ocen</th>
                    </tr>
                    <?php 
                        $rows = $result->fetchAll();
                        $start = 0;
                        $stop = 25;
                        $recordsOnPage = 25;
                        if (isset($_GET["page"])) {
                            $page = $_GET["page"];
                            $start = $recordsOnPage*($page - 1);
                            $stop = $recordsOnPage*$page;
                        }
                        for ($i = $start; $i<$stop; $i++) { 
                            if ($i >= count($rows)) break;
                        ?>
                            <tr onclick="window.location = 'student.php?id=<?php echo $rows[$i]["IDStudenta"] ?>'">
                                <td><?php echo $rows[$i]["IDStudenta"] ?></td>
                                <td><?php echo $rows[$i]["Nazwisko"] ?></td>
                                <td><?php echo $rows[$i]["Imie"] ?></td>
                                <td><?php echo $rows[$i]["NrAlbumu"] ?></td>
                                <td><?php echo $rows[$i]["Kierunek"] ?></td>
                                <td><?php echo $rows[$i]["NazwaProjektu"] ?></td>
                                <td><?php echo $rows[$i]["SredniaOcen"] ?></td>
                            </tr>
                    <?php } ?>
                </table>
                <div class="w-100 text-center">
                    <?php 
                    if (isset($_GET["page"])) {
                        $page = $_GET["page"];

                        if ($page>1) {
                            echo "<a href='searching.php?type=". $_GET["type"]. "&phrase=". $_GET["phrase"]. "&minMean=". $_GET["minMean"]. "&maxMean=". $_GET["maxMean"]. "&page=". ($_GET["page"]-1). "'><button class='btn btn-primary mr-4'>< Poprzednia</button></a>";
                        }
                        $maxPage = ceil(count($rows)/$recordsOnPage);

                        if ($page<$maxPage) {
                            echo "<a href='searching.php?type=". $_GET["type"]. "&phrase=". $_GET["phrase"]. "&minMean=". $_GET["minMean"]. "&maxMean=". $_GET["maxMean"]. "&page=". ($_GET["page"]+1). "'><button class='btn btn-primary'>Następna ></button></a>";
                        }
                    } else {
                        echo "<a href='searching.php?type=Nazwisko&phrase=&minMean=2&maxMean=5&page=2'><button class='btn btn-primary'>Następna ></button></a>";

                    }
                    
                    
                    ?>
                </div>
            </div>
        </div>
    </div>

</body>

</html>