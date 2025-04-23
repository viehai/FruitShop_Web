/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Products;

public class ProductsDao extends DBConnect {

    public List<Products> getAllProducts() {
        List<Products> list = new ArrayList();
        String query = "SELECT * FROM Products";
        try {

            PreparedStatement stmt = c.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Products u = new Products(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getString(5), rs.getInt(6), rs.getString(7));
                list.add(u);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public boolean addProduct(Products product) {
        String sql = "INSERT INTO Products (name, price, products_quantity, image, category_type) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setString(1, product.getName());
            stmt.setDouble(2, product.getPrice());
            stmt.setInt(3, product.getProducts_quantity());
            stmt.setString(4, product.getImage());
            stmt.setString(5, product.getCategory_type()); // Thêm categoryType
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProduct(Products product) {
        String sql = "UPDATE Products SET name = ?, price = ?, products_quantity = ?, image = ? WHERE id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getProducts_quantity());
            ps.setString(4, product.getImage());
            ps.setInt(5, product.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM Products WHERE id = ?";
        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Products getProductByID(int id) {
        String sql = "SELECT * FROM Products WHERE id = ?";
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Products(
                        rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getString(5), rs.getInt(6), rs.getString(7)
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Products> getProductsByPage(int page, int pageSize) {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT * FROM Products ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, (page - 1) * pageSize);
            st.setInt(2, pageSize);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Products(
                        rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getString(5), rs.getInt(6), rs.getString(7)
                ));
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM Products";
        try (PreparedStatement st = c.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {

        }
        return 0;
    }
public List<Products> searchProducts(String query) {
    List<Products> productList = new ArrayList<>();
    String sql = "SELECT * FROM Products WHERE name LIKE ?";

    try {
        PreparedStatement st = c.prepareStatement(sql);
        st.setString(1, "%" + query + "%"); // Đặt giá trị trước khi chạy query

        ResultSet rs = st.executeQuery(); // Thực hiện truy vấn đúng lúc
        
        while (rs.next()) {
            Products p = new Products(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getInt("price"),
                rs.getString("image")
            );
            productList.add(p);
        }
        rs.close();
        st.close();
        c.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return productList;
}

  public List<Products> searchByKeywordWithPaging(String keyword, int page, int pageSize) {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE name LIKE ? OR category_type LIKE ? ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            st.setString(1, searchPattern);
            st.setString(2, searchPattern);
            st.setInt(3, (page - 1) * pageSize);
            st.setInt(4, pageSize);
            
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Products p = new Products(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getInt("price"),
                    rs.getInt("products_quantity"),
                    rs.getString("image"),
                    rs.getString("category_type")
                );
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println("Search with paging error: " + e.getMessage());
        }
        return list;
    }
    
    /**
     * Đếm tổng số sản phẩm phù hợp với từ khóa tìm kiếm
     * @param keyword Từ khóa tìm kiếm
     * @return Tổng số sản phẩm phù hợp
     */
    public int getTotalProductsByKeyword(String keyword) {
        String sql = "SELECT COUNT(*) FROM Products WHERE name LIKE ? OR category_type LIKE ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            st.setString(1, searchPattern);
            st.setString(2, searchPattern);
            
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Count search results error: " + e.getMessage());
        }
        return 0;
    }
    
    /**
     * Lấy danh sách sản phẩm theo ID danh mục với phân trang
     * @param categoryId ID của danh mục cần lọc
     * @param page Số trang hiện tại
     * @param pageSize Số sản phẩm trên một trang
     * @return Danh sách sản phẩm của danh mục đó với phân trang
     */
    public List<Products> getProductsByCategoryIdWithPaging(int categoryId, int page, int pageSize) {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE category_id = ? ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, categoryId);
            st.setInt(2, (page - 1) * pageSize);
            st.setInt(3, pageSize);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Products(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("products_quantity"),
                        rs.getString("image"),
                        rs.getInt("category_id"),
                        rs.getString("category_type")
                ));
            }
        } catch (SQLException e) {
            System.out.println("Filter by category ID error: " + e.getMessage());
        }
        return list;
    }
    
    /**
     * Đếm tổng số sản phẩm trong một danh mục
     * @param categoryId ID của danh mục cần đếm
     * @return Tổng số sản phẩm trong danh mục đó
     */
    public int getTotalProductsByCategoryId(int categoryId) {
        String sql = "SELECT COUNT(*) FROM Products WHERE category_id = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, categoryId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Count category products error: " + e.getMessage());
        }
        return 0;
    }

    public static void main(String[] args) {
        ProductsDao d = new ProductsDao();
        List<Products> list = d.getAllProducts();
        for (Products products : list) {
            System.out.println(products);
        }
    }

}
