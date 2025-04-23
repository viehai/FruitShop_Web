package controller;

import dal.UsersDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Users;

@WebServlet(name = "ResetPasswordController", urlPatterns = {"/reset-password"})
public class ResetPasswordController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("reset_email");
        
        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }
        
        UsersDao usersDao = new UsersDao();
        Users user = usersDao.getUserByEmail(email);
        
        if (user != null) {
            user.setPassword(newPassword);
            boolean success = usersDao.updateUserPassword(user);
            
            if (success) {
                // Clear the reset email from session
                session.removeAttribute("reset_email");
                
                // Set success message
                request.setAttribute("msg", "Password has been reset successfully. Please login with your new password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Failed to reset password. Please try again.");
                request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }
} 