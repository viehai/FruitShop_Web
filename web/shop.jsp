<%@page contentType="text/html" pageEncoding="UTF-8"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>



<%@ page import="java.util.List" %>
<%@ page import="model.Products" %>
<%@ page import="dal.ProductsDao" %>

<%@page import = "model.Users"%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">

        <!-- title -->
        <title>Shop</title>

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

        <style>
            /* Custom styles for pagination */
            .pagination-wrap .disabled {
                color: #999;
                cursor: not-allowed;
                padding: 7px 13px;
                display: inline-block;
            }
            
            .pagination-wrap ul li {
                display: inline-block;
                margin: 0 5px;
            }
            
            .pagination-wrap ul li a.active {
                background-color: #F28123;
                color: #fff;
            }
            
            /* Category button styles */
            .product-filters ul li a {
                display: inline-block;
                padding: 8px 15px;
                color: #333;
                text-decoration: none;
            }
            
            .product-filters ul li.active a {
                background-color: #F28123;
                color: #fff;
            }
        </style>
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
                                            <a href="edit-profile.jsp"><i class="fas fa-user-edit"></i> Edit Profile</a>
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
                            <h1>Shop</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end breadcrumb section -->

        <!-- products -->

        <%
            String searchQuery = request.getParameter("query");
            String categoryParam = request.getParameter("category");
            int categoryId = 0; // Default for all categories
            
            if(categoryParam != null && !categoryParam.trim().isEmpty()) {
                try {
                    categoryId = Integer.parseInt(categoryParam);
                } catch (NumberFormatException e) {
                    // Handle invalid category parameter
                    categoryId = 0;
                }
            }
            
            int pageNumber = 1;
            int recordsPerPage = 6; // 6 products per page
            
            if(request.getParameter("page") != null) {
                pageNumber = Integer.parseInt(request.getParameter("page"));
            }
            
            ProductsDao productsDao = new ProductsDao();
            List<Products> listP;
            int totalProducts;
            
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                // Search with pagination
                listP = productsDao.searchByKeywordWithPaging(searchQuery, pageNumber, recordsPerPage);
                totalProducts = productsDao.getTotalProductsByKeyword(searchQuery);
            } else if (categoryId > 0) {
                // Filter by category with pagination
                listP = productsDao.getProductsByCategoryIdWithPaging(categoryId, pageNumber, recordsPerPage);
                totalProducts = productsDao.getTotalProductsByCategoryId(categoryId);
            } else {
                // Get all products with pagination
                listP = productsDao.getProductsByPage(pageNumber, recordsPerPage);
                totalProducts = productsDao.getTotalProducts();
            }
            
            int totalPages = (int) Math.ceil((double) totalProducts / recordsPerPage);
            
            request.setAttribute("listP", listP);
            request.setAttribute("searchQuery", searchQuery);
            request.setAttribute("categoryId", categoryId);
            request.setAttribute("currentPage", pageNumber);
            request.setAttribute("totalPages", totalPages);
        %>

        <div class="product-section mt-150 mb-150">
            <div class="container">

                <div class="row">
                    <div class="col-md-12">
                        <div class="product-filters">
                            <ul>
                                <li class="${categoryId == 0 ? 'active' : ''}">
                                    <a href="shop">All</a>
                                </li>
                                <li class="${categoryId == 1 ? 'active' : ''}">
                                    <a href="shop?category=1">Hoa quả nhiệt đới</a>
                                </li>
                                <li class="${categoryId == 2 ? 'active' : ''}">
                                    <a href="shop?category=2">Hoa quả ôn đới</a>
                                </li>
                                <li class="${categoryId == 3 ? 'active' : ''}">
                                    <a href="shop?category=3">Hoa quả cận nhiệt đới</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="row product-lists">
                    <c:choose>
                        <c:when test="${empty listP}">
                            <p>Không tìm thấy sản phẩm nào phù hợp</p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="o" items="${listP}">
                                <div class="col-lg-4 col-md-6 text-center">
                                    <div class="single-product-item">
                                        <div class="product-image">
                                            <img src="assets/img/products/${o.image}" alt="${o.name}">
                                        </div>
                                        <h3>${o.name}</h3>
                                        <p class="product-price"><span>1 Kg</span> ${o.price} </p>
                                        <a href="CartController?action=add&id=${o.id}" class="cart-btn">
                                            <i class="fas fa-shopping-cart"></i> Add to Cart
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div> 
         
        <!<!-- phân trang -->

        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="pagination-wrap">
                    <ul>
                        <!-- Previous page link -->
                        <c:if test="${currentPage > 1}">
                            <li><a href="shop?page=${currentPage - 1}<c:if test="${not empty searchQuery}">&query=${searchQuery}</c:if><c:if test="${categoryId > 0}">&category=${categoryId}</c:if>">Prev</a></li>
                        </c:if>
                        <c:if test="${currentPage == 1}">
                            <li><span class="disabled">Prev</span></li>
                        </c:if>
                        
                        <!-- Page numbers -->
                        <c:forEach begin="1" end="${totalPages > 5 ? 5 : totalPages}" var="i">
                            <c:choose>
                                <c:when test="${currentPage == i}">
                                    <li><a class="active" href="shop?page=${i}<c:if test="${not empty searchQuery}">&query=${searchQuery}</c:if><c:if test="${categoryId > 0}">&category=${categoryId}</c:if>">${i}</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href="shop?page=${i}<c:if test="${not empty searchQuery}">&query=${searchQuery}</c:if><c:if test="${categoryId > 0}">&category=${categoryId}</c:if>">${i}</a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        
                        <!-- Next page link -->
                        <c:if test="${currentPage < totalPages}">
                            <li><a href="shop?page=${currentPage + 1}<c:if test="${not empty searchQuery}">&query=${searchQuery}</c:if><c:if test="${categoryId > 0}">&category=${categoryId}</c:if>">Next</a></li>
                        </c:if>
                        <c:if test="${currentPage == totalPages}">
                            <li><span class="disabled">Next</span></li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
        <!<!-- comment -->
        </div>
    </div>
    <!-- end products -->

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