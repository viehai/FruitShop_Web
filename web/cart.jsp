
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="model.Item"%>
<%@page import="model.Cart"%>
<%@page import = "model.Users"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">

        <!-- title -->
        <title>Cart</title>

        <!-- favicon -->
        <link rel="shortcut icon" type="image/png" href="assets/img/favicon.png">
        <!-- google font -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Poppins:400,700&display=swap" rel="stylesheet">
        <!-- fontawesome -->
        <link rel="stylesheet" href="assets/css/all.min.css">
        <!-- bootstrap -->
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <!-- owl carousel -->
        <link rel="stylesheet" href="assets/css/owl.carousel.css">
        <!-- magnific popup -->
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <!-- animate css -->
        <link rel="stylesheet" href="assets/css/animate.css">
        <!-- mean menu css -->
        <link rel="stylesheet" href="assets/css/meanmenu.min.css">
        <!-- main style -->
        <link rel="stylesheet" href="assets/css/main.css">
        <!-- responsive -->
        <link rel="stylesheet" href="assets/css/responsive.css">

    </head>
    <body>

        <!--PreLoader-->
        <div class="loader">
            <div class="loader-inner">
                <div class="circle"></div>
            </div>
        </div>
        <!--PreLoader Ends-->

        <!-- header -->
        <div class="top-header-area" id="sticker">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-sm-12 text-center">
                        <div class="main-menu-wrap">
                            <!-- logo -->
                            <div class="site-logo">
                                <a href="home.jsp">
                                    <img src="assets/img/logo.png" alt="">
                                </a>
                            </div>
                            <!-- logo -->
    <!-- menu start -->
                            <nav class="main-menu">
                                <ul>
                                    <li><a href="home.jsp">Home</a></li>
                                    <li><a href="about.jsp">About</a></li>
                                    <li><a href="checkout.jsp">Check Out</a></li>
                                 
                                    <li><a href="shop">Shop</a></li>
                                    <%
    Users user = (Users) session.getAttribute("dataUser");
    %>

                                    <%-- N?u ?ã ??ng nh?p và không ph?i admin, hi?n th? "My Orders" --%>
                                    <% if (user != null && user.getRole() != 1) { %>
                                    <li><a href="my-order.jsp">My Orders</a></li>
                                        <% } %>

                                    <%-- N?u là admin (role = 1), hi?n th? "Manage Orders" và "Manage Products" --%>
                                    <% if (user != null && user.getRole() == 1) { %>
                                    <li><a href="manage-orders.jsp">Manage Orders</a></li>
                                    <li><a href="manage-products.jsp">Manage Products</a></li>
                                        <% } %>


                                   

                                    <%-- ch?a login --%>
                                    <% if (user == null) { %>
                                    <li>
                                        <div class="header-icons">
                                            <a class="shopping-cart" href="cart.jsp"><i class="fas fa-shopping-cart"></i></a>
                                            <a class="mobile-hide search-bar-icon" href="#"><i class="fas fa-search"></i></a>
                                            <a href="login.jsp">Login</a>
                                        </div>
                                    </li>
                                    <% } else { %>
                                    <%-- ?ã login --%>
                                    <li>
                                        <div class="header-icons">
                                            <a class="shopping-cart" href="cart.jsp"><i class="fas fa-shopping-cart"></i></a>
                                            <a class="mobile-hide search-bar-icon" href="#"><i class="fas fa-search"></i></a>
                                            <a href="#" style="font-weight: bold; color: white">
                                                <%= user.getName() %>
                                            </a>

                                            <a href="logout">Logout</a>
                                        </div>
                                    </li>
                                    <% } %>
                                </ul>
                            </nav>
                            <a class="mobile-show search-bar-icon" href="#"><i class="fas fa-search"></i></a>
                            <div class="mobile-menu"></div>
                            <!-- menu end -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end header -->

              <!-- search area -->
        <div class="search-area">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <span class="close-btn"><i class="fas fa-window-close"></i></span>
                        <div class="search-bar">
                            <div class="search-bar-tablecell">
                                <h3>Search For:</h3>
                                <form action="shop">
                                
                                    <input type="text" name="query" placeholder="Enter product name">
                                    <button type="submit">Search <i class="fas fa-search"></i></button>
                              </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end search area -->

        <!-- breadcrumb-section -->
        <div class="breadcrumb-section breadcrumb-bg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 offset-lg-2 text-center">
                        <div class="breadcrumb-text">
                            <p>Fresh and Organic</p>
                            <h1>Cart</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end breadcrumb section -->

        <!-- cart -->
        <%
   Cart cart = (Cart) session.getAttribute("cart");
   if (cart == null) {
       cart = new Cart();
       session.setAttribute("cart", cart);
   }
        %>

        <div class="cart-section mt-150 mb-150">
            <div class="container">
                <div class="row">
                    <!-- Danh sách s?n ph?m trong gi? hàng -->
                    <div class="col-lg-8 col-md-12">
                        <div class="cart-table-wrap">
                            <table class="cart-table">
                                <thead class="cart-table-head">
                                    <tr class="table-head-row">
                                        <th class="product-remove"></th>
                                        <th class="product-image">Product Image</th>
                                        <th class="product-name">Name</th>
                                        <th class="product-price">Price</th>
                                        <th class="product-quantity">Quantity</th>
                                        <th class="product-total">Total</th>
                                    </tr>
                                </thead>
                                <tbody id="cart-items">
                                    <%
                                        double totalPrice = 0;
                                        for (Item item : cart.getItems()) {
                                            double itemTotal = item.getQuantity() * item.getPrice();
                                            totalPrice += itemTotal;
                                    %>

                                    <tr class="table-body-row">
                                        <td class="product-remove">
                                            <form action="CartController">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="id" value="<%= item.getProduct().getId() %>">
                                                <button type="submit" style="border: none; background: none; cursor: pointer;">
                                                    <i class="far fa-window-close"></i>
                                                </button>
                                            </form>
                                        </td>


                                        <td class="product-image">
                                            <img src="<%= request.getContextPath() %>/assets/img/products/<%= item.getProduct().getImage() %>" 
                                                 alt="<%= item.getProduct().getName() %>" 
                                                 onerror="this.onerror=null; this.src='<%= request.getContextPath() %>/assets/img/products/default-image.jpg';" 
                                                 style="width: 100px; height: 100px;object-fit: contain; padding: 5px;">
                                        </td>


                                        <td class="product-name"><%= item.getProduct().getName() %></td>
                                        <td class="product-price">$<%= item.getPrice() %></td>
                                        <td class="product-quantity">
                                            <form action="CartController" method="post">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="id" value="<%= item.getProduct().getId() %>">
                                                <input type="number" name="quantity" 
                                                       value="<%= item.getQuantity() %>" 
                                                       min="1" 
                                                       onchange="this.form.submit()">
                                            </form>
                                        </td>


                                        <td class="product-total">$<span id="total-<%= item.getProduct().getId() %>"><%= itemTotal %></span></td>
                                    </tr>

                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- T?ng giá tr? gi? hàng -->
                    <div class="col-lg-4">
                        <div class="total-section">
                            <table class="total-table">
                                <thead class="total-table-head">
                                    <tr class="table-total-row">
                                        <th>Total</th>
                                        <th>Price</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="total-data">
                                        <td><strong>Subtotal: </strong></td>
                                        <td>$<span id="subtotal"><%= totalPrice %></span></td>
                                    </tr>
                                    <tr class="total-data">
                                        <td><strong>Shipping: </strong></td>
                                        <td>$50</td>
                                    </tr>
                                    <tr class="total-data">
                                        <td><strong>Total: </strong></td>
                                        <td>$<span id="grand-total"><%= totalPrice + 50 %></span></td>
                                    </tr>

                                </tbody>
                            </table>
                            <div class="cart-buttons">
                                <a href="shop" class="boxed-btn">Continue Shopping</a>
                                <a href="checkout.jsp" class="boxed-btn black">Check Out</a>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>
        <!-- end cart -->

        <!-- logo carousel -->
        <div class="logo-carousel-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="logo-carousel-inner">
                            <div class="single-logo-item">
                                <img src="assets/img/company-logos/1.png" alt="">
                            </div>
                            <div class="single-logo-item">
                                <img src="assets/img/company-logos/2.png" alt="">
                            </div>
                            <div class="single-logo-item">
                                <img src="assets/img/company-logos/3.png" alt="">
                            </div>
                            <div class="single-logo-item">
                                <img src="assets/img/company-logos/4.png" alt="">
                            </div>
                            <div class="single-logo-item">
                                <img src="assets/img/company-logos/5.png" alt="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end logo carousel -->

        <!-- footer -->
        <div class="footer-area">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-box about-widget">
                            <h2 class="widget-title">About us</h2>
                            <p>Ut enim ad minim veniam perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-box get-in-touch">
                            <h2 class="widget-title">Get in Touch</h2>
                            <ul>
                                <li>34/8, East Hukupara, Gifirtok, Sadan.</li>
                                <li>support@fruitkha.com</li>
                                <li>+00 111 222 3333</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-box pages">
                            <h2 class="widget-title">Pages</h2>
                            <ul>
                                <li><a href="home.jsp">Home</a></li>
                                <li><a href="about.jsp">About</a></li>
                                <li><a href="shop">Shop</a></li>

                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-box subscribe">
                            <h2 class="widget-title">Subscribe</h2>
                            <p>Subscribe to our mailing list to get the latest updates.</p>
                            <form action="index.jsp">
                                <input type="email" placeholder="Email">
                                <button type="submit"><i class="fas fa-paper-plane"></i></button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end footer -->

        <!-- copyright -->
        <div class="copyright">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-12">
                        <p>Copyrights &copy; 2019 - <a href="https://imransdesign.com/">Imran Hossain</a>,  All Rights Reserved.<br>
                            Distributed By - <a href="https://themewagon.com/">Themewagon</a>
                        </p>
                    </div>
                    <div class="col-lg-6 text-right col-md-12">
                        <div class="social-icons">
                            <ul>
                                <li><a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
                                <li><a href="#" target="_blank"><i class="fab fa-twitter"></i></a></li>
                                <li><a href="#" target="_blank"><i class="fab fa-instagram"></i></a></li>
                                <li><a href="#" target="_blank"><i class="fab fa-linkedin"></i></a></li>
                                <li><a href="#" target="_blank"><i class="fab fa-dribbble"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end copyright -->

        <!-- jquery -->
        <script src="assets/js/jquery-1.11.3.min.js"></script>
        <!-- bootstrap -->
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
        <!-- count down -->
        <script src="assets/js/jquery.countdown.js"></script>
        <!-- isotope -->
        <script src="assets/js/jquery.isotope-3.0.6.min.js"></script>
        <!-- waypoints -->
        <script src="assets/js/waypoints.js"></script>
        <!-- owl carousel -->
        <script src="assets/js/owl.carousel.min.js"></script>
        <!-- magnific popup -->
        <script src="assets/js/jquery.magnific-popup.min.js"></script>
        <!-- mean menu -->
        <script src="assets/js/jquery.meanmenu.min.js"></script>
        <!-- sticker js -->
        <script src="assets/js/sticker.js"></script>
        <!-- main js -->
        <script src="assets/js/main.js"></script>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
                                                           $(document).ready(function () {
                                                               $(".remove-item").click(function (e) {
                                                                   e.preventDefault();
                                                                   var productId = $(this).data("id");
                                                                   var row = $(this).closest("tr");

                                                                   $.ajax({
                                                                       url: "CartController",
                                                                       type: "POST",
                                                                       data: {action: "remove", id: productId},
                                                                       success: function (response) {
                                                                           row.remove(); // Xóa hàng s?n ph?m kh?i b?ng
                                                                           updateTotal(); // C?p nh?t t?ng giá ti?n
                                                                       }
                                                                   });
                                                               });

                                                               function updateTotal() {
                                                                   var total = 0;
                                                                   $(".product-total span").each(function () {
                                                                       total += parseFloat($(this).text().replace("$", ""));
                                                                   });
                                                                   $(".total-data td:last").text("$" + total);
                                                               }
                                                           });
        </script>


    </body>
</html>