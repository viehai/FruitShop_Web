package controller;

import dal.ProductsDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.Item;
import model.Products;

import java.io.IOException;


@WebServlet(name = "CartController", urlPatterns = {"/CartController"})
public class CartController extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
        }

        String action = request.getParameter("action");
        String id = request.getParameter("id");

        if (action != null && id != null) {
            int productId = Integer.parseInt(id);

            if (action.equals("add")) {
                ProductsDao productDao = new ProductsDao();
                Products product = productDao.getProductByID(productId);
                if (product != null) {
                    cart.addItem(new Item(product, 1, product.getPrice()));
                }
            } else if (action.equals("remove")) {
                cart.removeItem(productId);
            }
        }

        // Cập nhật lại giỏ hàng vào session
        session.setAttribute("cart", cart);
        response.sendRedirect("cart.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");
    
    if ("update".equals(action)) {
        int productId = Integer.parseInt(request.getParameter("id"));
        int newQuantity = Integer.parseInt(request.getParameter("quantity"));

        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (cart != null) {
            for (Item item : cart.getItems()) {
                if (item.getProduct().getId() == productId) {
                    item.setQuantity(newQuantity);
                    break;
                }
            }
        }

        // Lưu lại giỏ hàng vào session
        request.getSession().setAttribute("cart", cart);
        response.sendRedirect("cart.jsp"); // Load lại trang để cập nhật tổng giá
    }
}

}
