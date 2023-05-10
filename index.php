<?php
session_start();
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
                <?php
                if (isset($_SESSION["logged"])) {
                    if ($_SESSION["logged"]) echo "<h1 class='h1 mb-5'>Witaj, ". $_SESSION["login"]. "!</h1>";
                }
                ?>
                <h3>Lorem ipsum</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam facilisis vulputate dui sed dapibus. Phasellus sed facilisis tellus. Curabitur ac libero consequat est sodales elementum. Nam accumsan erat eu sem ultricies ultrices. Vestibulum sed massa pharetra, maximus metus sit amet, rhoncus justo. Phasellus viverra lacinia felis. Morbi vel eros erat. Donec sed nisl vel turpis bibendum eleifend ac a velit. Aenean vitae massa libero. Aliquam quam massa, consectetur in faucibus eu, pharetra a est. Praesent volutpat accumsan sagittis. Pellentesque eu elementum urna, id malesuada lectus. Nam tempus diam non augue faucibus, et tempus magna pellentesque. Vestibulum nulla nunc, mattis id rhoncus quis, congue at ex. In non felis at nulla vulputate efficitur.</p>

                <h3>Lorem ipsum</h3>
                <p>Vestibulum ac sapien dui. Mauris pharetra mauris vitae turpis eleifend, id faucibus leo ultrices. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Quisque rhoncus est non odio sollicitudin maximus. Mauris aliquet, nisl vitae blandit ornare, purus neque sollicitudin libero, non consequat diam metus ac ipsum. Aenean scelerisque lectus in nunc sodales, non consequat orci pulvinar. Suspendisse sit amet neque eu neque tristique ultrices a a odio. Integer varius, est non auctor semper, nunc mauris mattis tortor, in mollis magna ex id velit. Nullam feugiat quam mauris, viverra vulputate odio suscipit nec. In leo nisl, aliquet vel lorem suscipit, pharetra convallis magna. Nam iaculis leo sed turpis feugiat ornare. Pellentesque odio lacus, pellentesque ac pellentesque vel, commodo eu lectus. Mauris gravida, ipsum eget placerat blandit, quam turpis interdum enim, eget blandit nisi diam ut tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin a diam lorem.

                <p>Morbi eu ante sed tellus ultrices ullamcorper in vitae lectus. Aliquam pellentesque enim tellus, non aliquam augue faucibus eget. Etiam sollicitudin gravida libero. Sed efficitur nisl at nisi semper, interdum gravida lorem placerat. Morbi et quam sit amet nibh euismod semper. Ut vehicula leo turpis, id laoreet purus consequat vel. Duis ullamcorper congue luctus. Nulla facilisi. Aliquam commodo quam quam, non posuere neque rutrum id. Suspendisse faucibus, libero sed condimentum feugiat, dui nulla accumsan justo, in ullamcorper dolor ligula eu elit. Morbi pretium, nisi sit amet sagittis euismod, nunc mi dignissim magna, eget semper dolor est vitae ex. Aenean posuere lorem quis semper auctor. Praesent commodo fermentum gravida. Nullam sit amet venenatis tellus.</p>

                <h3>Lorem ipsum</h3>
                <p>Donec ut auctor tortor. Phasellus id accumsan nunc. Aliquam quis varius risus, eu volutpat nunc. Nullam posuere accumsan lacus vitae pretium. Curabitur fermentum eu felis id mattis. Fusce feugiat eros non facilisis posuere. Proin euismod tortor velit. Nunc dapibus posuere turpis et tincidunt. Cras id ultrices lacus. Vivamus vulputate urna non ultricies eleifend. Sed pretium urna ipsum, non finibus ligula sollicitudin quis. In hac habitasse platea dictumst. Morbi in sodales ligula.</p>
            </div>
        </div>

</body>

</html>