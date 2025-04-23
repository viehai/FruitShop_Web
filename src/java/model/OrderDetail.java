/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Dell
 */
public class OrderDetail {

    private int orderId;
    private int productId;
    private int cartQuantity;
    private double price;

    public OrderDetail(int orderId, int productId, int cartQuantity, double price) {
        this.orderId = orderId;
        this.productId = productId;
        this.cartQuantity = cartQuantity;
        this.price = price;
    }

    public int getOrderId() {
        return orderId;
    }

    public int getProductId() {
        return productId;
    }

    public int getCartQuantity() {
        return cartQuantity;
    }

    public double getPrice() {
        return price;
    }

}
