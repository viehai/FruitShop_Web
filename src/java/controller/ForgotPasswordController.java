package controller;

import dal.UsersDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import model.Users;

@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/forgot-password"})
public class ForgotPasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("verify".equals(action)) {
            String email = request.getParameter("email");
            UsersDao usersDao = new UsersDao();
            Users user = usersDao.getUserByEmail(email);
            
            request.setCharacterEncoding("UTF-8");
            response.setContentType("application/json;charset=UTF-8");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            
            if (user != null) {
                System.out.println("Found user with name: " + user.getName());
                String name = user.getName() != null ? user.getName() : "";
                String username = user.getUsername() != null ? user.getUsername() : "";
                
                // Manually create JSON string with proper escaping
                String jsonResponse = String.format(
                    "{\"found\":true,\"username\":\"%s\",\"name\":\"%s\"}", 
                    escapeJsonString(username),
                    escapeJsonString(name)
                );
                System.out.println("JSON Response: " + jsonResponse);
                out.print(jsonResponse);
            } else {
                out.print("{\"found\":false,\"message\":\"Email not found\"}");
            }
            out.flush();
        }
    }

    private String escapeJsonString(String input) {
        if (input == null) {
            return "";
        }
        return input.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\b", "\\b")
                   .replace("\f", "\\f")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        
        UsersDao usersDao = new UsersDao();
        Users user = usersDao.getUserByEmail(email);
        
        if (user != null) {
            // Store the email in session for verification in reset password page
            request.getSession().setAttribute("reset_email", email);
            response.sendRedirect("reset-password.jsp");
        } else {
            request.setAttribute("error", "Email not found");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
} 