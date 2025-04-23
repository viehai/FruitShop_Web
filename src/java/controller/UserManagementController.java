/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UsersDao;
import java.io.IOException;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;

/**
 *
 * @author pc
 */
@WebServlet(name="UserManagementController", urlPatterns={"/UserManagementController"})
public class UserManagementController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("dataUser");
        
        // Check if user is logged in and is admin
        if (currentUser == null || currentUser.getRole() != 1) {
            response.sendRedirect("home.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        String userId = request.getParameter("id");
        
        if (action == null || userId == null) {
            response.sendRedirect("manage-users.jsp");
            return;
        }
        
        int id = Integer.parseInt(userId);
        UsersDao usersDao = new UsersDao();
        
        switch (action) {
            case "delete":
                // Prevent admin from deleting themselves
                if (id == currentUser.getId()) {
                    session.setAttribute("ERROR_MESSAGE", "You cannot delete your own account.");
                } else {
                    boolean deleteSuccess = usersDao.deleteUser(id);
                    if (deleteSuccess) {
                        session.setAttribute("SUCCESS_MESSAGE", "User successfully deleted.");
                    } else {
                        session.setAttribute("ERROR_MESSAGE", "Failed to delete user. Please try again.");
                    }
                }
                break;
                
            case "resetPassword":
                // Generate a random temporary password
                String temporaryPassword = generateTemporaryPassword();
                
                Users user = usersDao.getUserById(id);
                if (user != null) {
                    // Update user with new password
                    user.setPassword(temporaryPassword);
                    boolean resetSuccess = usersDao.updateUserPassword(user);
                    
                    if (resetSuccess) {
                        session.setAttribute("SUCCESS_MESSAGE", "Password has been reset to: " + temporaryPassword + 
                                            ". Please inform the user to change it after logging in.");
                    } else {
                        session.setAttribute("ERROR_MESSAGE", "Failed to reset password. Please try again.");
                    }
                } else {
                    session.setAttribute("ERROR_MESSAGE", "User not found.");
                }
                break;
                
            default:
                break;
        }
        
        response.sendRedirect("manage-users.jsp");
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("dataUser");
        
        // Check if user is logged in and is admin
        if (currentUser == null || currentUser.getRole() != 1) {
            response.sendRedirect("home.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect("manage-users.jsp");
            return;
        }
        
        if ("update".equals(action)) {
            try {
                // Get form parameters
                int id = Integer.parseInt(request.getParameter("id"));
                String username = request.getParameter("username");
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                int role = Integer.parseInt(request.getParameter("role"));
                String newPassword = request.getParameter("newPassword");
                
                UsersDao usersDao = new UsersDao();
                Users user = usersDao.getUserById(id);
                
                if (user == null) {
                    request.setAttribute("errorMessage", "User not found.");
                    request.getRequestDispatcher("admin-edit-user.jsp?id=" + id).forward(request, response);
                    return;
                }
                
                // Update user information
                user.setName(name);
                user.setEmail(email);
                user.setPhone(phone);
                user.setAddress(address);
                user.setRole(role);
                
                // Update password if provided
                if (newPassword != null && !newPassword.trim().isEmpty()) {
                    user.setPassword(newPassword);
                }
                
                boolean success = usersDao.updateUser(user);
                
                if (success) {
                    // If current user is updating themselves, update session
                    if (id == currentUser.getId()) {
                        session.setAttribute("dataUser", user);
                    }
                    
                    request.setAttribute("successMessage", "User profile updated successfully!");
                } else {
                    request.setAttribute("errorMessage", "Failed to update user profile. Please try again.");
                }
                
                request.getRequestDispatcher("admin-edit-user.jsp?id=" + id).forward(request, response);
                
            } catch (Exception e) {
                request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
                request.getRequestDispatcher("manage-users.jsp").forward(request, response);
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "User Management Controller for admin operations";
    }
    
    // Helper method to generate a random temporary password
    private String generateTemporaryPassword() {
        return UUID.randomUUID().toString().substring(0, 8);
    }
} 