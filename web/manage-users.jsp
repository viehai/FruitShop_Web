<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Users"%>
<%@page import="java.util.List"%>
<%@page import="dal.UsersDao"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">
        <meta http-equiv="X-UA-Compatible" content="IE=edge"><!--  -->
        <link href="https://fonts.cdnfonts.com/css/winky-sans" rel="stylesheet">

        <style>
            /* Import Google Font */
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');


            body {
                font-family: 'Winky Sans', sans-serif;
                background-color: #f5f7fa;
                color: #333;
            }
            .users-table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                border-radius: 10px;
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
            }
            .users-table th, .users-table td {
                padding: 14px 20px;
                text-align: center;
            }
            .users-table th {
                background-color: #f8f8f8;
                font-weight: bold;
            }
            .users-table tbody tr:hover {
                background-color: #f9f9f9;
                transform: scale(1.02);
                transition: 0.3s;
            }
            .btn-action {
                padding: 7px 12px;
                border-radius: 5px;
                font-size: 14px;
                font-weight: 500;
                text-decoration: none;
                display: inline-block;
                transition: all 0.3s;
            }
            .btn-edit {
                background-color: #FCE0C5;
                color: #F28123;
            }
            .btn-delete {
                background-color: #F8C8C8;
                color: #dc3545;
            }
            .btn-reset {
                background-color: #B3E5FC;
                color: #17a2b8;
            }
            .user-role {
                padding: 5px 10px;
                border-radius: 5px;
                font-size: 13px;
                font-weight: bold;
                display: inline-block;
            }
            .role-admin {
                background-color: #F8C8C8;
                color: #dc3545;
            }
            .role-customer {
                background-color: #D0F0C0;
                color: #28a745;
            }
        </style> 
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                let rows = document.querySelectorAll(".users-table tbody tr");
                rows.forEach(row => {
                    row.addEventListener("mouseenter", () => {
                        row.style.boxShadow = "0px 5px 15px rgba(0, 0, 0, 0.1)";
                        row.style.transform = "scale(1.02)";
                    });

                    row.addEventListener("mouseleave", () => {
                        row.style.boxShadow = "none";
                        row.style.transform = "scale(1)";
                    });
                });
            });
        </script>

    </head>
    <body>
        <%
            // Check if user is logged in and is admin
            Users user = (Users) session.getAttribute("dataUser");
            if (user == null || user.getRole() != 1) {
                response.sendRedirect("home.jsp");
                return;
            }
            
            // Get all users from database
            UsersDao usersDao = new UsersDao();
            List<Users> usersList = usersDao.readUsers();
            
            // Get success/error messages if any
            String successMessage = (String) session.getAttribute("SUCCESS_MESSAGE");
            String errorMessage = (String) session.getAttribute("ERROR_MESSAGE");
            
            // Clear the session messages after displaying
            if (successMessage != null || errorMessage != null) {
                session.removeAttribute("SUCCESS_MESSAGE");
                session.removeAttribute("ERROR_MESSAGE");
            }
            
            // Search functionality
            String searchQuery = request.getParameter("search");
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                // Simple filter for demonstration - in real app use a specific DAO method for search
                List<Users> filteredList = new java.util.ArrayList<>();
                for (Users u : usersList) {
                    if (u.getUsername().toLowerCase().contains(searchQuery.toLowerCase()) || 
                        (u.getName() != null && u.getName().toLowerCase().contains(searchQuery.toLowerCase())) ||
                        (u.getEmail() != null && u.getEmail().toLowerCase().contains(searchQuery.toLowerCase()))) {
                        filteredList.add(u);
                    }
                }
                usersList = filteredList;
            }
        %>






        <!-- breadcrumb-section -->
        <div class="breadcrumb-section breadcrumb-bg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 offset-lg-2 text-center">
                        <div class="breadcrumb-text">

                            <h1>Manage Users</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end breadcrumb section -->

        <!-- users management section -->
        <div class="mt-150 mb-150">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title text-center">


                        </div>

                        <% if (successMessage != null) { %>
                        <div class="alert alert-success">
                            <%= successMessage %>
                        </div>
                        <% } %>

                        <% if (errorMessage != null) { %>
                        <div class="alert alert-danger">
                            <%= errorMessage %>
                        </div>
                        <% } %>

                        <!-- Search bar -->
                        <div class="user-search">
                            <form action="manage-users.jsp" method="get">
                                <input type="text" name="search" placeholder="Search by username, name or email" value="<%= searchQuery != null ? searchQuery : "" %>">
                                <button type="submit">Search</button>
                                <% if (searchQuery != null && !searchQuery.trim().isEmpty()) { %>
                                <a href="manage-users.jsp" class="ml-2">Clear</a>
                                <% } %>
                            </form>
                        </div>

                        <!-- Users table -->
                        <table class="users-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Username</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Role</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (usersList.isEmpty()) { %>
                                <tr>
                                    <td colspan="7" class="text-center">No users found</td>
                                </tr>
                                <% } else { %>
                                <% for (Users u : usersList) { %>
                                <tr>
                                    <td><%= u.getId() %></td>
                                    <td><%= u.getUsername() %></td>
                                    <td><%= u.getName() != null ? u.getName() : "" %></td>
                                    <td><%= u.getEmail() != null ? u.getEmail() : "" %></td>
                                    <td><%= u.getPhone() != null ? u.getPhone() : "" %></td>
                                    <td>
                                        <span class="user-role <%= u.getRole() == 1 ? "role-admin" : "role-customer" %>">
                                            <%= u.getRole() == 1 ? "Admin" : "Customer" %>
                                        </span>
                                    </td>
                                    <td>
                                       <a href="#" class="btn-action btn-edit" onclick="loadPage('admin-edit-user.jsp?id=<%= u.getId() %>'); return false;">Edit</a>

                                        <% if (u.getId() != user.getId()) { // Prevent deleting current admin %>
                                        <a href="manage-users?action=delete&id=<%= u.getId() %>" class="btn-action btn-delete" onclick="return confirm('Are you sure you want to delete this user?')">Delete</a>
                                        <% } %>
                                    </td>
                                </tr>
                                <% } %>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- end users management section -->




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