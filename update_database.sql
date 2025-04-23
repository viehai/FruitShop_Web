Create database Fruit12
USE Fruit12;

-- Drop existing tables in correct order
IF OBJECT_ID('OrderDetails', 'U') IS NOT NULL DROP TABLE OrderDetails;
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('ShoppingCart', 'U') IS NOT NULL DROP TABLE ShoppingCart;
IF OBJECT_ID('Products', 'U') IS NOT NULL DROP TABLE Products;
IF OBJECT_ID('Categories', 'U') IS NOT NULL DROP TABLE Categories;
IF OBJECT_ID('Users', 'U') IS NOT NULL DROP TABLE Users;

-- Create Users table with proper collation
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    name NVARCHAR(100) COLLATE Vietnamese_CI_AS,
    email NVARCHAR(100) UNIQUE,
    phone NVARCHAR(20),
    address NTEXT,
    role INT NOT NULL CHECK (role IN (1, 2)) -- 1: Admin, 2: Customer
);

-- Create other tables
CREATE TABLE Categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) COLLATE Vietnamese_CI_AS NOT NULL
);

CREATE TABLE Products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) COLLATE Vietnamese_CI_AS NOT NULL,
    price DECIMAL(10, 0) NOT NULL,
    products_quantity INT NULL,
    image NTEXT NULL,
    category_id INT NULL,
    category_type NVARCHAR(100) COLLATE Vietnamese_CI_AS NOT NULL
);

CREATE TABLE ShoppingCart (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    product_id INT,
    cart_quantity INT NOT NULL CHECK (cart_quantity >= 0),
    total_price DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(id) ON DELETE CASCADE
);

CREATE TABLE Orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    subtotal DECIMAL(10,2) NOT NULL,
    shipping DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    status NVARCHAR(50) COLLATE Vietnamese_CI_AS DEFAULT N'Đang chờ duyệt',
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

CREATE TABLE OrderDetails (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    product_id INT,
    cart_quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    subtotal AS (cart_quantity * price) PERSISTED,
    FOREIGN KEY (order_id) REFERENCES Orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(id) ON DELETE CASCADE
);

-- Insert sample data with proper Unicode prefix
INSERT INTO Users (username, password, name, email, phone, address, role) VALUES
(N'Vuong Thi Hong Phuoc', N'yeuphuoc', N'Vương Thị Hồng Phước', N'phuoc@example.com', N'0987654321', N'Hà Nội', 2),
(N'Chu Viet Hai', N'yeuhai', N'Chu Việt Hải', N'hai@example.com', N'0976543210', N'TP HCM', 2),
(N'Nguyen Tien Dung', N'yeudung', N'Nguyễn Tiến Dũng', N'admin@example.com', N'0909090909', N'Đà Nẵng', 1);


-- Insert categories
INSERT INTO Categories (name) VALUES
(N'Hoa quả nhiệt đới'),
(N'Hoa quả ôn đới'),
(N'Hoa quả cận nhiệt đới');

-- Insert products with Unicode support
INSERT INTO Products (name, price, products_quantity, image, category_id, category_type) VALUES
-- Hoa quả nhiệt đới
(N'Xoài', 10000, 7, N'nt-xoai.jpg', 1, N'Hoa quả nhiệt đới'),
(N'Chuối', 10000, 8, N'nt-chuoi.jpg', 1, N'Hoa quả nhiệt đới'),
(N'Dứa', 10000, 9, N'nt-thom.jpg', 1, N'Hoa quả nhiệt đới'),
(N'Sầu riêng', 10000, 7, N'nt-saurieng.jpg', 1, N'Hoa quả nhiệt đới'),
(N'Mít', 10000, 8, N'nt-mit.jpg', 1, N'Hoa quả nhiệt đới'),
(N'Chôm chôm', 10000, 9, N'nt-chomchom.jpg', 1, N'Hoa quả nhiệt đới'),
(N'Thanh long', 10000, 7, N'nt-thanhlong.jpg', 1, N'Hoa quả nhiệt đới'),
(N'Đu đủ', 10000, 8, N'nt-dudu.jpg', 1, N'Hoa quả nhiệt đới'),
(N'Măng cụt', 10000, 9, N'nt-mangcut.jpg', 1, N'Hoa quả nhiệt đới'),
(N'Chanh dây', 10000, 7, N'product-img-1', 1, N'Hoa quả nhiệt đới'),
(N'Ổi', 10000, 8, N'nt-oi.jpg', 1, N'Hoa quả nhiệt đới'),

-- Hoa quả ôn đới
(N'Táo', 12000, 9, N'od-tao.jpg', 2, N'Hoa quả ôn đới'),
(N'Lê', 12000, 7, N'od-le.jpg', 2, N'Hoa quả ôn đới'),
(N'Nho', 15000, 8, N'od-nho.jpg', 2, N'Hoa quả ôn đới'),
(N'Dâu tây', 20000, 9, N'od-dautay.jpg', 2, N'Hoa quả ôn đới'),
(N'Mận', 18000, 7, N'od-man.jpg', 2, N'Hoa quả ôn đới'),
(N'Cherry', 25000, 8, N'od-cherry.jpg', 2, N'Hoa quả ôn đới'),
(N'Việt quất', 30000, 9, N'od-vietquat.jpg', 2, N'Hoa quả ôn đới'),
(N'Mâm xôi', 27000, 7, N'od-mamxoi.jpg', 2, N'Hoa quả ôn đới'),

-- Hoa quả cận nhiệt đới
(N'Hồng giòn', 17000, 8, N'cnd-honggion.jpg', 3, N'Hoa quả cận nhiệt đới'),
(N'Quýt', 14000, 9, N'cnd-quyt.jpg', 3, N'Hoa quả cận nhiệt đới'),
(N'Cam', 13000, 7, N'cnd-cam.jpg', 3, N'Hoa quả cận nhiệt đới'),
(N'Chanh vàng', 11000, 8, N'cnd-chanhvang.jpg', 3, N'Hoa quả cận nhiệt đới'),
(N'Lựu', 16000, 9, N'cnd-luu.jpg', 3, N'Hoa quả cận nhiệt đới'),
(N'Kiwi', 22000, 7, N'cnd-kiwi.jpg', 3, N'Hoa quả cận nhiệt đới'); 

select * from Users