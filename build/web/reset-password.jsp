<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password</title>
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <style>
            body {
                background: url('assets/img/hero-bg.jpg') no-repeat center center fixed;
                background-size: cover;
                position: relative;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
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

            .reset-container {
                background: white;
                padding: 50px;
                border-radius: 12px;
                box-shadow: 0 0 25px rgba(0, 0, 0, 0.4);
                text-align: center;
                width: 450px;
                z-index: 2;
                position: relative;
            }

            .reset-container h3 {
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
            }

            .btn-orange:hover {
                background-color: #e65c00;
            }
        </style>
    </head>
    <body>
        <%
            // Check if reset_email exists in session
            String resetEmail = (String) session.getAttribute("reset_email");
            if (resetEmail == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        
        <div class="overlay"></div>
        <div class="reset-container">
            <h3>Reset Password</h3>
            <form action="reset-password" method="post" onsubmit="return validateForm()">
                <div class="mb-4">
                    <input type="password" class="form-control" name="newPassword" id="newPassword" 
                           placeholder="New Password" required>
                </div>
                <div class="mb-4">
                    <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" 
                           placeholder="Confirm Password" required>
                </div>
                
                <% if(request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>
                
                <div id="passwordError" class="alert alert-danger d-none">
                    Passwords do not match!
                </div>
                
                <button type="submit" class="btn btn-orange w-100">Reset Password</button>
                
                <div class="mt-3">
                    <a href="login.jsp" class="text-muted">Back to Login</a>
                </div>
            </form>
        </div>

        <script>
            function validateForm() {
                const newPassword = document.getElementById('newPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                const errorDiv = document.getElementById('passwordError');
                
                if (newPassword !== confirmPassword) {
                    errorDiv.classList.remove('d-none');
                    return false;
                }
                
                errorDiv.classList.add('d-none');
                return true;
            }
        </script>
    </body>
</html> 