/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.OrderDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDao {

    private Connection c;

    // Constructor mặc định, tự lấy kết nối từ DBContext
    public OrderDetailDao() {
        try {
            this.c = new DBConnect().c;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Constructor nhận kết nối (nếu muốn dùng lại connection từ ngoài)
    public OrderDetailDao(Connection c) {
        this.c = c;
    }

    // Lấy danh sách chi tiết đơn hàng theo orderId (oid)
    public List<OrderDetail> getOrderDetailsByOrderId(int oid) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String query = "SELECT * FROM OrderDetails WHERE order_id = ?"; 
        try {
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setInt(1, oid);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                orderDetails.add(new OrderDetail(
                        rs.getInt("order_id"), 
                        rs.getInt("product_id"), 
                        rs.getInt("cart_quantity"), 
                        rs.getDouble("price")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

}
