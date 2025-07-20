<%-- 
    Document   : Sale
    Created on : 29 Dec 2023, 22:00:08
    Author     : NSP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@page  import="java.sql.ResultSet" %>
<%
    String salesPermission = (String) session.getAttribute("salePermission");
%>

<c:if  test="${process eq 'sales'}">
    <br/>
    <div id="dataLoader" class="card mt-2" >

    </div> 
    <div class="d-flex justify-content-around  md-5 pd-5 " id="BTNcontainer" style="display:block">
        <%
            if (salesPermission != null) {

                if (salesPermission.contains("add")) {
        %>
        <button  id="newbtn"  type="button" onclick="newTransaction()"  class="btn btn-outline-dark w-25 m-2">New</button>
        <% }
            if (salesPermission.contains("update")) { %>
        <button id="editbtn" type="button" onclick="editTransaction()" class="btn btn-outline-danger w-25 m-2">Update</button>
        <% }
            if (salesPermission.contains("delete")) { %>
        <button id="deletebtn" type="button" onclick="deleteTransaction('sales')"  class="btn btn-outline-dark  w-25 m-2">Delete</button>
        <% }
            if (salesPermission.contains("view")) { %>
        <button id="viewbtn" type="button" onclick="viewAllSales()"  class="btn btn-outline-danger w-25 m-2" onclick="ViewAllData('${process}')">View All</button>
        <% }
            }%>
    </div>
</div>
</c:if>

