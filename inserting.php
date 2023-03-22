<?php
session_start();

if (!isset($_SESSION["logged"])) {
    header("Location: index.php");
}

if (isset($_SESSION["logged"])) {
    if (!$_SESSION["logged"]) header("Location: index.php");
}

$success = false;

try {
    $server = "localhost";
    $user = "root";
    $password = "";
    $database = "college";

    $connect = new PDO("mysql:host=$server;dbname=$database", $user, $password);
    $connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    if ($_SERVER["REQUEST_METHOD"] == "GET") {
        if (isset($_GET["name"])) {
            $name = $_GET["name"];
            $surname = $_GET["surname"];
            $album = $_GET["albumNumber"];
            $way = $_GET["way"];
            $mean = $_GET["mean"];
            $work = $_GET["work"];
            $mark = $_GET["mark"];

            $sql = "call inserting(?, ?, ?, ?, ?, ?, ?)";

            $result = $connect->prepare($sql);
            $result->execute([
                $name,
                $surname,
                $album,
                $way,
                $mean,
                $work,
                $mark
            ]);

            $success = true;
        }

        $sql2 = "call getHobbies()";
        $result2 = $connect->prepare($sql2);
        $result2->execute();
    }
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
                <li>
                    <a href="index.php"><span class="fa fa-home mr-3"></span> Strona główna</a>
                </li>
                <li>
                    <a href="searching.php"><span class="fa fa-filter mr-3"></span> Wyszukiwanie</a>
                </li>
                <?php
                if (isset($_SESSION["logged"])) {
                    if ($_SESSION["logged"]) echo '<li class="active">
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
                        if ($_SESSION["logged"]) echo '<a href="logout.php">';
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


        <div id="content" class="p-4 p-md-5 pt-5">
            <div class="containerToTable">
                <h2>Dodanie studenta</h2>
                <form action="#" method="GET">

                    <div class="float-left w-50 p-3">
                        <label for="name" class="form-label">Imię:</label><br>
                        <input type="text" name="name" id="name" class="form-control" required>
                    </div>
                    <div class="float-left w-50 p-3">
                        <label for="surname" class="form-label">Nazwisko:</label><br>
                        <input type="text" name="surname" id="surname" class="form-control" required>
                    </div>

                    <div class="float-left w-33 pl-5 pb-4 pr-4 pt-4">
                        <label for="albumNumber" class="form-label">Numer albumu:</label><br>
                        <input type="number" name="albumNumber" id="albumNumber" class="form-control" min="111111" max="999999" required>
                    </div>
                    <div class="float-left w-50 p-4">
                        <label for="way" class="form-label">Kierunek studiów:</label><br>
                        <input type="text" name="way" id="way" class="form-control" required>
                    </div>
                    <div class="float-left w-33 p-4">
                        <label for="mean" class="form-label">Średnia:</label><br>
                        <input type="number" name="mean" id="mean" class="form-control" min="2" max="5" step="0.01" required>
                    </div>
                    <div class="float-left w-75 p-3">
                        <label for="work" class="form-label">Temat pracy magisterskiej:</label><br>
                        <input type="text" name="work" id="work" class="form-control" required>
                    </div>
                    <div class="float-left w-25 p-3">
                        <label for="mark" class="form-label">Ocena:</label><br>
                        <input type="number" name="mark" id="mark" class="form-control" min="2" max="5" step="0.5" required>
                    </div>

                    <div class="float-left w-100 p-3">
                        <label for="hobby" class="form-label">Wybierz hobby:</label><br>
                        <select name="hobby" id="hobby" class="form-control" required>
                            <?php
                            while ($hobbies = $result2->fetch()) {
                                echo "<option>" . $hobbies["Nazwa"] . "</option>";
                            }
                            ?>
                        </select>
                    </div>

                    <div class="float-left text-right w-100">
                        <input type="reset" value="Wyczyść" class="btn btn-danger">
                        <input type="submit" value="Dodaj do bazy" class="btn btn-primary"><br>
                        <?php
                        if ($success) echo "Dodanie studenta przebiegło pomyślnie.";
                        ?>
                    </div>
                </form>
            </div>
        </div>
    </div>

</body>

</html>