<?php
session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $server = "localhost";
    $user = "root";
    $password = "";
    $database = "college";

    try {
        $connect = new PDO("mysql:host=$server;dbname=$database", $user, $password);
        $connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "call showToExport(?)";

        $tabs = ["studenci", "projekty", "zainteresowania", "kierunki"];

        $archive = "export-" . date("Ymd-His") . ".zip";
        $zip = new ZipArchive();
        if ($zip->open($archive, ZipArchive::CREATE) != TRUE) {
            exit("cannot open\n");
        }

        foreach ($tabs as $tab) {
            $result = $connect->prepare($sql);
            $result->execute([$tab]);

            $filename = $tab . ".csv";
            $file = fopen($filename, "w");
            fprintf($file, chr(0xEF) . chr(0xBB) . chr(0xBF));
            while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
                fputcsv($file, $row);
            }
            fclose($file);

            $zip->addFile($filename, $filename);
        }

        $zip->close();

        foreach ($tabs as $tab) unlink($tab . ".csv");

        header('Content-Disposition: archive; filename="' . $archive . '"');
        readfile($archive);

        unlink($archive);
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
    }
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
                    if ($_SESSION["logged"]) echo '<li>
                        <a href="inserting.php"><span class="fa fa-plus mr-3"></span> Wstawianie</a>
                        </li>';
                }
                ?>
                <li class="active">
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
            <h2>Eksport bazy danych</h2>

            <p class="mt-4">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam facilisis vulputate dui sed dapibus. Phasellus sed facilisis tellus. Curabitur ac libero consequat est sodales elementum. Nam accumsan erat eu sem ultricies ultrices. Vestibulum sed massa pharetra, maximus metus sit amet, rhoncus justo. Phasellus viverra lacinia felis. Morbi vel eros erat. Donec sed nisl vel turpis bibendum eleifend ac a velit. Aenean vitae massa libero. Aliquam quam massa, consectetur in faucibus eu, pharetra a est. Praesent volutpat accumsan sagittis. Pellentesque eu elementum urna, id malesuada lectus. Nam tempus diam non augue faucibus, et tempus magna pellentesque. Vestibulum nulla nunc, mattis id rhoncus quis, congue at ex. In non felis at nulla vulputate efficitur.</p>


            <form method="POST" action="#">
                <input type="submit" class="btn btn-primary mt-4" value="Pobierz eksport bazy">
            </form>
        </div>
    </div>

</body>

</html>