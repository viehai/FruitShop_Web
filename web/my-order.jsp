<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="dal.OrderDao"%>
<%@page import="model.Orders"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="model.Users"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <style>
        .header {
            background-color: #000; /* Nền đen */
            color: #ff9900; /* Chữ cam */
            padding: 20px;
            text-align: center;
            font-size: 28px;
            font-weight: bold;
        }
        .table thead {
            background-color: #ff9900; /* Màu cam */
            color: white;
        }
        .table-hover tbody tr:hover {
            background-color: #f8d7a9; /* Màu cam nhạt khi hover */
        }
        .btn-custom {
            background-color: #ff9900;
            color: white;
        }
        .btn-custom:hover {
            background-color: #e67e00;
        }
    </style>
</head>
<body class="bg-light">

    <!-- Header -->
    <div class="header">My Orders</div>

    <div class="container mt-4">
        <!-- Display messages -->
        <% if (request.getSession().getAttribute("SUCCESS_MESSAGE") != null) { %>
        <div class="alert alert-success">
            <%= request.getSession().getAttribute("SUCCESS_MESSAGE") %>
            <% request.getSession().removeAttribute("SUCCESS_MESSAGE"); %>
        </div>
        <% } %>
        
        <% if (request.getSession().getAttribute("ERROR_MESSAGE") != null) { %>
        <div class="alert alert-danger">
            <%= request.getSession().getAttribute("ERROR_MESSAGE") %>
            <% request.getSession().removeAttribute("ERROR_MESSAGE"); %>
        </div>
        <% } %>
        
        <div class="table-responsive">
            <table class="table table-bordered table-hover text-center">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Subtotal</th>
                        <th>Shipping</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        HttpSession userSession = request.getSession();
                        Users user = (Users) userSession.getAttribute("dataUser");
                        if (user != null) {
                            OrderDao orderDAO = new OrderDao();
                            List<Orders> orders = orderDAO.getOrdersByUserId(user.getId());
                            for (Orders order : orders) {
                    %>
                    <tr>
                        <td><%= order.getId() %></td>
                        <td>$<%= order.getSubtotal() %></td>
                        <td>$<%= order.getShipping() %></td>
                        <td>$<%= order.getTotal() %></td>
                        <td><%= order.getStatus() %></td>
                        <td>
                            <a href="order-details_1.jsp?orderId=<%= order.getId() %>" class="btn btn-custom btn-sm">Order Details</a>
                            <% 
                                String orderStatus = order.getStatus();
                                // Add debugging comment
                                boolean isPending = orderStatus != null && 
                                   (orderStatus.contains("chờ") || 
                                    orderStatus.contains("duyệt") || 
                                    orderStatus.contains("giao") ||
                                    orderStatus.trim().equals("Đang chờ duyệt") || 
                                    orderStatus.trim().equals("Đang giao hàng"));
                                
                                // Show cancel button for any pending or shipping order
                                if (!"Đã hủy".equals(orderStatus) && !"Hoàn thành".equals(orderStatus)) { 
                            %>
                            <form action="cancel-order" method="POST" style="display:inline; margin-top:5px;" onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?');">
                                <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                <button type="submit" class="btn btn-danger btn-sm">Hủy đơn hàng</button>
                            </form>
                            <% } %>
                        </td>
                    </tr>
                    <% 
                            }
                        } else { 
                    %>
                    <tr>
                        <td colspan="6" class="text-center">Please <a href="login.jsp">login</a> to view your orders.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Back to Home -->
        <div class="text-center mt-4">
            <a href="home.jsp" class="btn btn-secondary">Back to Home</a>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
