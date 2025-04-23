/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Dell
 */
public class Orders {

    private int id;
    private int userId;
    private double subtotal;
    private double shipping;
    private double total;
    private String status;

    public Orders() {
    }

    public Orders(int id, int userId, double subtotal, double shipping, double total, String status) {
        this.id = id;
        this.userId = userId;
        this.subtotal = subtotal;
        this.shipping = shipping;
        this.total = total;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public double getShipping() {
        return shipping;
    }

    public void setShipping(double shipping) {
        this.shipping = shipping;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Orders{" + "id=" + id + ", userId=" + userId + ", subtotal=" + subtotal + ", shipping=" + shipping + ", total=" + total + ", status=" + status + '}';
    }

    

}
