
<%@page contentType="text/html" pageEncoding="UTF-8"%>  

<html lang="en">
    <head>
        <!-- Session managment -->
        <%
            if (session.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
            }
            String permission = (String) session.getAttribute("permission");
        %>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Home</title>
        <!--Already written -->
        <link href="css/index.css" rel="stylesheet">
        <script src="js/Transaction.js"></script>
        <link href="//cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="//cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    </head>
    <body>
        <!-- Dashboard -->
        <div class="d-flex flex-column flex-lg-row h-lg-full bg-surface-secondary">
            <!-- Vertical Navbar -->
            <nav class="d-print-none navbar show navbar-vertical h-lg-screen navbar-expand-lg px-0 py-3 navbar-light bg-white border-bottom border-bottom-lg-0 border-end-lg w-25" id="navbarVertical">
                <div class="container-fluid">
                    <!-- Toggler -->
                    <button
                        class="navbar-toggler ms-n2"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#sidebarCollapse"
                        aria-controls="sidebarCollapse"
                        aria-expanded="true"
                        aria-label="Toggle navigation">

                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <!-- Brand -->
                    <a class="navbar-brand py-lg-2 mb-lg-2 px-lg-6 me-0 text-center d-flex align-items-center justify-content-center" href="#">
                        <h3 class="d-flex align-items-center flex-column mb-0">
                            <span class="text-primary d-none d-lg-block"> F M S PVT.LTD </span>
                            <span class="text-secondary text-center d-none d-lg-block"> (<%=session.getAttribute("user")%>) </span>
                            <span class="text-primary d-lg-none"> Finance - User </span>
                        </h3>
                    </a>

                    <!-- Divider-->
                    <hr class="dropdown-divider my-0 d-none d-lg-block border" />

                    <!-- User menu (mobile) -->
                    <div class="navbar-user d-lg-none">
                        <!-- Dropdown -->
                        <div class="dropdown">
                            <!-- Toggle -->
                            <a
                                href="#"
                                id="sidebarAvatar"
                                role="button"
                                data-bs-toggle="dropdown"
                                aria-haspopup="true"
                                aria-expanded="false"
                                class=""
                                > 
                            </a>
                        </div>
                    </div>
                    <!-- Collapse -->
                    <div class="navbar-collapse collapse show" id="sidebarCollapse">
                        <!-- Navigation -->
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link d-md-flex d-lg-block justify-content-center px-4 active px-4 active" href="#" onclick="dashboardContent('dashboardContent')">
                                    <i class="fa-solid fa-house"></i> Home
                                </a>
                            </li>

                            <%
                                if (permission != null) {

                                    if (permission.contains("sales")) {
                            %>
                            <li class="nav-item">
                                <a class="nav-link d-md-flex d-lg-block justify-content-center px-4 active" href="#" onclick="Salestransaction()">
                                    <i class="fa-solid fa-dollar-sign"></i> Sales Transaction
                                </a>
                            </li>
                            <%
                                }
                            %>

                            

                            <%  if (permission.contains("products")) { %>
                            <li class="nav-item">
                                <a class="nav-link d-md-flex d-lg-block justify-content-center px-4 active" href="#" onclick="products('products');">
                                    <i class="fa-solid fa-cart-shopping"></i> Product Management
                                </a>
                            </li>
                            <% } %>

                            <%  if (permission.contains("customers")) { %>
                            <li class="nav-item">
                                <a class="nav-link d-md-flex d-lg-block justify-content-center px-4 active" href="#" onclick="party('customers')">
                                    <i class="fa-solid fa-person-walking-luggage"></i> Customer Management
                                </a>
                            </li>
                            <% } %>
                            <% } %>
                            
                            <li class="nav-item">
                                <a class="nav-link d-md-flex d-lg-block justify-content-center px-4 active px-4 active"  onclick="viewAllPayments('viewAllPayments')">
                                    <i class="fa-solid fa-gear"></i> All Payments
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link d-md-flex d-lg-block justify-content-center px-4 active px-4 active"  onclick="profile('profile')">
                                    <i class="fa-solid fa-gear"></i> Profile
                                </a>
                            </li>
                        </ul>

                        <!-- Push content down -->
                        <div class="mt-auto"></div>

                        <!-- User (md) -->
                        <ul class="navbar-nav">
                            <li id="logoutbtn" class="nav-item bg-danger" onclick="logout()" style="background-color: #bd1e1e ;">
                                <a class="nav-link text-white bg-danger logoutbtn d-md-flex d-lg-block justify-content-center px-4"
                                   href="#">
                                    <i class="fa-solid fa-right-from-bracket text-white"></i> Logout
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>


            <!-- Main content -->
            <div class="h-screen flex-grow-1 overflow-y-lg-auto w-75">

                <!-- Header -->
                <header class="bg-surface-secondary border-bottom container-fluid d-print-none">
                    <div class="row align-items-center py-3">
                        <h2 class=" mb-0 ls-tight " id="pageTitle"></h2>
                    </div>
                </header>

                <!-- Main -->
                <main class="bg-surface-primary">
                    <div class="container-fluid pb-2 " id="mainDiv">



                    </div>   
                </main>

            </div>
        </div>

        <!-- Bootstrap v5.3.1 -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.1/js/bootstrap.min.js" integrity="sha512-fHY2UiQlipUq0dEabSM4s+phmn+bcxSYzXP4vAXItBvBHU7zAM/mkhCZjtBEIJexhOMzZbgFlPLuErlJF2b+0g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <!-- My script -->
        <script src="js/AdminDashboard.js"></script>

        <!-- Already written script -->
        <script src="js/script.js"></script>

    </body>
</html>






<!--if (permission.contains("vendors")) {-->

<!--<li class="nav-item">
    <a class="nav-link d-md-flex d-lg-block justify-content-center px-4 active" href="#" onclick="party('vendors')">
        <i class="fa-solid fa-store"></i> Vendor Management
    </a>             
</li>-->

<!--}-->
<!--<//% if (permission.contains("purchase")) { %>
                            <li class="nav-item">
                                <a class="nav-link d-md-flex d-lg-block justify-content-center px-4 active" href="#" onclick="Purchasetransaction();">
                                    <i class="fa-solid fa-bag-shopping"></i> Purchase Transaction
                                </a>
                            </li>
                           <//% }%>--!>