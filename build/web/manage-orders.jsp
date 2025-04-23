<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, model.Users, model.Orders, dal.UsersDao, dal.OrderDao" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Orders</title>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

        <style>
            body {
                background-color: #f8f9fa;
            }
            .header {
                background-color: #000;
                color: #ff9900;
                padding: 15px;
                text-align: center;
                font-size: 24px;
                font-weight: bold;
            }
            .table thead tr {
                background-color: #343a40 !important;
                color: white;
                text-align: center;
            }
            .table tbody tr td {
                vertical-align: middle;
                text-align: center;
            }
        </style>

        <script>
            function confirmUpdate() {
                return confirm("Are you sure you want to update order status?");
            }

            function confirmDelete() {
                return confirm("Are you sure you want to delete this order?");
            }
        </script>
    </head>

    <body>

        <!-- Header -->
        <div class="header">Manage Orders</div>

        <div class="container mt-4">
            <!-- Success message -->
            <% if (request.getSession().getAttribute("STATUS_SUCCESS") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= request.getSession().getAttribute("STATUS_SUCCESS") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                <% request.getSession().removeAttribute("STATUS_SUCCESS"); %>
            </div>
            <% } %>
            
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>User</th>
                            <th>Shipping</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Action</th>
                            <th>Receive</th>
                            <th>Delete</th>
                            <th>Customer Bill</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%
                            OrderDao orderDAO = new OrderDao(); 
                            UsersDao userDAO = new UsersDao();  
                            List<Orders> orders = orderDAO.getAllOrders(); 

                            for (Orders order : orders) {
                                Users orderUser = userDAO.getUserById(order.getUserId()); 
                        %>
                        <tr>
                            <td><%= order.getId() %></td>
                            <td><%= (orderUser != null) ? orderUser.getUsername() : "Unknown User" %></td> 
                            <td>Standard</td> <!-- Có thể thay đổi nếu bạn có thông tin shipping -->
                            <td>$<%= order.getTotal() %></td>
                            <td><span class="badge <%= 
                                "Hoàn thành".equals(order.getStatus()) ? "bg-success" : 
                                "Đã hủy".equals(order.getStatus()) ? "bg-danger" : 
                                "bg-warning" %>">
                                    <%= order.getStatus() %>
                                </span></td>

                            <!-- Update Order Status -->
                            <td>
                                <form action="update-order-status" method="POST" onsubmit="return confirmUpdate();">
                                    <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                    <select name="status" class="form-select" <%= "Hoàn thành".equals(order.getStatus()) || "Đã hủy".equals(order.getStatus()) ? "disabled" : "" %>>
                                        <option value="Đang chờ duyệt" <%= "Đang chờ duyệt".equals(order.getStatus()) ? "selected" : "" %>>Đang chờ duyệt</option>
                                        <option value="Đang giao hàng" <%= "Đang giao hàng".equals(order.getStatus()) ? "selected" : "" %>>Đang giao hàng</option>
                                        <option value="Hoàn thành" <%= "Hoàn thành".equals(order.getStatus()) ? "selected" : "" %>>Hoàn thành</option>
                                    </select>
                                    <% if (!"Hoàn thành".equals(order.getStatus()) && !"Đã hủy".equals(order.getStatus())) { %>
                                    <button type="submit" class="btn btn-success btn-sm mt-1">Update</button>
                                    <% } %>
                                </form>
                            </td>

                            <!-- Receive Status -->
                            <td>
                                <% if ("Hoàn thành".equals(order.getStatus())) { %>
                                <span class="badge bg-success">Done</span>
                                <% } else if ("Đã hủy".equals(order.getStatus())) { %>
                                <span class="badge bg-danger">Cancelled</span>
                                <% } else { %>
                                <span class="badge bg-secondary">Pending</span>
                                <% } %>
                            </td>

                            <!-- Delete Order -->
                            <td>
                                <form action="delete-order" method="POST" onsubmit="return confirmDelete();">
                                    <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                    <button type="submit" class="btn btn-danger btn-sm" data-bs-toggle="tooltip" data-bs-placement="top" title="Delete this order">
                                        Delete
                                    </button>
                                </form>
                            </td>

                            <!-- View Bill -->
                            <td>
                                <a href="order-details.jsp?orderId=<%= order.getId() %>" class="btn btn-info btn-sm">View Bill</a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <div class="text-center mt-4">
                <a href="home.jsp" class="btn btn-secondary">Back to Home</a>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Kích hoạt tooltip Bootstrap
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl)
            })
            
            // Function to update form selection based on current status
            document.addEventListener('DOMContentLoaded', function() {
                // Get all status selects
                var statusSelects = document.querySelectorAll('select[name="status"]');
                
                // Add change event listener to each select
                statusSelects.forEach(function(select) {
                    select.addEventListener('change', function() {
                        // Store the selected value
                        localStorage.setItem('lastSelectedStatus', this.value);
                    });
                });
                
                // Check for success message to indicate a recent update
                if (document.querySelector('.alert-success')) {
                    // Try to apply the last selected status
                    var lastStatus = localStorage.getItem('lastSelectedStatus');
                    if (lastStatus) {
                        statusSelects.forEach(function(select) {
                            // Find the option with the saved value
                            for (var i = 0; i < select.options.length; i++) {
                                if (select.options[i].value === lastStatus) {
                                    // Force select this option
                                    select.options[i].selected = true;
                                    break;
                                }
                            }
                        });
                    }
                }
            });
        </script>

    </body>
</html>
