/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.OrderDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Orders;
import model.Users;

/**
 *
 * @author pc
 */
public class CancelOrderController extends HttpServlet {

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
        
        try {
            String orderIdStr = request.getParameter("orderId");
            
            if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
                session.setAttribute("ERROR_MESSAGE", "Mã đơn hàng không hợp lệ");
                response.sendRedirect("my-order.jsp");
                return;
            }
            
            int orderId = Integer.parseInt(orderIdStr);
            OrderDao orderDao = new OrderDao();
            
            // Delete the order instead of updating its status
            boolean success = orderDao.deleteOrder(orderId);
            
            if (success) {
                session.setAttribute("SUCCESS_MESSAGE", "Đơn hàng đã được hủy thành công");
            } else {
                session.setAttribute("ERROR_MESSAGE", "Không thể hủy đơn hàng");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("ERROR_MESSAGE", "Đã xảy ra lỗi khi hủy đơn hàng: " + e.getMessage());
        }
        
        response.sendRedirect("my-order.jsp");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
} 