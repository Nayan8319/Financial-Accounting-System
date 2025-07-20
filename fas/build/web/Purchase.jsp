<%-- 
    Document   : Purchase
    Created on : 29 Dec 2023, 20:41:44
    Author     : NSP
--%>

<!------------------------purchase.jsp------------------------->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.sql.ResultSet" %>
<%
    String purchasePermission = (String) session.getAttribute("purchasePermission");
%>


<c:if  test="${process eq 'purchase'}">
    <div id="dataLoader" class="card mt-2" >

    </div> 

    <div class="d-flex justify-content-around  md-5 pd-5 " id="BTNcontainer" style="display:block">
        <button id="previousbtn" type="button" class="btn btn-outline-dark w-25 m-2">Previous</button>
        <%
            if (purchasePermission != null) {

                if (purchasePermission.contains("add")) {
        %>
        <button  id="newbtn"  type="button" onclick="newTransaction()"  class="btn btn-outline-dark w-25 m-2">New</button>
        <% }
            if (purchasePermission.contains("update")) { %>
        <button id="editbtn" type="button" onclick="editTransaction()" class="btn btn-outline-danger w-25 m-2">Update</button>
        <% }
            if (purchasePermission.contains("delete")) { %>
        <button id="deletebtn" type="button" onclick="deleteTransaction('purchase')"  class="btn btn-outline-dark  w-25 m-2">Delete</button>
        <% }
            if (purchasePermission.contains("view")) { %>
        <button id="viewbtn" type="button" onclick="viewAllpurchase()"  class="btn btn-outline-danger w-25 m-2" onclick="ViewAllData('${process}')">View All</button>
        <% }
            }%>

        <button id="nextbtn"  type="button" class="btn btn-outline-danger w-25 m-2">Next</button>

    </div>
</div>



</c:if>