<c:if test="${process eq 'saleslast' or process eq 'EditViewData' }">
    <style>
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        input[type=number] {
            -moz-appearance: textield;
        }
    </style>
    <%
        ResultSet result1 = (ResultSet) request.getAttribute("result");

        if (result1.next() == false) {
    %>
    <form id="formINPUT" autocomplete="off">
        <div class="p-2">
            <div id="useridDiv" class="form-group">
                <label for="name">Transaction Id:</label>
                <input type="text" disabled id="id" class="form-control"  name="id" value="">
            </div><br/>
            <div class="form-group">
                <label for="name">Party Name:</label>
                <input type="text" disabled  class="form-control" onfocus="showList('party', this)" onkeyup="filterList(this)" onblur="removeList()" id="partyName"  value="">
            </div><br/> 

            <div class="d-flex justify-content-between align-items-center">
                <label>Items:</label>
                <button class="btn btn-success" onclick="return addItemsRow()"><i class="fa-solid fa-cart-plus"></i></button>
            </div>
            <div id="itemContainer" class="card shadow bg-light mt-2 border border-dark">
                <div class="row text-dark font-weight-bold">
                    <div class="col">#</div>
                    <div class="col">Name</div>
                    <div class="col">Rate</div>
                    <div class="col">Quantity</div>
                    <div class="col">Net Amt</div>
                    <div class="col">GST per</div>
                    <div class="col">GST Amt</div>
                    <div class="col">Total Amt</div>
                </div>
                <div class="cointainer " id="itemsList">
                    <div class="row " >
                        <div  style="width: 150px;">
                            <input style="width: 150px;"  class="col bg-white border border-dark" onkeyup="changeTotals()" type="number" disabled value="1"></div>&nbsp;
                        <div style="width: 150px;">
                            <input  style="width: 150px;" class="col bg-white border border-dark" id="productName"  type="text" onfocus="showList('product', this)" onblur="removeList()" onkeyup="filterList(this);changeTotals()" value=""></div>&nbsp;
                        <div style="width: 150px;">
                            <input  style="width: 150px;"class="col bg-white border border-dark" id="rate" type="number" onkeyup="changeTotals()" value=""></div>&nbsp;
                        <div style="width: 150px;">
                            <input  style="width: 150px;"class="col bg-white border border-dark" id="quantity" type="number" onkeyup="changeTotals()" value=""></div>&nbsp;
                        <div style="width: 150px;">
                            <input  style="width: 150px;"class="col bg-white border border-dark"id="netAmt" type="number" onkeyup="changeTotals()" value=""></div>&nbsp;
                        <div style="width: 150px;">
                            <input style="width: 150px;"class="col bg-white border border-dark" id="gstPer" type="number" onkeyup="changeTotals()" value=""></div>&nbsp;
                        <div style="width: 150px;">
                            <input style="width: 150px;"class="col bg-white border border-dark" id="gstAmt" type="number" onkeyup="changeTotals()" value=""></div>&nbsp;
                        <div style="width: 150px;">
                            <input style="width: 150px;"class="col bg-white border border-dark" id="totalAmt" type="number" onkeyup="changeTotals()" value=""></div>
                    </div>

                </div>
                <div id="itemFooter" class="row text-dark font-weight-bold">
                    <div class="col"></div>
                    <div class="col"></div>
                    <div class="col"></div>
                    <div class="col"></div>
                    <div id="netAmt" class="col">0</div>
                    <div class="col"></div>
                    <div id="gstAmt" class="col">0</div>
                    <div id="totalAmt" class="col">0</div>
                </div>
            </div>
            <div class="form-group">
                <label for="address">Transport:</label>
                <input type="text" disabled class="form-control" id="transport" name="address" value="">
            </div><br/>
            <div class="form-group">
                <label for="date">Transaction Date:</label>
                <input type="date" disabled class="form-control" id="transactionDate" name="date" value="">
            </div><br/>
            <div class="d-flex">
                <input  class="btn btn-outline-primary w-25 m-2" style=" background-color: #b2d5f7;display:none"  id="submitNew" onclick="return AddTransaction('sales')" type="button" value="Submit"> 
                <input  class="btn btn-outline-primary w-25 m-2" style=" background-color: #b2d5f7;display: none" id="submitUpdate" onclick="return UpdateTransaction('sales')" type="button" value="submit"> 
                <input  class="btn btn-outline-danger w-25 m-2" style=" background-color: #f37a7a;display: none" id="cancelBtn" onclick="CancelBtn('sales')" type="button" value="Cancel"> 
            </div>

        </div>
    </form>
    <%
    } else {
        do {
    %>
    <!--<h2 class="mt-5"><center>SALES REPORT</center></h2>-->  
    <form id="formINPUT" autocomplete="off">
        <div class="p-2">
            <div id="useridDiv" class="form-group">
                <label for="name">Transaction Id:</label>
                <input type="text" disabled id="id" class="form-control"  name="id" value="<%=result1.getInt("transactionId")%>">
            </div><br/>
            <div class="form-group">
                <label for="name">Party Name:</label>
                <input type="text" disabled  class="form-control" id="partyName" onfocus="showList('party', this)" onblur="removeList()" onkeyup="filterList(this)" value="<%=result1.getString("partyName")%>">
            </div><br/>

            <div class="d-flex justify-content-between align-items-center">
                <label>Items:</label>
                <button class="btn btn-success" onclick="return addItemsRow()"><i class="fa-solid fa-cart-plus"></i></button>
            </div>
            <div id="itemContainer" class="card shadow bg-light mt-2 border border-dark">
                <div class="row text-dark font-weight-bold border ">
                    <div class="col">#</div>
                    <div class="col">Name</div>
                    <div class="col">Rate</div>
                    <div class="col">Quantity</div>
                    <div class="col">Net Amt</div>
                    <div class="col">GST per</div>
                    <div class="col">GST Amt</div>
                    <div class="col">Total Amt</div>
                </div>
                <div class="overflow-auto h-40" id="itemsList">
                    <%
                        int rowCount = 0;
                        ResultSet resultItem = (ResultSet) request.getAttribute("result1");
                        while (resultItem.next()) {
                            ++rowCount;
                    %>
                    <div class="row  row<%=rowCount%>">
                        <div style="width: 150px;"><input style="width: 150px;"class="col bg-white border border-dark" id="id"  onkeyup="changeTotals()" type="number" disabled value="<%=rowCount%>"></div>&nbsp;
                        <div style="width: 150px;"><input style="width: 150px;"class="col bg-white border border-dark" id="productName" type="text" onfocus="showList('product', this)" onblur="removeList()" onkeyup="filterList(this);changeTotals()" value="<%=resultItem.getString("itemName")%>"></div>&nbsp;
                        <div style="width: 150px;"><input style="width: 150px;"class="col bg-white border border-dark" id="rate" type="number" onkeyup="changeTotals()" value="<%=resultItem.getString("rate")%>"></div>&nbsp;
                        <div style="width: 150px;"><input style="width: 150px;"class="col bg-white border border-dark" id="quantity" type="number" onkeyup="changeTotals()" value="<%=resultItem.getString("quantity")%>"></div>&nbsp;
                        <div style="width: 150px;"><input  style="width: 150px;"class="col bg-white border border-dark" id="netAmt" type="number" onkeyup="changeTotals()" value="<%=resultItem.getString("netAmt")%>"></div>&nbsp;
                        <div style="width: 150px;"><input  style="width: 150px;"class="col bg-white border border-dark" id="gstPer" type="number" onkeyup="changeTotals()" value="<%=resultItem.getString("gstPer")%>"></div>&nbsp;
                        <div style="width: 150px;"><input style="width: 150px;" class="col bg-white border border-dark" id="gstAmt"type="number" onkeyup="changeTotals()" value="<%=resultItem.getString("gstAmt")%>"></div>&nbsp;
                        <div style="width: 150px;"><input style="width: 150px;"class="col bg-white border border-dark" id="totalAmt" type="number" onkeyup="changeTotals()" value="<%=resultItem.getString("totalAmt")%>"></div>
                    </div>
                    <%
                        }
                    %>
                </div>
                <div id="itemFooter" class="row text-dark font-weight-bold">
                    <div class="col"></div>
                    <div  class="col"></div>
                    <div  id="rate" class="col"></div>
                    <div id="quantity"class="col"></div>
                    <div id="netAmt" class="col"><%=result1.getString("netAmt")%></div>
                    <div class="col"></div>
                    <div id="gstAmt" class="col"><%=result1.getString("gstAmt")%></div>
                    <div id="totalAmt" class="col"><%=result1.getString("totalAmt")%></div>
                </div>
            </div>
            <div class="form-group">
                <label for="address">Transport:</label>
                <input type="text" disabled class="form-control" id="transport" name="address" value="<%=result1.getString("transport")%>">
            </div><br/>
            <div class="form-group">
                <label for="email">Transaction Date:</label>
                <input type="date" disabled class="form-control" id="transactionDate" name="email" value="<%=result1.getDate("transactionDate")%>">
            </div><br/>
            <%
                    } while (result1.next());
                }

            %>
            <div class="d-flex">
                <input  class="btn btn-outline-primary w-25 m-2" style=" background-color: #b2d5f7;display:none"  id="submitNew" onclick="return AddTransaction('sales')" type="button" value="Submit"> 
                <input  class="btn btn-outline-primary w-25 m-2" style=" background-color: #b2d5f7;display: none" id="submitUpdate" onclick="return UpdateTransaction('sales')" type="button" value="submit"> 
                <input  class="btn btn-outline-danger w-25 m-2" style=" background-color: #f37a7a;display: none" id="cancelBtn" onclick="CancelBtn('sales')" type="button" value="Cancel"> 
            </div>
        </div>
        <div class="saleInputData"></div>
    </form>

