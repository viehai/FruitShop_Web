/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ProductsDao;
import dal.CategoriesDao;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;
import model.Categories;
import model.Products;

/**
 *
 * @author pc
 */
@WebServlet(name = "ProductsController", urlPatterns = {"/products", "/shop"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)

public class ProductsController extends HttpServlet {

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

        ///// Products
        ProductsDao d = new ProductsDao();
        CategoriesDao c = new CategoriesDao();
        List<Products> list = d.getAllProducts();
        List<Categories> listC = c.getAllCategories();
        request.setAttribute("listP", list);
        request.setAttribute("listC", listC);
        request.getRequestDispatcher("shop.jsp").forward(request, response);
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

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addProduct(request, response);
        } else if ("edit".equals(action)) {
            editProduct(request, response);
        } else if ("delete".equals(action)) {
            deleteProduct(request, response);
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name");
        int price = Integer.parseInt(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        String categoryType = request.getParameter("categoryType");

        // Xử lý ảnh tải lên
        Part part = request.getPart("image");
        String fileName = part.getSubmittedFileName();
        String uploadDir = "C:\\Users\\pc\\Downloads\\Shop12\\Shop12\\web\\assets\\img\\products";
        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdir();
        }
        String imagePath = uploadDir + File.separator + fileName;
        part.write(imagePath);

        // Lưu sản phẩm vào database
        ProductsDao productDAO = new ProductsDao();
        productDAO.addProduct(new Products(0, name, price, quantity, fileName, categoryType));

        response.sendRedirect("manage-products.jsp");
    }

    private void editProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        int price = Integer.parseInt(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        String categoryType = request.getParameter("categoryType");

      
        Part part = request.getPart("image");
        ProductsDao productDAO = new ProductsDao();
        Products existingProduct = productDAO.getProductByID(id);
        String fileName = (part != null && part.getSize() > 0) ? part.getSubmittedFileName() : existingProduct.getImage();

        String imagePath = (fileName.isEmpty()) ? null : fileName;

        productDAO.updateProduct(new Products(id, name, price, quantity, imagePath, categoryType));

        response.sendRedirect("manage-products.jsp");
    }
    
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
    int id = Integer.parseInt(request.getParameter("id"));

    ProductsDao productDAO = new ProductsDao();
    productDAO.deleteProduct(id); 

    response.sendRedirect("manage-products.jsp"); 
}

    

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
