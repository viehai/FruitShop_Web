<%@ page import="model.Cart" %>
<%@ page import="model.Item" %>
<%@ page import="model.Products" %>
<%@ page import="java.util.List" %>
<%@page import = "model.Users"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">

        <!-- title -->
        <title>Check Out</title>

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

                                    <%-- Nếu đã đăng nhập và không phải admin, hiển thị "My Orders" --%>
                                    <% if (user != null && user.getRole() != 1) { %>
                                    <li><a href="my-order.jsp">My Orders</a></li>
                                        <% } %>

                                    <%-- Nếu là admin (role = 1), hiển thị "Manage Orders" và "Manage Products" --%>
                                    <% if (user != null && user.getRole() == 1) { %>
                                    <li><a href="manage-orders.jsp">Manage Orders</a></li>
                                    <li><a href="manage-products.jsp">Manage Products</a></li>
                                        <% } %>


                                   

                                    <%-- chưa login --%>
                                    <% if (user == null) { %>
                                    <li>
                                        <div class="header-icons">
                                            <a class="shopping-cart" href="cart.jsp"><i class="fas fa-shopping-cart"></i></a>
                                            <a class="mobile-hide search-bar-icon" href="#"><i class="fas fa-search"></i></a>
                                            <a href="login.jsp">Login</a>
                                        </div>
                                    </li>
                                    <% } else { %>
                                    <%-- đã login --%>
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
                            <h1>Check Out Product</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end breadcrumb section -->

        <!-- check out section -->
        <div class="checkout-section mt-150 mb-150">
            <div class="container">
                <div class="row">


                    <div class="col-lg-4">
                        <div class="order-details-wrap">
                            <table class="order-details">
                                <thead>
                                    <tr>
                                        <th>Your order Details</th>
                                        <th>Price</th>
                                    </tr>
                                </thead>
                                <%
          Cart cart = (Cart) session.getAttribute("cart");
          if (cart == null) {
              cart = new Cart();
              session.setAttribute("cart", cart);
          }

          double totalPrice = 0;
          double shippingFee = 50;
                                %>
                                <tbody class="order-details-body">
                                    <tr>
                                        <td>Product</td>
                                        <td>Total</td>
                                    </tr
                                    <% for (Item item : cart.getItems()) {
            double itemTotal = item.getQuantity() * item.getPrice();
            totalPrice += itemTotal;
                                    %>
                                    <tr>
                                        <td><%= item.getProduct().getName() %> (x<%= item.getQuantity() %>)</td>
                                        <td>$<%= itemTotal %></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                                <tbody class="checkout-details">
                                    <tr>
                                        <td>Subtotal</td>
                                        <td>$<%= totalPrice %></td>
                                    </tr>
                                    <tr>
                                        <td>Shipping</td>
                                        <td>$<%= shippingFee %></td>
                                    </tr>
                                    <tr>
                                        <td>Total</td>
                                        <td>$<%= totalPrice + shippingFee %></td>
                                    </tr>
                                </tbody>
                            </table>
                            <form action="checkout" method="POST">
                                <button type="submit" class="boxed-btn" 
                                        style="background-color: orange; color: white; border-radius: 15px; padding: 12px 25px; border: none; font-size: 16px; cursor: pointer; margin-top: 20px;">
                                    Place Order
                                </button>

                            </form>
                            <%
Boolean orderSuccess = (Boolean) session.getAttribute("orderSuccess");
if (orderSuccess != null && orderSuccess) {
                            %>
                            <!-- Overlay background to darken the checkout page -->
                            <div id="overlay" style="
                                 position: fixed; top: 0; left: 0; width: 100%; height: 100%;
                                 background: rgba(0, 0, 0, 0.6); z-index: 999;">
                            </div>

                            <!-- Centered success message -->
                            <div id="success-popup" style="
                                 position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
                                 background-color: #ff9800; color: white; font-weight: bold;
                                 padding: 20px; border-radius: 10px; text-align: center;
                                 font-size: 18px; font-family: Arial, sans-serif; width: 50%;
                                 box-shadow: 0px 0px 15px rgba(0,0,0,0.3); z-index: 1000;">

                                <h2 style="margin: 0; font-size: 24px;">Order Placed Successfully!</h2>
                                <p style="margin: 10px 0 20px;">Thank you for your. Your order is being processed.</p>
                                <button onclick="closePopup()" style="
                                        background-color: white; color: #ff9800; font-size: 16px;
                                        border: none; padding: 10px 20px; border-radius: 5px;
                                        cursor: pointer; font-weight: bold;">
                                    OK
                                </button>
                            </div>

                            <!-- Remove session attribute after displaying -->
                            <% session.removeAttribute("orderSuccess"); %>

                            <!-- JavaScript to close the popup -->
                            <script>
                                function closePopup() {
                                    document.getElementById("overlay").style.display = "none";
                                    document.getElementById("success-popup").style.display = "none";
                                }
                            </script>
                            <%
                            }
                            %>




                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end check out section -->

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

    </body>
</html>