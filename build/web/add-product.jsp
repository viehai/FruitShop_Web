<%-- 
    Document   : add-product
    Created on : Mar 17, 2025, 3:21:43 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .header {
            background-color: black;
            color: orange;
            padding: 30px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="header">Thêm sản phẩm</div>
    <div class="container mt-5">
        <div class="card shadow p-4">
            <h2 class="text-center mb-4"></h2>
            <form action="products" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="add">
                
                <div class="mb-3">
                    <label class="form-label">Tên sản phẩm:</label>
                    <input type="text" name="name" class="form-control" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Giá:</label>
                    <input type="number" name="price" step="0.01" class="form-control" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Số lượng:</label>
                    <input type="number" name="quantity" class="form-control" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Hình ảnh:</label>
                    <input type="file" name="image" class="form-control" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Loại sản phẩm:</label>
                    <input type="text" name="categoryType" class="form-control" required>
                </div>
                
                <button type="submit" class="btn btn-primary w-100" style="background-color: orange" >Add Product</button>
            </form>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
