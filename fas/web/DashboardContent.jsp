<%-- 
    Document   : DashboardContent
    Created on : 29 Dec 2023, 19:57:51
    Author     : NSP
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>

<c:if test="${process eq 'dashboardContent' }">

    <style>
        /* Webpixels CSS */
        /* Utility and component-centric Design System based on Bootstrap for fast, responsive UI development */
        /* URL: https://github.com/webpixels/css */

        @import url(https://unpkg.com/@webpixels/css@1.1.5/dist/index.css);

        /* Bootstrap Icons */
        @import url("https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.4.0/font/bootstrap-icons.min.css");

    </style>
    <main class="py-6 bg-surface-secondary">
        <div class="container-fluid">
            <!-- Card stats -->
            <%
                ResultSet rsProducts = (ResultSet) request.getAttribute("rsProducts");
                ResultSet rsCustomers = (ResultSet) request.getAttribute("rsCustomers");
                ResultSet rsSales = (ResultSet) request.getAttribute("rsSales");
                ResultSet rsTotalSales = (ResultSet) request.getAttribute("rsTotalSales");
                ResultSet rsLastYearSales = (ResultSet) request.getAttribute("rsLastYearSales");
                ResultSet rsAllCustomers = (ResultSet) request.getAttribute("rsAllCustomers");
                ResultSet rsAllProducts = (ResultSet) request.getAttribute("rsAllProducts");
                ResultSet rsAllSales = (ResultSet) request.getAttribute("rsAllSales");
                if (rsProducts.next()) {
            %>
            <div class="row g-6 mb-6">
                <div class="col-xl-4 col-sm-8 col-16">
                    <div class="card shadow border-0">
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <span class="h6 font-semibold text-muted text-sm d-block mb-2">Products</span>
                                    <span class="h3 font-bold mb-0">
                                        <%=rsProducts.getString("countProduct")%>
                                    </span>
                                </div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-tertiary text-white text-lg rounded-circle"onclick="products('products')">
                                        <i class="bi bi-minecart-loaded" ></i>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-2 mb-0 text-sm">
                                <span class="badge badge-pill bg-soft-success text-success me-2">
                                    <i class="bi bi-arrow-up me-1"></i>
                                </span>
                                <span class="text-nowrap text-xs text-muted">Total Amount Of Products</span>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                    if (rsCustomers.next()) {
                %>
                <div class="col-xl-4 col-sm-8 col-16">
                    <div class="card shadow border-0">
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <span class="h6 font-semibold text-muted text-sm d-block mb-2">Customers</span>
                                    <span class="h3 font-bold mb-0">
                                        <%=rsCustomers.getString("countCustomers")%>
                                    </span>
                                </div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-primary text-white text-lg rounded-circle"onclick="party('customers')">
                                        <i class="bi bi-people" ></i>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-2 mb-0 text-sm">
                                <span class="badge badge-pill bg-soft-success text-success me-2">
                                    <i class="bi bi-arrow-up me-1"></i>30%
                                </span>
                                <span class="text-nowrap text-xs text-muted">Total Amount Of Customers</span>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                    if (rsSales.next()) {
                %>
                <div class="col-xl-4 col-sm-8 col-16">
                    <div class="card shadow border-0">
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <span class="h6 font-semibold text-muted text-sm d-block mb-2">Total Sales</span>
                                    <span class="h3 font-bold mb-0">
                                        <%=rsSales.getString("countSales")%>
                                    </span>
                                </div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-info text-white text-lg rounded-circle" onclick="viewAllSales()" >
                                        <i class="bi bi-cart4" ></i>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-2 mb-0 text-sm">
                                <span class="badge badge-pill bg-soft-success text-success me-2">
                                    <i class="bi bi-arrow-up me-1"></i>
                                </span>
                                <span class="text-nowrap text-xs text-muted">All Time Sales Amount</span>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                    if (rsTotalSales.next()) {
                %> 
                <div class="col-xl-4 col-sm-8 col-16">
                    <div class="card shadow border-0">
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <span class="h6 font-semibold text-muted text-sm d-block mb-2">Total Sale Amount</span>
                                    <span class="h3 font-bold mb-0">
                                        <%=rsTotalSales.getString("rsTotalSales")%>
                                    </span>
                                </div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-warning text-white text-lg rounded-circle" onclick="viewAllPayments('viewAllPayments')">
                                        <i class="bi bi-credit-card"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-2 mb-0 text-sm">
                                <span class="badge badge-pill bg-soft-success text-success me-2">
                                    <i class="bi bi-arrow-up me-1"></i>
                                </span>
                                <span class="text-nowrap text-xs text-muted">Since last Year Sales Amount</span>
                            </div>
                        </div>
                    </div>
                </div>
                <!--for last yeart sale count-->
                <%
                    }
                    if (rsLastYearSales.next()) {
                %> 
                <div class="col-xl-4 col-sm-8 col-16">
                    <div class="card shadow border-0">
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <span class="h6 font-semibold text-muted text-sm d-block mb-2">Last Year Total Sale</span>
                                    <span class="h3 font-bold mb-0">
                                        <%=rsLastYearSales.getString("last_year_count")%>
                                    </span>
                                </div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-warning text-white text-lg rounded-circle" onclick="viewAllSales()" >
                                        <i class="bi bi-clock-history"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-2 mb-0 text-sm">
                                <span class="badge badge-pill bg-soft-success text-success me-2">
                                    <i class="bi bi-arrow-up me-1"></i>
                                </span>
                                <span class="text-nowrap text-xs text-muted">Since last Year Total Sales</span>
                            </div>
                        </div>
                    </div>
                </div>
                <!--for last year sale Amount-->

                <div class="col-xl-4 col-sm-8 col-16">
                    <div class="card shadow border-0">
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <span class="h6 font-semibold text-muted text-sm d-block mb-2">Last Year Sale Amount</span>
                                    <span class="h3 font-bold mb-0">
                                        <%=rsLastYearSales.getString("last_year_total")%>
                                    </span>
                                </div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-warning text-white text-lg rounded-circle" onclick="viewAllPayments('viewAllPayments') >
                                                <i class="bi bi-clock-history "></i>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-2 mb-0 text-sm">
                                <span class="badge badge-pill bg-soft-success text-success me-2">
                                    <i class="bi bi-arrow-up me-1"></i>
                                </span>
                                <span class="text-nowrap text-xs text-muted">Since last Year Sales Amount</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--for customer Parts-->                                    
            <div class="card shadow border-0 mb-7">
                <div class="care-header mt-2 mb-2 ">
                    <button class="btn btn-outline-primary" style="margin-left: 10px"onclick="party('customers')">View Customers</button>
                </div>
                <div class="table-responsive">

                    <table class="table table-hover table-nowrap">
                        <thead class="thead-light">
                            <tr>
                                <th scope="col">Party Name</th>
                                <th scope="col">Phone No</th>
                                <th scope="col">Address</th>
                                <th scope="col">City</th>
                                <th scope="col">State</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                }
                                while (rsAllCustomers.next()) {
                            %>
                            <tr>
                                <td>
                                    <img alt="..." src="https://preview.webpixels.io/web/img/other/logos/logo-3.png" class="avatar avatar-xs rounded-circle me-2">
                                    <a class="text-heading font-semibold" href="#">
                                        <%=rsAllCustomers.getString("partyName")%>
                                    </a>
                                </td>
                                <td> 
                                    <span class="badge badge-lg badge-dot">
                                        <i class="bg-success"></i>
                                        <%=rsAllCustomers.getString("phoneNo")%>
                                    </span>
                                </td>
                                <td>
                                    <span class="badge badge-lg badge-dot">
                                        <i class="bg-success"></i>
                                        <%=rsAllCustomers.getString("address")%>
                                    </span>
                                </td>
                                <td>
                                    <span class="badge badge-lg badge-dot">
                                        <i class="bg-success"></i>
                                        <%=rsAllCustomers.getString("city")%>
                                    </span>
                                </td>
                                <td>
                                    <span class="badge badge-lg badge-dot">
                                        <i class="bg-success"></i>
                                        <%=rsAllCustomers.getString("state")%>
                                    </span>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!--for products data-->                                  
            <div class="card shadow border-0 mb-7">
                <div class="care-header mt-2 mb-2 ">
                    <button class="btn btn-outline-primary" style="margin-left: 10px"onclick="products('products')">View Products</button>
                </div>
                <div class="table-responsive">

                    <table class="table table-hover table-nowrap">
                        <thead class="thead-light">
                            <tr>
                                <th scope="col">Product Id</th>
                                <th scope="col">Name</th>
                                <th scope="col">Price</th>
                                <th scope="col">Quantity</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                while (rsAllProducts.next()) {
                            %>
                            <tr>
                                <td>
                                    <img alt="..." src="https://preview.webpixels.io/web/img/other/logos/logo-5.png" class="avatar avatar-xs rounded-circle me-2">
                                    <a class="text-heading font-semibold" href="#">
                                        <%=rsAllProducts.getString("productId")%>
                                    </a>
                                </td>
                                <td> 
                                    <span class="badge badge-lg badge-dot">
                                        <i class="bg-success"></i>
                                        <%=rsAllProducts.getString("productName")%>
                                    </span>
                                </td>
                                <td>
                                    <span class="badge badge-lg badge-dot">
                                        <i class="bg-success"></i>
                                        <%=rsAllProducts.getString("price")%>
                                    </span>
                                </td>
                                <td>
                                    <span class="badge badge-lg badge-dot">
                                        <i class="bg-success"></i>
                                        <%=rsAllProducts.getString("quantity")%>
                                    </span>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</c:if>








<!--ex2-->
<!--    <head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Financial Statistics Dashboard</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4"></script>

Custom CSS 
<style>
body {
font-family: Arial, sans-serif;
}
.container {
padding-top: 10px; /* Adjust the margin to accommodate the sidebar width */
}

.card {
border: none;
box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
transition: 0.3s;
padding: 20px;
text-align: center;
}

.card:hover {
box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.fa-chart-line {
color: #007BFF;
font-size: 40px;
}

.fa-dollar-sign {
color: #28A745;
font-size: 40px;
}

.fa-users {
color: #FFC107;
font-size: 40px;
}

.chart-container {
margin-top: 30px;
}

/* Print button */
.print-button {
position: fixed;
bottom: 20px;
right: 20px;
background-color: #007BFF;
color: #fff;
padding: 10px 20px;
border: none;
cursor: pointer;
border-radius: 5px;
}
</style>
</head>

<body>
Main Content 
<div class="container">
<div class="row">
<div class="col-md-4">
<div class="card">
<i class="fas fa-chart-line"></i>
<h2>Revenue</h2>
<p>$1,000,000</p>
</div>
</div>
<div class="col-md-4">
<div class="card">
<i class="fas fa-dollar-sign"></i>
<h2>Profit</h2>
<p>$500,000</p>
</div>
</div>
<div class="col-md-4">
<div class="card">
<i class="fas fa-users"></i>
<h2>Customers</h2>
<p>10,000</p>
</div>
</div>
</div>

<div class="row chart-container">
<div class="col-md-6">
<canvas id="salesByCountryChart"></canvas>
</div>
<div class="col-md-6">
<canvas id="topSellingProductsChart"></canvas>
</div>
</div>

Pie chart for Sales by Sales Executives 
<div class="row chart-container">
<div class="col-md-6">
<canvas id="salesByExecutivesChart"></canvas>
</div>
<div class="col-md-6">
Percentage of Sales Increment Chart 
<canvas id="salesIncrementChart"></canvas>
</div>
</div>
</div>

Print Button 
<button class="print-button" onclick="window.print()"><i class="fas fa-print"></i> Print</button>

Bootstrap JS and Popper.js via CDN (for Bootstrap components) 
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.min.js"></script>


</body>-->


