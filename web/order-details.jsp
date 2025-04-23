<%@ page import="java.util.List" %>
<%@ page import="model.Orders" %>
<%@ page import="model.Users" %>
<%@ page import="model.OrderDetail" %>
<%@ page import="model.Products" %>
<%@ page import="dal.OrderDao" %>
<%@ page import="dal.UsersDao" %>
<%@ page import="dal.OrderDetailDao" %>
<%@ page import="dal.ProductsDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    int orderId = -1;
    try {
        orderId = Integer.parseInt(request.getParameter("orderId"));
    } catch (NumberFormatException e) {
        out.println("<p style='color:red;'>Lỗi: orderId không hợp lệ.</p>");
        return;
    }

    OrderDao orderDAO = new OrderDao();
    UsersDao userDAO = new UsersDao();
    ProductsDao productDAO = new ProductsDao();
    OrderDetailDao orderDetailDAO = new OrderDetailDao();

    Orders order = orderDAO.getOrderById(orderId);
    if (order == null) {
        out.println("<p style='color:red;'>Không tìm thấy đơn hàng với ID: " + orderId + "</p>");
        return;
    }

    Users user = userDAO.getUserById(order.getUserId());
    if (user == null) {
        out.println("<p style='color:red;'>Không tìm thấy người dùng với ID: " + order.getUserId() + "</p>");
        return;
    }
    List<OrderDetail> orderDetails = orderDetailDAO.getOrderDetailsByOrderId(orderId);
%>

<html>
    <head>
        <title>Order Details</title>
        <!-- Add CSS Styles for better UI -->
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                margin: 0;
                padding: 0;
                color: #333;
            }

            h2, h3 {
                color: #FFA500; /* Light Orange Color */
            }

            .container {
                width: 80%;
                margin: 20px auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }

            .logo {
                text-align: center;
                margin-bottom: 20px;
            }

            img {
                width: 150px;
                height: auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 10px;
                text-align: left;
                border: 1px solid #ddd;
            }

            th {
                background-color: #FFA500; /* Light Orange Color */
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            .total {
                font-size: 18px;
                font-weight: bold;
                margin-top: 20px;
            }

            .btn-back {
                display: inline-block;
                padding: 10px 20px;
                background-color: #FFA500; /* Light Orange Color */
                color: white;
                text-decoration: none;
                border-radius: 5px;
                margin-top: 20px;
            }

            .btn-back:hover {
                background-color: #FF8C00; /* Slightly darker orange */
            }

            .order-details, .user-info {
                margin-bottom: 30px;
            }

            .user-info p, .order-details p {
                font-size: 16px;
            }

            .product-image {
                width: 100px;
                height: auto;
                margin-right: 10px;
            }
        </style>
    </head>
    <body>
        <!-- Logo added here -->
        <div class="logo">
            <img src="assets/img/logo.png" alt="  " />
        </div>

        <div class="container">
            <h2>Order Details #<%= orderId %></h2>

            <div class="user-info">
                <h3>Orderer Information</h3>
                <p><b>Name:</b> <%= user.getName() %></p>
                <p><b>Email:</b> <%= user.getEmail() %></p>
                <p><b>Address:</b> <%= user.getAddress() %></p>
                <p><b>Phone number:</b> <%= user.getPhone() %></p>
            </div>

            <div class="order-details">
                <h3>Products Ordered</h3>
                <table>
                    <tr>
                        <th>Product</th>
                        <th>Image</th>
                        <th>Status</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Total Price</th>
                    </tr>
                    <%
    double shipping = 50.0;
    for (OrderDetail detail : orderDetails) { 
        Products product = productDAO.getProductByID(detail.getProductId()); 
       
                    %>

                    <tr>
                        <td><%= product.getName() %></td>
                        <td><img src="assets/img/products/<%= product.getImage() %>" class="product-image" alt="<%= product.getName() %>" /></td> <!-- Assuming product image name is stored in 'getImage()' -->
                        <td><%= order.getStatus() %></td>
                        <td><%= detail.getCartQuantity() %></td>
                        <td>$<%= detail.getPrice() %></td>
                        <td>$<%= detail.getCartQuantity() * detail.getPrice() %></td>
                    </tr>
                    <% } %>
                </table>
                <p>Shipping: $<%= shipping %></p>
                <p class="total"><b>Total:</b> $<%= order.getTotal() %></p>
            </div>

            <a href="manage-orders.jsp" class="btn-back">Back to manage order</a>
        </div>
    </body>
</html>
