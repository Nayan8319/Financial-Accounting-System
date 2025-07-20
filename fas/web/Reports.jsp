    <%-- 
    Document   : Reports
    Created on : 29 Dec 2023, 20:40:46
    Author     : NSP
--%>

<%@page import="java.sql.ResultSet"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if test="${process eq 'sales'}">
    <div class="bg-white mt-2 rounded card-header d-flex justify-content-between">
        <div class="d-flex align-items-center">
            <i class="fa-solid fa-person-walking-luggage mx-2"></i>
            Sale Reports
        </div>
        <div>
            <button class="btn btn-success py-2 px-3" onclick="exportExcel()">Export</button>
        </div>
    </div>
    <div id="reportstable" class=" bg-white p-3 rounded shadow overflow-auto">
        <table id="myTable" class="table">
            <thead>
                <tr>
                    <th scope="col">Transaction Id</th>
                    <th scope="col">Party Name</th>
                    <th scope="col">Net Amount</th>
                    <th scope="col">GST Amount</th>
                    <th scope="col">Total Amount</th>
                    <th scope="col">Transport</th>
                    <th scope="col">Transaction Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ResultSet rs = (ResultSet) request.getAttribute("result");
                    while (rs.next()) {
                %>
                <tr>
                    <td><%=rs.getString("transactionId")%></td>
                    <td><%=rs.getString("partyName")%></td>
                    <td><%=rs.getString("netAmt")%></td>
                    <td><%=rs.getString("gstAmt")%></td>
                    <td><%=rs.getString("totalAmt")%></td>
                    <td><%=rs.getString("transport")%></td>
                    <td><%=rs.getString("transactionDate")%></td>
                </tr>
                <%
                    }
                %>              
            </tbody>
        </table>
    </div>

</c:if>

<c:if test="${process eq 'purchase'}">
    <div class="bg-white mt-2 rounded card-header d-flex justify-content-between">
        <div class="d-flex align-items-center">
            <i class="fa-solid fa-person-walking-luggage mx-2"></i>
            Purchase Reports
        </div>
        <div>
            <button class="btn btn-success py-2 px-3" onclick="exportExcel()">Export</button>
        </div>
    </div>
    <div id="reportstable" class=" bg-white p-3 rounded shadow overflow-auto">
        <table id="myTable" class="table">
            <thead>
                <tr>
                    <th scope="col">Transaction Id</th>
                    <th scope="col">Party Name</th>
                    <th scope="col">Net Amount</th>
                    <th scope="col">GST Amount</th>
                    <th scope="col">Total Amount</th>
                    <th scope="col">Transport</th>
                    <th scope="col">Transaction Date</th>
                </tr>
            </thead>

            <tbody>
                <%
                    ResultSet rs2 = (ResultSet) request.getAttribute("result");
                    while (rs2.next()) {
                %>
                <tr>
                    <td><%=rs2.getString("transactionId")%></td>
                    <td><%=rs2.getString("partyName")%></td>
                    <td><%=rs2.getString("netAmt")%></td>
                    <td><%=rs2.getString("gstAmt")%></td>
                    <td><%=rs2.getString("totalAmt")%></td>
                    <td><%=rs2.getString("transport")%></td>
                    <td><%=rs2.getString("transactionDate")%></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</c:if>

<c:if test="${process eq 'products'}">
    <div class="bg-white mt-2 rounded card-header d-flex justify-content-between">
        <div class="d-flex align-items-center">
            <i class="fa-solid fa-person-walking-luggage mx-2"></i>
            Customer Reports
        </div>
        <div>
            <button class="btn btn-success py-2 px-3" onclick="exportExcel()">Export</button>
        </div>
    </div>
    <div id="reportstable" class=" bg-white p-3 rounded shadow overflow-auto">
        <table id="myTable" class="table">
            <thead>
                <tr>
                    <th scope="col">Product Id</th>
                    <th scope="col">Product Name</th>
                    <th scope="col">Price</th>
                    <th scope="col">quantity</th>
                    <th scope="col" class="text-center"> Action </th>
                </tr>
            </thead>

            <tbody>
                <%
                    ResultSet rs3 = (ResultSet) request.getAttribute("result");
                    while (rs3.next()) {
                %>
                <tr>
                    <td><%=rs3.getString("productId")%></td>
                    <td><%=rs3.getString("productName")%></td>
                    <td><%=rs3.getString("price")%></td>
                    <td><%=rs3.getString("quantity")%></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</c:if>

<c:if test="${process eq 'vendor'}">
    <div class="bg-white mt-2 rounded card-header d-flex justify-content-between">
        <div class="d-flex align-items-center">
            <i class="fa-solid fa-person-walking-luggage mx-2"></i>
            Vendor Reports
        </div>
        <div>
            <button class="btn btn-success py-2 px-3" onclick="exportExcel()">Export</button>
        </div>
    </div>
    <div id="reportstable" class=" bg-white p-3 rounded shadow overflow-auto">
        <table id="myTable" class="table">
            <thead>
                <tr>
                    <th scope="col">GST No</th>
                    <th scope="col">Party Name</th>
                    <th scope="col">Address</th>
                    <th scope="col">State</th>
                    <th scope="col">Transport</th>
                    <th scope="col">Broker</th>
                </tr>
            </thead>

            <tbody>
                <%
                    ResultSet rs4 = (ResultSet) request.getAttribute("result");
                    while (rs4.next()) {
                %>
                <tr>
                    <td><%=rs4.getString("gstNo")%></td>
                    <td><%=rs4.getString("partyName")%></td>
                    <td><%=rs4.getString("address")%></td>
                    <td><%=rs4.getString("state")%></td>
                    <td><%=rs4.getString("transport")%></td>
                    <td><%=rs4.getString("broker")%></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>


</c:if>

<c:if test="${process eq 'customers'}">

    <div class="bg-white mt-2 rounded card-header d-flex justify-content-between">
        <div class="d-flex align-items-center">
            <i class="fa-solid fa-person-walking-luggage mx-2"></i>
            Customer Reports
        </div>
        <div>
            <button class="btn btn-success py-2 px-3" onclick="exportExcel()">Export</button>
        </div>
    </div>
    <div id="reportstable" class=" bg-white p-3 rounded shadow overflow-auto">
        <table id="myTable" class="table">
            <thead>
                <tr>
                    <th scope="col">Party Id</th>
                    <th scope="col">Party Name</th>
                    <th scope="col">Phone No</th>
                    <th scope="col">Address</th>
                    <th scope="col">City</th>
                    <th scope="col">State</th>
                </tr>
            </thead>

            <tbody>
                <%
                    ResultSet rs5 = (ResultSet) request.getAttribute("result");
                    while (rs5.next()) {
                %>
                <tr>
                    <td><%=rs5.getString("partyId")%></td>
                    <td><%=rs5.getString("partyName")%></td>
                    <td><%=rs5.getString("phoneNo")%></td>
                    <td><%=rs5.getString("address")%></td>
                    <td><%=rs5.getString("city")%></td>
                    <td><%=rs5.getString("state")%></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

</c:if>

