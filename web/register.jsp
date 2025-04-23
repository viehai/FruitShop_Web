<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <style>
        body {
            background: url('assets/img/hero-bg.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            position: relative;
        }

        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }

        .register-container {
            background: white;
            padding: 50px;
            border-radius: 12px;
            box-shadow: 0 0 25px rgba(0, 0, 0, 0.4);
            text-align: center;
            width: 450px;
            z-index: 2;
            position: relative;
        }

        .register-container h3 {
            font-weight: bold;
            color: #ff6600;
            margin-bottom: 25px;
        }

        .btn-orange {
            background-color: #ff6600;
            color: white;
            font-weight: bold;
            border: none;
            padding: 12px;
            font-size: 16px;
            width: 100%;
        }

        .btn-orange:hover {
            background-color: #e65c00;
        }

        .register-link {
            color: #ff6600;
            font-weight: bold;
            text-decoration: none;
        }

        .register-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="overlay"></div>
    <div class="register-container">
        <h3>REGISTER</h3>
        <form action="register" method="post">
            <div class="mb-4">
                <input type="text" class="form-control" name="username" placeholder="Username" required>
            </div>
            <div class="mb-4">
                <input type="email" class="form-control" name="email" placeholder="Email" required>
            </div>
            <div class="mb-4">
                <input type="password" class="form-control" name="password" placeholder="Password" required>
            </div>
            <div class="mb-4">
                <input type="password" class="form-control" name="cpassword" placeholder="Confirm Password" required>
            </div>
            <button type="submit" class="btn btn-orange">Register</button>
        </form>
        <div class="mt-4">
            <p>Already have an account? <a href="login.jsp" class="register-link">Login now</a></p>
        </div>
    </div>
</body>
</html>
