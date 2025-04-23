<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>

        <!-- Google Font: Poppins -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- FontAwesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <style>
            * {
                font-family: 'Poppins', sans-serif;
                transition: all 0.3s ease-in-out;
            }

            body {
                background: #f4f7fc;
            }

            .sidebar {
                height: 100vh;
                width: 250px;
                background: linear-gradient(135deg, #34495e, #2c3e50);
                color: white;
                padding: 20px;
                position: fixed;
                transition: 0.3s;
                border-radius: 10px;
            }

            .sidebar h3 {
                text-align: center;
                margin-bottom: 20px;
                font-weight: 600;
            }

            .sidebar a {
                color: white;
                text-decoration: none;
                display: flex;
                align-items: center;
                padding: 12px;
                border-radius: 8px;
                margin-bottom: 8px;
                transition: background 0.3s;
                font-weight: 400;
                cursor: pointer;
            }

            .sidebar a i {
                margin-right: 10px;
            }

            .sidebar a:hover {
                background: rgba(255, 255, 255, 0.2);
            }

            .content {
                margin-left: 270px;
                padding: 30px;
            }

            .card {
                border-radius: 12px;
                border: none;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease-in-out;
            }

            .card:hover {
                transform: translateY(-5px);
            }

            .card-body h5 {
                font-weight: 600;
            }
        </style>
    </head>
    <body>


        <div class="d-flex">
            <!-- Sidebar -->
            <div class="sidebar">
                <h3>Admin Panel</h3>
                <a href="#" onclick="loadPage('dashboard')"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                <a href="#" onclick="loadPage('manage-products.jsp')"><i class="fas fa-box"></i> Manage Products</a>
                <a href="#" onclick="loadPage('manage-orders.jsp')"><i class="fas fa-shopping-cart"></i> Manage Orders</a>
                <a href="#" onclick="loadPage('manage-users.jsp')"><i class="fas fa-users"></i> Manage Users</a>



                <a href="edit-profile.jsp"><i class="fas fa-chart-bar"></i> Edit Profile</a>
                
                
                <a href="#"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>

            <!-- Main Content -->
            <div class="content flex-grow-1">
                <h2 class="mb-4">Admin Dashboard</h2>

                <div id="main-content">
                    <p>Welcome to the Admin Dashboard. Click a menu item to load content.</p>
                </div>
            </div>
        </div>


        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                    function loadPage(page) {
                        $("#main-content").html('<p>Loading...</p>'); // Hi?n loading khi ?ang t?i
                        $.ajax({
                            url: page,
                            type: "GET",
                            success: function (response) {
                                $("#main-content").html(response); // Hi?n th? n?i dung trang ???c load
                            },
                            error: function () {
                                $("#main-content").html('<p>Error loading page.</p>');
                            }
                        });
                    }
        </script>


    </body>
</html>
