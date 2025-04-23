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
import java.util.List;
import model.Orders;
import model.Users;

/**
 *
 * @author pc
 */
@WebServlet(name="UpdateOrderStatusController", urlPatterns={"/update-order-status"})
public class UpdateOrderStatusController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet UpdateOrderStatusController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateOrderStatusController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("dataUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");

            OrderDao orderDAO = new OrderDao();
            boolean isUpdated = orderDAO.updateOrderStatus(orderId, status);

            if (isUpdated) {
                // Add success message
                session.setAttribute("STATUS_SUCCESS", "Đơn hàng #" + orderId + " đã được cập nhật thành " + status);
                
                // Cập nhật lại danh sách đơn hàng trong session
                List<Orders> updatedOrders = orderDAO.getOrdersByUserId(user.getId());
                session.setAttribute("userOrders", updatedOrders);
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // Kiểm tra quyền của user để điều hướng về trang đúng
        String redirectPage = (user.getRole() == 1) ? "manage-orders.jsp" : "my-order.jsp";
        response.sendRedirect(redirectPage);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
