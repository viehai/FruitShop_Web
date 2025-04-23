<%-- 
    Document   : edit-product
    Created on : Mar 17, 2025, 3:22:07 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Products, dal.ProductsDao" %>
<!DOCTYPE html>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ProductsDao productsDao = new ProductsDao();
    Products product = productsDao.getProductByID(id);
    if (product == null) {
        response.sendRedirect("error.jsp"); // Chuyển hướng nếu không tìm thấy sản phẩm
        return;
    }
%>

<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .header {
            background-color: black;
            color: orange;
            padding: 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="header">Chỉnh sửa sản phẩm</div>
    <div class="container mt-5">
        <div class="card shadow p-4">
            <h2 class="text-center mb-4">Chỉnh sửa sản phẩm</h2>
            <form action="products" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="id" value="<%= product.getId() %>">
                
                <div class="mb-3">
                    <label class="form-label">Tên sản phẩm:</label>
                    <input type="text" name="name" class="form-control" value="<%= product.getName() %>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Giá:</label>
                    <input type="number" name="price" step="1000" class="form-control" value="<%= product.getPrice() %>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Số lượng:</label>
                    <input type="number" name="quantity" class="form-control" value="<%= product.getProducts_quantity() %>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Hình ảnh:</label>
                    <input type="file" name="image" class="form-control">
                </div>
                
                <button type="submit" class="btn btn-primary w-100" style="background-color: orange">Update Product</button>
            </form>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

