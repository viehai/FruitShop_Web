/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UsersDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;

/**
 *
 * @author pc
 */
public class UpdateProfileController extends HttpServlet {

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
        // Redirect to the edit profile page
        response.sendRedirect("edit-profile.jsp");
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
        
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Get form parameters
            int id = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            int role = Integer.parseInt(request.getParameter("role"));
            
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            
            // Verify current password
            UsersDao usersDao = new UsersDao();
            Users user = usersDao.login(username, currentPassword);
            
            if (user == null) {
                // Current password is incorrect
                request.setAttribute("errorMessage", "Current password is incorrect.");
                request.getRequestDispatcher("edit-profile.jsp").forward(request, response);
                return;
            }
            
            // Check if user wants to change password
            String passwordToUpdate = currentPassword; // Default to current password
            
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                if (!newPassword.equals(confirmPassword)) {
                    // New passwords don't match
                    request.setAttribute("errorMessage", "New password and confirm password do not match.");
                    request.getRequestDispatcher("edit-profile.jsp").forward(request, response);
                    return;
                }
                
                // Update to new password
                passwordToUpdate = newPassword;
            }
            
            // Create updated user object
            Users updatedUser = new Users(
                    id,
                    username,
                    passwordToUpdate,
                    name,
                    email,
                    phone,
                    address,
                    role
            );
            
            // Update user in database
            boolean success = usersDao.updateUser(updatedUser);
            
            if (success) {
                // Update session with new user info
                session.setAttribute("dataUser", updatedUser);
                request.setAttribute("successMessage", "Profile updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
            }
            
            request.getRequestDispatcher("edit-profile.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("edit-profile.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Update Profile Controller";
    }
} 