<c:if test="${process eq 'Purchaselast' or process eq 'EditViewData' }">
  <style>
         input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
        -webkit-appearance: none;
        margin: 0;
        }
        input[type=number] {
            -moz-appearance: textfield;
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
                <input type="text" disabled  class="form-control" onfocus="showList('party',this)" onkeyup="filterList(this)" onblur="removeList()" id="partyName"  value="">
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
                <div class="overflow-auto h-50" id="itemsList">
                  
                    <div class="row  row1">
                        <div class="col">
                            <input class="bg-white" onkeyup="changeTotals()" type="number" disabled value="1">
                        </div>
                        <div class="col">
                            <input type="text" id="productName" onfocus="showList('product',this)" onblur="removeList()" onkeyup="filterList(this);changeTotals()" value="">
                        </div>
                        <div class="col">
                            <input type="number" onkeyup="changeTotals()" value="">
                        </div>
                        <div class="col">
                            <input type="number" onkeyup="changeTotals()" value="">
                        </div>
                        <div class="col">
                            <input type="number" onkeyup="changeTotals()" value="">
                        </div>
                        <div class="col">
                            <input type="number" onkeyup="changeTotals()" value="">
                        </div>
                        <div class="col">
                            <input type="number" onkeyup="changeTotals()" value="">
                        </div>
                        <div class="col">
                            <input type="number" onkeyup="changeTotals()" value="">
                        </div>
                    </div>
                   
                </div>
                <div id="itemFooter" class="row text-dark font-weight-bold">
                    <div class="col"></div>
                    <div id="productName"class="col"></div>
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
                <input  class="btn btn-outline-primary w-25 m-2" style=" background-color: #b2d5f7;display:none"  id="submitNew" onclick="return AddTransaction('purchase')" type="button" value="Submit"> 
                <input  class="btn btn-outline-primary w-25 m-2" style=" background-color: #b2d5f7;display: none" id="submitUpdate" onclick="return UpdateTransaction('purchase')" type="button" value="submit"> 
                <input  class="btn btn-outline-danger w-25 m-2" style=" background-color: #f37a7a;display: none" id="cancelBtn" onclick="CancelBtn('purchase')" type="button" value="Cancel"> 
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
                <input type="text" disabled  class="form-control" id="partyName" onfocus="showList('party',this)" onkeyup="filterList(this)" onblur="removeList()" value="<%=result1.getString("partyName")%>">
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
                <div class="overflow-auto h-50" id="itemsList">
                    <%
                        int rowCount=0;
                        ResultSet resultItem = (ResultSet) request.getAttribute("result1");
                        while (resultItem.next()) {
                        ++rowCount;
                    %>
                    <div class="row  row<%=rowCount%>">
                        <div class="col"><input class="bg-white" onkeyup="changeTotals()" type="number" disabled value="<%=rowCount%>"></div>
                        <div class="col"><input type="text" onfocus="showList('product',this)" onblur="removeList()" onkeyup="filterList(this);changeTotals()" value="<%=resultItem.getString("itemName")%>"></div>
                        <div class="col"><input type="number" onkeyup="changeTotals()" value="<%=resultItem.getString("rate")%>"></div>
                        <div class="col"><input type="number" onkeyup="changeTotals()" value="<%=resultItem.getString("quantity")%>"></div>
                        <div class="col"><input type="number" onkeyup="changeTotals()" value="<%=resultItem.getString("netAmt")%>"></div>
                        <div class="col"><input type="number" onkeyup="changeTotals()" value="<%=resultItem.getString("gstPer")%>"></div>
                        <div class="col"><input type="number" onkeyup="changeTotals()" value="<%=resultItem.getString("gstAmt")%>"></div>
                        <div class="col"><input type="number" onkeyup="changeTotals()" value="<%=resultItem.getString("totalAmt")%>"></div>
                    </div>
                    <%
                        }
                    %>
                </div>
                <div id="itemFooter" class="row text-dark font-weight-bold">
                    <div class="col"></div>
                    <div class="col"></div>
                    <div class="col"></div>
                    <div class="col"></div>
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
                <input  class="btn btn-outline-primary w-25 m-2" style=" background-color: #b2d5f7;display:none"  id="submitNew" onclick="return AddTransaction('purchase')" type="button" value="Submit"> 
                <input  class="btn btn-outline-primary w-25 m-2" style=" background-color: #b2d5f7;display: none" id="submitUpdate" onclick="return UpdateTransaction('purchase')" type="button" value="submit"> 
                <input  class="btn btn-outline-danger w-25 m-2" style=" background-color: #f37a7a;display: none" id="cancelBtn" onclick="CancelBtn('purchase')" type="button" value="Cancel"> 
            </div>

        </div>
    </form>

</c:if>
    
<%--<c:if test="${process eq 'salesupdate' or process eq 'AddTransaction' or process eq 'deleteSales'}">
    <input type="hidden" value="${status}" id="UpdateDelete">
</c:if>--%>


<c:if test="${process eq 'AllPurchase'}">
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
                    <th>Transaction Id</th>
                    <th>Party Name</th>
                    <th>Product Name</th>
                    <th>Net Amount</th>
                    <th>GSt Amount</th>
                    <th>Total Amount</th>
                    <th>Transport</th>
                    <th>Transaction Date</th>
                    <th>Action</th>

                </tr>
            </thead> 
            <tbody>
                <%
                    ResultSet result = (ResultSet) request.getAttribute("result");

                    while (result.next()) {

                %>
                <tr >
                    <td><%=result.getInt("transactionId")%></td>
                    <td><%=result.getString("partyName")%></td>                    
                    <td><%=result.getString("productName")%></td>
                    <td><%=result.getInt("netAmt")%></td>
                    <td><%=result.getInt("gstAmt")%></td>
                    <td><%=result.getInt("totalAmt")%></td>
                    <td><%=result.getString("transport")%></td>
                    <td><%=result.getString("transactionDate")%></td>
                    <td>
                        <button type="button" onclick=" dataToInput(this, 'purchase')" rowid="<%=result.getInt("transactionId")%>"  class="px-2 py-2 rounded btn-warning" style="width: 55px" data-bs-target="#" >View</button>
                        <button type="button" onclick=" invoice('invoice')" rowid="<%=result.getInt("transactionId")%>"  class="px-2 py-2 rounded btn-outline-primary" style="width: 55px" data-bs-target="#" >invoice</button>
                    </td>
                </tr>
                <%
                    }
                %>

            </tbody>
        </table>
    </div>
</c:if>

