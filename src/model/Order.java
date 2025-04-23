public class Order {
    private Long id;
    private Customer customer;
    private Cart cart;
    private LocalDateTime orderDate;
    private double totalAmount;
    private String status;

    public Order(Customer customer, Cart cart) {
        this.customer = customer;
        this.cart = cart;
        this.orderDate = LocalDateTime.now();
        this.totalAmount = cart.getTotalAmount();
        this.status = "PENDING";
    }

    // Add getters and setters
}
