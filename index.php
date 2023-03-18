<!DOCTYPE html>
<html lang="en">

<head>
    <title>College Database Management System</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">

    <script src="js/libs/jquery.min.js" defer></script>
    <script src="js/libs/popper.js" defer></script>
    <script src="js/libs/bootstrap.min.js" defer></script>
    <script src="js/navbar.js" defer></script>

    <link rel="shortcut icon" href="img/icon.ico">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/navbar.css">
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
                    <a href="#"><span class="fa fa-home mr-3"></span> Homepage</a>
                </li>
                <li>
                    <a href="#"><span class="fa fa-user mr-3"></span> Dashboard</a>
                </li>
                <li>
                    <a href="#"><span class="fa fa-sticky-note mr-3"></span> Friends</a>
                </li>
                <li>
                    <a href="#"><span class="fa fa-sticky-note mr-3"></span> Subcription</a>
                </li>
                <li>
                    <a href="#"><span class="fa fa-paper-plane mr-3"></span> Settings</a>
                </li>
                <li>
                    <a href="#"><span class="fa fa-paper-plane mr-3"></span> Information</a>
                </li>
            </ul>

        </nav>


        <div id="content" class="p-4 p-md-5 pt-5">
            <?php 
                echo "Hello!";
            ?>
        </div>
    </div>

</body>

</html>