/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.OrderDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.Item;
import model.Orders;
import model.Users;

/**
 *
 * @author pc
 */
@WebServlet(name = "CheckOutController", urlPatterns = {"/checkout"})
public class CheckOutController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckOutController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckOutController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Kiểm tra đăng nhập
        Users user = (Users) session.getAttribute("SessionLogin");
        if (user == null) {
            response.sendRedirect("login.jsp"); // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
            return;
        }

        // Lấy giỏ hàng từ session
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart.jsp"); // Nếu giỏ hàng rỗng, quay về trang giỏ hàng
            return;
        }

        // Tính tổng tiền giỏ hàng
        double subtotal = 0;
        for (Item item : cart.getItems()) {
            subtotal += item.getQuantity() * item.getPrice();
        }
        double shippingFee = 50; // Phí vận chuyển cố định
        double total = subtotal + shippingFee;

        // Tạo đối tượng Order
        Orders order = new Orders();
        order.setUserId(user.getId());
        order.setSubtotal(subtotal);
        order.setShipping(shippingFee);
        order.setTotal(total);

        // Lưu đơn hàng vào database
        OrderDao orderDAO = new OrderDao();
        boolean success = orderDAO.saveOrder(order, cart.getItems());

        if (success) {
            session.removeAttribute("cart"); // Xóa giỏ hàng sau khi đặt hàng thành công
            session.setAttribute("orderSuccess", true); // Thêm biến thông báo
            response.sendRedirect("checkout.jsp"); // Load lại checkout.jsp
        } else {
            response.sendRedirect("checkout.jsp?error=checkout_failed");
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
