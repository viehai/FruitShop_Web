/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller; 


import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Products;
import model.Users;

/**
 *
 * @author pc
 */
@WebServlet(name = "HomeController", urlPatterns = {"/home", "/add", "/update", "/delete"})
public class HomeController extends HttpServlet {
   
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
            out.println("<title>Servlet HomeController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeController at " + request.getContextPath () + "</h1>");
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
        if (request.getSession().getAttribute("SessionLogin") == null) {
            response.sendRedirect("login"); 
            return;
        }

        String path = request.getServletPath();
        if (path.equals("/home")) {
            String successMessage = (String) request.getSession().getAttribute("SUCCESS_MESSAGE");
            if (successMessage != null) {
                request.setAttribute("SUCCESS_MESSAGE", successMessage);
                request.getSession().removeAttribute("SUCCESS_MESSAGE"); 
            }
            request.getRequestDispatcher("home.jsp").forward(request, response);
//        } else if (path.equals("/userprofile")) {
//            Users user = (Users) request.getSession().getAttribute("SessionLogin");
//            request.setAttribute("userProfile", user);
//            request.getRequestDispatcher("userprofile.jsp").forward(request, response);
//        }
        }}

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        if (request.getSession().getAttribute("SessionLogin") == null) {
           response.sendRedirect("login"); 
            return;
       }
        
        ///// Products
//        ProductsDao d = new ProductsDao();
//        List<Products> list = d.getAllProducts();
//        request.setAttribute("listP", list);
//        request.getRequestDispatcher("shop.jsp").forward(request, response);
        
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