</c:if>

<c:if test="${process eq 'salesupdate' or process eq 'AddTransaction' or process eq 'deleteSales'}">
    <input type="hidden" value="${status}" id="UpdateDelete">
</c:if>

<c:if test="${process eq 'Allsales'}">
    <div class="bg-white mt-2 rounded card-header d-flex justify-content-between">
        <div class="d-flex align-items-center">
            <i class="fa-solid fa-person-walking-luggage mx-2"></i>
            Sale Transaction Details
        </div>
        <div>
            <button class="btn btn-success py-2 px-3" onclick="exportExcel()">Export</button>
        </div>
    </div>
    <div id="reportstable" class=" bg-white p-3 rounded shadow overflow-auto">
        <table id="myTable" class="table">
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Name</th>                    
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Net Amt</th>
                    <th>GSt Amt</th>
                    <th>Total Amt</th>
                    <th>Transport</th>
                    <th>Date</th>
                    <th>Action</th>
                    <th>Action</th>
                </tr>
            </thead> 
            <tbody>
                <%                    ResultSet result = (ResultSet) request.getAttribute("result");
                    while (result.next()) {
                %>
                <tr>
                    <td><%=result.getInt("transactionId")%></td>
                    <td><%=result.getString("partyName")%></td>
                    <td><%=result.getString("productName")%></td>
                    <td><%=result.getInt("quantity")%></td>
                    <td><%=result.getInt("netAmt")%></td>
                    <td><%=result.getInt("gstAmt")%></td>
                    <td><%=result.getInt("totalAmt")%></td>
                    <td><%=result.getString("transport")%></td>
                    <td><%=result.getString("transactionDate")%></td>
                    <td>
                        <button type="button" onclick=" dataToInput(this, 'sales')" rowid="<%=result.getInt("transactionId")%>"  class="px-2 py-2 rounded btn-warning" style="width: 60px" data-bs-target="#" >View</button>
                    </td>
                    <td>
                        <button type="button"onclick="payment(this, 'payment')" rowid="<%=result.getInt("transactionId")%>" class="px-2 py-2 rounded btn-primary" style="width: 60px" data-bs-target="#" >Pay</button>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</c:if>


<c:if test="${process eq 'payment'}">
    <title>Payment Method Page</title>
    <script src="js/Transaction.js"></script>
    <link rel="stylesheet" href="css/payment.css"/>
    <div class="card">
        <!--        <div class="card-title">
                    
                </div>-->
        <div class="card-body">
            <h2 class="d-flex">Payment</h2>
            <div class="payment-type">
                <h4>Check and Fill The Information And Make payments.</h4>
            </div>
            <%
                ResultSet rs = (ResultSet) request.getAttribute("rs");
                while (rs.next()) {
            %>
            <form Class='paymentInfo'>
                <div class="payment-info flex justify-space-between" id="paymentInfo">

                    <div class="column billing">
                        <div class="title">
                            <div class="num">1</div>
                            <h4>Billing Info</h4>
                        </div>
                        <div class="flex justify-space-between">
                            <div class="field half">
                                <label for="paymentId">Payment Id</label>
                                <input id="paymentId" name="paymentId" type="text" placeholder="001">
                            </div>
                            <div class="field half">
                                <label for="transactionId">Transaction Id</label>
                                <input id="transactionId" name="transactionId" type="text" placeholder="001"value=" <%=rs.getString("transactionId")%>">
                            </div>
                        </div>
                        <div class="field full">
                            <label for="transactionDate">Transaction Date</label>
                            <input id="transactionDate" name="transactionDate" type="text"  value=" <%=rs.getString("transactionDate")%>">
                        </div>
                        <div class="field full">
                            <label for="partyName">Customer Name</label>
                            <input id="partyName" name="partyName" type="text"  value=" <%=rs.getString("partyName")%>">
                        </div>

                        <div class="field full">
                            <label for="address">Billing Address</label>
                            <input id="address" name="address"type="text" placeholder="Billing Address">
                        </div>

                        <div class="flex justify-space-between">
                            <div class="field half">
                                <label for="city">City</label>
                                <input id="city" name="city" type="text" placeholder="City">
                            </div>
                            <div class="field half">
                                <label for="state">State</label>
                                <input id="state" name="state "type="text" placeholder="State">
                            </div>
                        </div>

                        <div class="field full">
                            <label for="transport">Transport</label>
                            <input id="transport" name="transport"type="text" value="<%=rs.getString("transport")%>">
                        </div>

                    </div>
                    <div class="column shipping" id="cardDiv">
                        <div class="title">
                            <div class="num">2</div>
                            <h4>Product Info</h4>
                        </div>
                        <div class="field full">
                            <label for="productName">Product Name</label>
                            <input id="productName" name="productName" type="text" placeholder="Enter Product Name"value="<%=rs.getString("productName")%>">
                        </div>
                        <div class="flex justify-space-between">
                            <div class="field half">
                                <label for="rate">rate</label>
                                <input id="rate" name="rate" type="text" placeholder="999"value="<%=rs.getString("rate")%>">
                            </div>
                            <div class="field half">
                                <label for="quantity">quantity</label>
                                <input id="quantity" name="quantity" type="text" placeholder="12"value="<%=rs.getString("quantity")%>">
                            </div>
                        </div>
                        <div class="flex justify-space-between">
                            <div class="field half">
                                <label for="netAmt">NET AMT</label>
                                <input id="netAmt" name="netAmt" type="text" placeholder="9999"value="<%=rs.getString("netAmt")%>">
                            </div>
                            <div class="field half">
                                <label for="gstPer">GST PER</label>
                                <input id="gstPer" name="gstPer" type="text" placeholder="19"value="<%=rs.getString("gstPer")%>">
                            </div>
                        </div>
                        <div class="field full">
                            <label for="gstAmt">GST AMT</label>
                            <input id="gstAmt" name="gstAmt" type="text" placeholder="9999"value="<%=rs.getString("gstAmt")%>">
                        </div>
                        <div class="field full">
                            <label for="totalAmt">Total AMT</label>
                            <input id="totalAmt" name="totalAmt" type="text" placeholder="9999"value="<%=rs.getString("totalAmt")%>">
                        </div>
                        <div class="field full">
                            <label for="paymentMethod">Payment Method</label>
                            <select id="paymentMethod" class="paymentMethod" class="field full" >
                                <option id="cash" value="cash" name="cash" type="text">CASH Payment</option>
                                <option id="bank" value="bank" name="bank" type="text">BANK Transfer</option>
                                <option id="upi" value="upi" name="upi" type="text">UPI Payment</option>
                            </select>
                        </div>
                    </div>  
                </div>
                <div id="insertPayment"></div>
            </form>
            <%
                }
            %>
            <div class="card-actions flex justify-space-between">
                <div class="flex-start">
                    <button class="button button-secondary" onclick="return Salestransaction()">Return to Store</button>
                </div>
                <div class="flex-end">
                    <button class="button button-link"  onclick="return viewAllSales()">Back to View</button>
                    
                    <button class="button button-primary"  onclick="return insertPayment()" id="paymentAdd">Proceed</button>
                </div>
            </div>
        </div>
        <div id="paymentsDiv">

        </div>
    </c:if>


    <c:if test="${process eq 'viewAllPayments'}">
        <input type="hidden" value="${status}" id="allPaymentsDiv">
        <a href="#" onclick="payment()" class="float" id="floatingBtn">
            <i class="fa fa-plus my-float text-white"></i>
        </a>
        <div class="bg-white my-2 px-3 py-2 rounded shadow card-header d-flex justify-content-between">
            <div class="d-flex align-items-center">
                <i class="fa-solid fa-person-walking-luggage mx-2"></i>
                Payments Reports
                <div >

                </div>
            </div>
            <div>
                <button class="btn btn-success py-2 px-3" onclick="exportExcel()">Export</button>
            </div>
        </div>
        <div id="reportstable" class=" bg-white p-3 rounded shadow overflow-auto">
            <table id="myTable" class="table">
                <thead>
                    <tr>
                        <th scope="col">Id</th>
                        <th scope="col">Customer</th>
                        <!--<th scope="col">Address</th>-->
                        <th scope="col">City</th>
                        <th scope="col">State</th>
                        <th scope="col">Product</th>
                        <th scope="col">Rate</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Net Amt</th>
                        <th scope="col">Total Amt</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ResultSet rspayment = (ResultSet) request.getAttribute("result");
                        while (rspayment.next()) {
                    %>
                    <tr>
                        <td><%=rspayment.getString("paymentId")%></td>
                        <td><%=rspayment.getString("partyName")%></td>
                        <!--<td><//%=rspayment.getString("address")%></td>-->
                        <td><%=rspayment.getString("city")%></td>
                        <td><%=rspayment.getString("state")%></td>
                        <td><%=rspayment.getString("productName")%></td>
                        <td><%=rspayment.getString("rate")%></td>
                        <td><%=rspayment.getString("quantity")%></td>                    
                        <td><%=rspayment.getString("netAmt")%></td>                    
                        <td><%=rspayment.getString("totalAmt")%></td>
                        <td>
                            <button type="button" onclick="invoice(this, 'invoice')" rowid="<%=rspayment.getInt("paymentId")%>" class="px-2 py-2 rounded btn-primary" style="width: 55px" data-bs-target="#" >Invoice</button>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </c:if>




    <c:if test="${process eq 'invoice'}">
        <div class="container mt-6 mb-7 d-print-block">
            <div class="row justify-content-center">
                <div class="col-lg-12 col-xl-7">
                    <div class="card">
                        <%
                            ResultSet rsInvoice = (ResultSet) request.getAttribute("rs");
                            while (rsInvoice.next()) {

                        %>
                        <div class="card-body p-6">
                            <h1 class="align-items-center">
                                FMS Pvt.Ltd
                            </h1>
                            <br/>
                            <p class="fs-sm">
                                This is the payment Receipt of  
                                <strong>
                                    <%=rsInvoice.getString("totalAmt")%>
                                    RS/-
                                </strong>
                                Of Your Product which You Purchase From Our Store.
                            </p>

                            <div class="border-top  pt-4 mt-4">
                                <div class="row">
                                    <div class="col-md-6">
                                        <strong>
                                            Payment No
                                        </strong>
                                        <div class="text-muted mb-2">
                                            <%=rsInvoice.getString("paymentId")%> 
                                        </div>

                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <div class="text-muted mb-2">Payment Date</div>
                                        <strong>
                                            <%=rsInvoice.getString("transactionDate")%>
                                        </strong>
                                    </div>
                                </div>
                            </div>
                            <div class="border-top  pt-4 ml-2 mt-4">
                                <div class="row">
                                    <div class="col-md-6">
                                        <strong>
                                            Customer Name
                                        </strong>
                                        <div class="text-muted mb-2">
                                            <%=rsInvoice.getString("partyName")%>
                                        </div>

                                    </div>
                                    <div class="col-md-6 text-md-end">
<!--                                        <strong>Phone No</strong>
                                        <div class="text-muted mb-2">
                                            <%--<%=rsInvoice.getString("phoneNo")%>--%> 
                                        </div>-->

                                        <strong>Address</strong>
                                        <div class="text-muted mb-2">
                                            <%=rsInvoice.getString("address")%>, 
                                            <%=rsInvoice.getString("city")%>
                                            <br>
                                            <%=rsInvoice.getString("state")%>  
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <table class="table border-bottom border-gray-200 mt-3">
                                <thead>
                                    <tr>
                                        <th scope="col" class="fs-sm text-dark text-uppercase-bold-sm px-1">Id</th>
                                        <th scope="col" class="fs-sm text-dark text-uppercase-bold-sm px-0">Product</th>
                                        <th scope="col" class="fs-sm text-dark text-uppercase-bold-sm px-0">Rate</th>
                                        <th scope="col" class="fs-sm text-dark text-uppercase-bold-sm px-0">Quantity</th>
                                        <th scope="col" class="fs-sm text-dark text-uppercase-bold-sm px-0">NetAmt</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="px-1"><%=rsInvoice.getString("transactionId")%>  </td>
                                        <td class="px-0"><%=rsInvoice.getString("productName")%>  </td>
                                        <td class="px-0"><%=rsInvoice.getString("rate")%>  </td>
                                        <td class="px-0"><%=rsInvoice.getString("quantity")%>  </td>
                                        <td class="px-0"><%=rsInvoice.getString("netAmt")%>  </td>
                                    </tr>

                                    <tr>
                                        <td class="px-1"></td>
                                        <td class="px-0"></td>
                                        <td class="px-0"></td>
                                        <td class="fs-sm text-dark text-uppercase-bold-sm px-0">GST Per</td>
                                        <td class="px-0"><%=rsInvoice.getString("gstPer")%></td>          
                                    </tr>
                                    <tr>
                                        <td class="px-1"></td>
                                        <td class="px-0"></td>
                                        <td class="px-0"></td>
                                        <td class="fs-sm text-dark text-uppercase-bold-sm px-0">GST Amt</td>
                                        <td class="px-0"><%=rsInvoice.getString("gstAmt")%></td>         
                                    </tr>
                                    <tr>
                                        <td class="px-1"></td>
                                        <td class="px-0"></td>
                                        <td class="px-0"></td>
                                        <td class="fs-sm text-dark text-uppercase-bold-sm px-0">Total Amt</td>
                                        <td class="px-0"><%=rsInvoice.getString("totalAmt")%></td>         
                                    </tr>
                                </tbody>
                            </table>

                            <div class="mt-4">
                                <div class="d-flex justify-content-end mt-2">
                                    <h5 class="me-3">Paid Amount:</h5>
                                    <h5 class="text-success">
                                        <%=rsInvoice.getString("totalAmt")%>
                                    </h5>
                                </div>
                            </div>
                            <div class="col-md-6 text-md-start">
                                <strong>Contact Us</strong>
                                <div class="text-muted mb-2">
                                    007,Top Floor,World Business Center,
                                    <br>
                                    Vip Road,Vesu,Surat
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex">
                        <button onclick="viewAllPayments('viewAllPayments')" class="btn btn-dark w-50 text-uppercase-bold-sm hover-lift-light">
                            Back
                        </button>
                        <button onclick="window.print()" class="btn btn-primary w-50 text-uppercase-bold-sm hover-lift-light">
                            Print
                        </button>                           
                    </div>
                    <%
                        }
                    %>        
                </div>
            </div>
        </div>
    </c:if>



