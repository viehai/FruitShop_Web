<%@ page import="dal.ProductsDao" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Lấy product ID từ request
    String idParam = request.getParameter("id");

    if (idParam != null) {
        try {
            int productId = Integer.parseInt(idParam);
            ProductsDao productDAO = new ProductsDao();

            // Thực hiện xóa sản phẩm
            boolean success = productDAO.deleteProduct(productId);

            if (success) {
                // Nếu xóa thành công, chuyển hướng về trang quản lý sản phẩm
                response.sendRedirect("manage-products.jsp?deleteSuccess=true");
            } else {
                // Nếu xóa thất bại, thông báo lỗi
%>
                <script>
                    alert("Xóa sản phẩm thất bại! Hãy thử lại.");
                    window.location.href = "manage-products.jsp";
                </script>
<%
            }
        } catch (NumberFormatException e) {
            // Trường hợp ID không hợp lệ
%>
            <script>
                alert("ID sản phẩm không hợp lệ!");
                window.location.href = "manage-products.jsp";
            </script>
<%
        }
    } else {
%>
        <script>
            alert("Không tìm thấy ID sản phẩm!");
            window.location.href = "manage-products.jsp";
        </script>
<%
    }
%>