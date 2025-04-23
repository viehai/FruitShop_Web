/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


public class Products {
    private int id;
    private String name;
    private int price;
    private int products_quantity;
    private String image;
    private int category_id;
    private String category_type;
    private String status;

    public Products() {
    }

    public Products(String name, int price, int products_quantity, String image, int category_id, String category_type, String status) {
        this.name = name;
        this.price = price;
        this.products_quantity = products_quantity;
        this.image = image;
        this.category_id = category_id;
        this.category_type = category_type;
        this.status = status;
    }

    public Products(int id, String name, int price, int products_quantity, String image, int category_id, String category_type) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.products_quantity = products_quantity;
        this.image = image;
        this.category_id = category_id;
        this.category_type = category_type;
    }
    

    public Products(int id, String name, int price, int products_quantity, String image, int category_id, String category_type, String status) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.products_quantity = products_quantity;
        this.image = image;
        this.category_id = category_id;
        this.category_type = category_type;
        this.status = status;
    }

    public Products(int id, String name, int price, int products_quantity, String image) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.products_quantity = products_quantity;
        this.image = image;
    }

    public Products(int id, String name, int price, int products_quantity, String image, String category_type) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.products_quantity = products_quantity;
        this.image = image;
        this.category_type = category_type;
    }

    public Products(int id, String name, int price, String image) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
    }

    public Products(int id, String name, int price, String image, String category_type) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.category_type = category_type;
    }
    
    
    
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getProducts_quantity() {
        return products_quantity;
    }

    public void setProducts_quantity(int products_quantity) {
        this.products_quantity = products_quantity;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public String getCategory_type() {
        return category_type;
    }

    public void setCategory_type(String category_type) {
        this.category_type = category_type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Products{" + "id=" + id + ", name=" + name + ", price=" + price + ", products_quantity=" + products_quantity + ", image=" + image + ", category_id=" + category_id + ", category_type=" + category_type + ", status=" + status + '}';
    }

   
    
    
            
}
