<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Users"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">

        <!-- title -->
        <title>Edit Profile</title>

    

        <style>
            .profile-form {
                max-width: 600px;
                margin: 0 auto;
                padding: 20px;
                background-color: #f5f5f5;
                border-radius: 10px;
            }
            
            .profile-form label {
                font-weight: bold;
                margin-top: 15px;
            }
            
            .profile-form .form-control {
                margin-bottom: 15px;
            }
            
            .profile-form .btn-primary {
                background-color: #F28123;
                border-color: #F28123;
                margin-top: 20px;
                padding: 10px 20px;
            }
            
            .profile-form .btn-primary:hover {
                background-color: #e67612;
                border-color: #e67612;
            }
            
            .profile-form .alert {
                margin-top: 20px;
            }
            
            .section-title {
                margin-bottom: 40px;
            }
            
            .section-title h3 {
                font-size: 40px;
                position: relative;
                padding-bottom: 15px;
                margin-bottom: 20px;
            }
            
            .section-title h3:after {
                position: absolute;
                content: '';
                left: 0px;
                right: 0px;
                bottom: 0px;
                width: 50px;
                height: 2px;
                background-color: #F28123;
                margin: 0 auto;
            }
        </style>
    </head>
    <body>
        <%
            Users user = (Users) session.getAttribute("dataUser");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            String successMessage = (String) request.getAttribute("successMessage");
            String errorMessage = (String) request.getAttribute("errorMessage");
        %>

      

      

        <!-- profile edit section -->
        <div class="mt-150 mb-150">
            <div class="container">
                <div class="row">
                    <div class="col-lg-10 offset-lg-1">
                        <div class="section-title text-center">
                            <h3>Edit Your Profile</h3>
                            <p>Update your personal information below</p>
                        </div>
                        
                        <% if (successMessage != null) { %>
                        <div class="alert alert-success text-center" role="alert">
                            <%= successMessage %>
                        </div>
                        <% } %>
                        
                        <% if (errorMessage != null) { %>
                        <div class="alert alert-danger text-center" role="alert">
                            <%= errorMessage %>
                        </div>
                        <% } %>
                        
                        <div class="profile-form">
                            <form action="UpdateProfileController" method="post">
                                <input type="hidden" name="id" value="<%= user.getId() %>">
                                <input type="hidden" name="username" value="<%= user.getUsername() %>">
                                <input type="hidden" name="role" value="<%= user.getRole() %>">
                                
                                <div class="form-group">
                                    <label for="name">Full Name</label>
                                    <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() %>" required>
                                </div>
                                
                                <div class="form-group">
                                    <label for="email">Email Address</label>
                                    <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() != null ? user.getEmail() : "" %>">
                                </div>
                                
                                <div class="form-group">
                                    <label for="phone">Phone Number</label>
                                    <input type="text" class="form-control" id="phone" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>">
                                </div>
                                
                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <textarea class="form-control" id="address" name="address" rows="3"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
                                </div>
                                
                                <div class="form-group">
                                    <label for="currentPassword">Current Password (required to confirm changes)</label>
                                    <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                </div>
                                
                                <div class="form-group">
                                    <label for="newPassword">New Password (leave blank to keep current password)</label>
                                    <input type="password" class="form-control" id="newPassword" name="newPassword">
                                </div>
                                
                                <div class="form-group">
                                    <label for="confirmPassword">Confirm New Password</label>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                                </div>
                                
                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary">Update Profile</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end profile edit section -->

        
        <!-- jquery -->
        <script src="assets/js/jquery-1.11.3.min.js"></script>
        <!-- bootstrap -->
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
        <!-- count down -->
        <script src="assets/js/jquery.countdown.js"></script>
        <!-- isotope -->
        <script src="assets/js/jquery.isotope-3.0.6.min.js"></script>
        <!-- waypoints -->
        <script src="assets/js/waypoints.js"></script>
        <!-- owl carousel -->
        <script src="assets/js/owl.carousel.min.js"></script>
        <!-- magnific popup -->
        <script src="assets/js/jquery.magnific-popup.min.js"></script>
        <!-- mean menu -->
        <script src="assets/js/jquery.meanmenu.min.js"></script>
        <!-- sticker js -->
        <script src="assets/js/sticker.js"></script>
        <!-- main js -->
        <script src="assets/js/main.js"></script>
    </body>
</html> 