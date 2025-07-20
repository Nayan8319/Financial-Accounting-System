<%-- 
    Document   : AdminDashboard
    Created on : 28 Dec 2023, 08:34:53
    Author     : NSP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
    <head>

        <!-- Session managment -->
        <%
            if (session.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Admin Dashboard</title>
        <link href="//cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="//cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

        <!--Already written -->
        <link href="css/index.css" rel="stylesheet">


        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    </head>

    <body>
        <!-- Dashboard -->
        <div class="d-flex flex-column flex-lg-row h-lg-full bg-surface-secondary">
            <!-- Vertical Navbar -->
            <nav class="navbar show navbar-vertical h-lg-screen navbar-expand-lg px-0 py-3 navbar-light bg-white border-bottom border-bottom-lg-0 border-end-lg w-25" id="navbarVertical">

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
                    <a class="navbar-brand text-center font-bold p-0 d-flex align-items-center justify-content-center pb-lg-3" href="#">
                        <p class="m-0">
                            <span class="text-primary">FINANCIAL SYSTEM</span>
                        </p>
                    </a>

                    <!-- Divider-->
                    <hr class="dropdown-divider my-0 d-none d-lg-block border border-none" />

                    <!-- User menu (mobile) -->
                    <div class="navbar-user d-lg-none">
                        <!-- Dropdown -->
                        <div class="dropdown">
                            <!-- Toggle -->
                            <a href="#" id="sidebarAvatar"role="button" data-bs-toggle="dropdown"aria-haspopup="true" aria-expanded="false"class=""></a>
                        </div>
                    </div>
                    <!-- Collapse -->
                    <div class="navbar-collapse collapse show" id="sidebarCollapse">
                        <!-- Navigation -->
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link d-md-flex d-lg-block justify-content-center px-4" href="#" onclick="dashboardContent('dashboardContent')">
                                    <i class="fa-solid fa-house"></i> Home
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link d-md-flex d-lg-block justify-content-center px-4" href="#" onclick="reports('sales')">
                                    <i class="fa-solid fa-dollar-sign"></i> Sales report
                                </a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link d-md-flex d-lg-block justify-content-center px-4" href="#" onclick="reports('products');">
                                    <i class="fa-solid fa-cart-shopping"></i> Product report
                                </a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link d-md-flex d-lg-block justify-content-center px-4" href="#" onclick="reports('customers')">
                                    <i class="fa-solid fa-person-walking-luggage"></i> Customer report
                                </a>
                            </li>                          
                            <li class="nav-item">
                                <a class="nav-link d-md-flex d-lg-block justify-content-center px-4" href="#" onclick="reports('customers')">
                                    <i class="fa-solid fa-chart-simple"></i> Profit Loss Statement
                                </a>
                            </li>                          
                            <li class="nav-item">
                                <a class="nav-link d-md-flex d-lg-block justify-content-center px-4" href="#" onclick="User('viewUser');">
                                    <i class="fa-solid fa-users"></i> User Management
                                </a>
                            </li>
                        </ul>

                        <!-- Push content down -->
                        <div class="mt-auto"></div>

                        <!-- User (md) -->
                        <ul class="navbar-nav">

                            <li class="nav-item">
                                <a class="nav-link d-md-flex d-lg-block justify-content-center px-4" href="#" onclick="setPage('Profile')">
                                    <i class="fa-solid fa-gear"></i> Profile
                                </a>
                            </li>

                            <!--style="background-color: #bd1e1e ;"-->
                            <li class="nav-item bg-danger" id="logoutbtn" onclick="logout()" >
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
                <header class="bg-surface-primary border-bottom container-fluid">
                    <div class="row align-items-center py-3">
                        <h1 class="h2 mb-0 ls-tight" id="pageTitle">Admin Dashboard</h1>
                    </div>
                </header>

                <!-- Main -->
                <main class="bg-surface-primary">
                    <div class="container-fluid pb-1" id="mainDiv">
                        <!-- content to be added -->

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


