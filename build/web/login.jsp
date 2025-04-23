 <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
      

        <title> Login </title>
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

            .login-container {
                background: white;
                padding: 50px;
                border-radius: 12px;
                box-shadow: 0 0 25px rgba(0, 0, 0, 0.4);
                text-align: center;
                width: 450px;
                z-index: 2;
                position: relative;
            }

            .login-container h3 {
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

            .register-link, .forgot-password-link {
                color: #ff6600;
                font-weight: bold;
                text-decoration: none;
                margin: 0 10px;
            }

            .register-link:hover, .forgot-password-link:hover {
                text-decoration: underline;
            }

            #forgotPasswordModal .modal-content {
                border-radius: 12px;
            }

            #forgotPasswordModal .modal-header {
                border-bottom: none;
                padding-bottom: 0;
            }

            #forgotPasswordModal .modal-body {
                padding: 20px 40px;
            }

            #forgotPasswordModal .modal-footer {
                border-top: none;
                padding-top: 0;
            }

            .alert {
                margin-bottom: 15px;
            }
        </style>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        
        <div class="overlay"></div>
        <div class="login-container">
            
            <h3>Login</h3>
            <form action="login" method="post">
                <div class="mb-4">
                    <input type="text" class="form-control" name="username" placeholder="Username" required>
                </div>
                <div class="mb-4">
                    <input type="password" class="form-control" name="password" placeholder="Password" required>
                </div>
                <div class="mb-4 form-check text-start">
                    <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                    <label class="form-check-label" for="rememberMe">Remember me</label>
                </div>
                <% if(request.getAttribute("msg") != null) { %>
                <div class="alert alert-danger">
                    <%= request.getAttribute("msg") %>
                </div>
                <% } %>
                <button type="submit" class="btn btn-orange w-100">Login</button>
            </form>
            <div class="mt-4">
                <a href="register.jsp" class="register-link">Register Now</a>
                <a href="#" class="forgot-password-link" data-bs-toggle="modal" data-bs-target="#forgotPasswordModal">Forgot Password?</a>
            </div>
        </div>

        <!-- Forgot Password Modal -->
        <div class="modal fade" id="forgotPasswordModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Forgot Password</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="forgotPasswordForm" action="forgot-password" method="post">
                            <div class="mb-3">
                                <label for="email" class="form-label">Enter your registered email address</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <div id="emailError" class="alert alert-danger d-none">
                                Email not found in our records.
                            </div>
                            <div id="userConfirmation" class="alert alert-info d-none">
                                <!-- Will be filled dynamically -->
                            </div>
                            <div class="text-center">
                                <button type="submit" class="btn btn-orange">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.getElementById('forgotPasswordForm').addEventListener('submit', function(e) {
                e.preventDefault();
                const email = document.getElementById('email').value;
                
                // Send email to server for verification
                fetch('forgot-password?action=verify&email=' + encodeURIComponent(email))
                    .then(response => response.json())
                    .then(data => {
                        console.log('Server response:', data);
                        console.log('Name value:', data.name);
                        console.log('Type of name:', typeof data.name);
                        
                        const userConfirmation = document.getElementById('userConfirmation');
                        const emailError = document.getElementById('emailError');
                        
                        if (data.found) {
                            emailError.classList.add('d-none');
                            userConfirmation.classList.remove('d-none');
                            
                            // Tạo các phần tử trực tiếp thay vì dùng template literal
                            const container = document.createElement('div');
                            container.style.textAlign = 'center';
                            
                            const question = document.createElement('p');
                            question.textContent = 'Đây có phải tài khoản của bạn không?';
                            container.appendChild(question);
                            
                            const nameText = document.createElement('p');
                            nameText.style.fontWeight = 'bold';
                            nameText.style.fontSize = '18px';
                            nameText.style.margin = '10px 0';
                            nameText.textContent = 'Tên: ' + data.name;
                            container.appendChild(nameText);
                            
                            const usernameText = document.createElement('p');
                            usernameText.style.fontSize = '14px';
                            usernameText.style.color = '#666';
                            usernameText.textContent = 'Username: ' + data.username;
                            container.appendChild(usernameText);
                            
                            const buttonContainer = document.createElement('div');
                            buttonContainer.style.marginTop = '15px';
                            
                            const noButton = document.createElement('button');
                            noButton.type = 'button';
                            noButton.className = 'btn btn-secondary me-2';
                            noButton.textContent = 'Không';
                            noButton.setAttribute('data-bs-dismiss', 'modal');
                            
                            const yesButton = document.createElement('button');
                            yesButton.type = 'button';
                            yesButton.className = 'btn btn-orange';
                            yesButton.textContent = 'Đúng';
                            yesButton.onclick = () => proceedReset(email);
                            
                            buttonContainer.appendChild(noButton);
                            buttonContainer.appendChild(yesButton);
                            container.appendChild(buttonContainer);
                            
                            // Xóa nội dung cũ và thêm nội dung mới
                            userConfirmation.innerHTML = '';
                            userConfirmation.appendChild(container);
                        } else {
                            emailError.classList.remove('d-none');
                            emailError.textContent = 'Email không tồn tại trong hệ thống.';
                            userConfirmation.classList.add('d-none');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        document.getElementById('emailError').classList.remove('d-none');
                        document.getElementById('userConfirmation').classList.add('d-none');
                    });
            });

            function proceedReset(email) {
                // Submit form to server
                const form = document.getElementById('forgotPasswordForm');
                form.submit();
            }
        </script>
    </body>
</html>
