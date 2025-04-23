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
import model.Cart;
import model.Item;
import model.Orders;
import model.Users;

/**
 *
 * @author pc
 */
public class OrderDao extends DBConnect {

    public void addOrder(Users u, Cart cart) throws SQLException {
        ResultSet rs = null;
        int orderId = 0;
        try {
            String sql = "INSERT INTO orders (user_id, subtotal, shipping, total) VALUES (?, ?, ?, ?)";
            PreparedStatement st = c.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            st.setInt(1, u.getId());
            st.setDouble(2, cart.getTotalMoney());
            st.setDouble(3, 10.0); // Giả sử phí ship là 10
            st.setDouble(4, cart.getTotalMoney() + 10.0);
            st.executeUpdate();

            // Lấy ID của đơn hàng vừa chèn
            // 2️⃣ Lấy ID đơn hàng vừa tạo
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // 3️⃣ Thêm chi tiết đơn hàng vào bảng OrderDetail
            String sqlOrderDetail = "INSERT INTO OrderDetails (order_id, product_id, cart_quantity, price) VALUES (?, ?, ?, ?)";
            st = c.prepareStatement(sqlOrderDetail);
            for (Item item : cart.getItems()) {
                st.setInt(1, orderId);
                st.setInt(2, item.getProduct().getId());
                st.setInt(3, item.getQuantity());
                st.setDouble(4, item.getPrice());
                st.executeUpdate();
            }
        } catch (SQLException e) {
            if (c != null) {
                c.rollback(); // Rollback nếu có lỗi
            }
            System.out.println(e);
        }

    }

    public boolean saveOrder(Orders order, List<Item> items) {
        PreparedStatement psOrder = null;
        PreparedStatement psOrderDetails = null;
        ResultSet rs = null;

        try {
            c.setAutoCommit(false); // Bắt đầu transaction

            // 1. Thêm đơn hàng vào bảng Orders
            String sqlOrder = "INSERT INTO Orders (user_id, subtotal, shipping, total) VALUES (?, ?, ?, ?)";
            psOrder = c.prepareStatement(sqlOrder, PreparedStatement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, order.getUserId());
            psOrder.setDouble(2, order.getSubtotal());
            psOrder.setDouble(3, order.getShipping());
            psOrder.setDouble(4, order.getTotal());
            psOrder.executeUpdate();

            // 2. Lấy ID của đơn hàng vừa tạo
            rs = psOrder.getGeneratedKeys();
            int orderId = -1;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            if (orderId == -1) {
                c.rollback(); // Nếu không lấy được orderId, rollback và trả về false
                return false;
            }

            // 3. Thêm chi tiết đơn hàng vào bảng OrderDetails
            String sqlOrderDetails = "INSERT INTO OrderDetails (order_id, product_id, cart_quantity, price) VALUES (?, ?, ?, ?)";
            psOrderDetails = c.prepareStatement(sqlOrderDetails);

            for (Item item : items) {
                psOrderDetails.setInt(1, orderId);
                psOrderDetails.setInt(2, item.getProduct().getId());
                psOrderDetails.setInt(3, item.getQuantity());
                psOrderDetails.setDouble(4, item.getPrice());
                psOrderDetails.addBatch(); // Thêm vào batch để tăng hiệu suất
            }
            psOrderDetails.executeBatch(); // Thực thi batch

            c.commit(); // Commit transaction nếu không có lỗi
            return true;

        } catch (SQLException e) {
            try {
                if (c != null) {
                    c.rollback(); // Nếu lỗi, rollback dữ liệu
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            // Đóng tài nguyên
            try {
                if (rs != null) {
                    rs.close();
                }
                if (psOrder != null) {
                    psOrder.close();
                }
                if (psOrderDetails != null) {
                    psOrderDetails.close();
                }
                if (c != null) {
                    c.setAutoCommit(true); // Đặt lại chế độ auto commit
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    public List<Orders> getOrdersByUserId(int userId) {
        List<Orders> orders = new ArrayList<>();
        String sql = "SELECT id, user_id, subtotal, shipping, total, status FROM Orders WHERE user_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Orders order = new Orders();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setSubtotal(rs.getDouble("subtotal"));
                order.setShipping(rs.getDouble("shipping"));
                order.setTotal(rs.getDouble("total"));
                order.setStatus(rs.getString("status"));
                orders.add(order);
            }
        } catch (SQLException e) {

        }
        return orders;
    }

    public List<Orders> getAllOrders() {
        List<Orders> orders = new ArrayList<>();
        String query = "SELECT * FROM Orders";
        try {
            PreparedStatement ps = c.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Orders order = new Orders();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setSubtotal(rs.getDouble("subtotal"));
                order.setShipping(rs.getDouble("shipping"));
                order.setStatus(rs.getString("status"));
                order.setTotal(rs.getDouble("total"));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            int rows = ps.executeUpdate();
            return rows > 0; // Trả về true nếu cập nhật thành công
        } catch (SQLException e) {

            return false;
        }
    }

    public boolean deleteOrder(int orderId) {
        String sql = "DELETE FROM Orders WHERE id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; 
        } catch (SQLException e) {
            e.printStackTrace();
            return false; 
        }
    }

    public Orders getOrderById(int id) {
        String sql = "SELECT * FROM Orders WHERE id = ?";
        try {
            PreparedStatement stmt = c.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Orders(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getDouble("subtotal"),
                        rs.getDouble("shipping"),
                        rs.getDouble("total"),
                        rs.getString("status") // Kiểm tra có cột này không
                );
            }
        } catch (SQLException e) {

        }
        return null;
    }

    public static void main(String[] args) {
        OrderDao dao = new OrderDao();
        List<Orders> orders = dao.getOrdersByUserId(6);
        for (Orders order : orders) {
            System.out.println(order);
        }
    }

}
