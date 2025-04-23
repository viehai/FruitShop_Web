<%@ page import="java.util.List, model.Products, dal.ProductsDao" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products</title>
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
            background-color: #343a40; /* Màu xám đậm */
            color: white;
        }
    </style>
    <script>
        function confirmDelete() {
            return confirm('Are you sure you want to delete?');
        }
    </script>
</head>
<body class="bg-light">

    <div class="header">Product Management</div>

    <div class="container mt-5">
        <div class="text-end mb-3">
            <a href="add-product.jsp" class="btn btn-success">+ Add New Product</a>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-hover text-center">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Image</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ProductsDao productDAO = new ProductsDao();
                        List<Products> products = productDAO.getAllProducts();
                        for (Products product : products) {
                    %>
                    <tr>
                        <td><%= product.getId() %></td>
                        <td><%= product.getName() %></td>
                        <td>$<%= product.getPrice() %></td>
                        <td><%= product.getProducts_quantity() %></td>
                        <td>
                            <img src="assets/img/products/<%= product.getImage() %>" width="50" class="img-thumbnail">
                        </td>
                        <td>
                            <a href="edit-product.jsp?id=<%= product.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                            <a href="delete-product.jsp?id=<%= product.getId() %>" onclick="return confirmDelete();" class="btn btn-danger btn-sm">Delete</a>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
