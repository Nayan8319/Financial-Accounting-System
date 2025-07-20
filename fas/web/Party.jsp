<%-- 
    Document   : Transaction
    Created on : 4 Jan 2024, 16:33:00
    Author     : NSP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String customersPermission = (String) session.getAttribute("customersPermission");
    String vendorsPermission = (String) session.getAttribute("vendorsPermission");
%>
<c:if test="${process eq 'vendors' or process eq 'customers'}">
    <input id="miniprocess" type="hidden" value="${process}">
    <%
        if (customersPermission != null || vendorsPermission != null) {
            if (customersPermission.contains("add") || vendorsPermission.contains("add")) {
    %>
    <a href="#" onclick="addParty()" id="floatingBtn" class="float">
        <i class="fa fa-plus my-float text-white"></i>
    </a> 
    <%}%>
    <div class="bg-white my-2 rounded shadow py-2 px-3 card-header d-flex justify-content-between">
        <div class="d-flex align-items-center">
            <i class="fa-solid fa-person-walking-luggage mx-2"></i>
            ${process} Reports
        </div>
        <!---->
        <div>
            <button type="file" class="btn btn-primary py-2 px-3" onclick="toexcel()">Import</button>
            <input type="file" id="fileinput" onchange="importExcel()" accept=".xlsx, .xls" hidden/>
            <button class="btn btn-success py-2 px-3" onclick="exportExcel('${process}')">Export</button>
        </div>
        <!---->

    </div>
    <div id="reportstable" class=" bg-white p-3 rounded shadow overflow-auto">
        <table id="myTable" class="table">
            <thead >
                <tr>
                    <th scope="col">Party Id</th>
                    <th scope="col">Party Name</th>                    
                    <th scope="col">Phone No</th>
                    <th scope="col">Address</th>      
                    <th scope="col">City</th>
                    <th scope="col">State</th>
                    <th scope="col">Transport</th>
                        <%
                            boolean is_update = customersPermission.contains("update") || vendorsPermission.contains("update");
                            boolean is_delete = customersPermission.contains("delete") || vendorsPermission.contains("delete");
                            if (is_update || is_delete) {
                        %>
                    <th scope="col" class="text-center"> Action </th>
                        <% } %>

                </tr>
            </thead>

            <tbody>
                <%
                    ResultSet rs4 = (ResultSet) request.getAttribute("result");
                    while (rs4.next()) {
                %>
                <tr>
                    <td><%=rs4.getString("partyId")%></td>
                    <td><%=rs4.getString("partyName")%></td>
                    <td><%=rs4.getString("phoneNo")%></td>
                    <td><%=rs4.getString("address")%></td>
                    <td><%=rs4.getString("city")%></td>
                    <td><%=rs4.getString("state")%></td>
                    <td><%=rs4.getString("transport")%></td>
                    <td class="text-center">
                        <% if (is_update) {%>
                        <button type="button" class="btn btn-primary mx-2" rowid="<%=rs4.getString("partyId")%>" onclick="editCommon(this, 'Party')"> <i class="fa-solid fa-pencil"></i> </button>
                        <% }
                            if (is_delete) {%>
                        <button type="button" class="btn btn-danger mx-2" onclick="return deleteParty('<%=rs4.getString("partyId")%>')"><i class="fa-solid fa-trash"></i></button>
                            <%}%>
                    </td>
                </tr>
                <% }
                    } %>
            </tbody>
        </table>
        <div id="partyDIV"></div>
    </div>
</c:if>

<c:if test="${process eq 'editParty'}">
    <!--Modal--> 
    <div class="modal fade" id="staticBackdrop">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">Edit Customer Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <%
                    ResultSet rs1 = (ResultSet) request.getAttribute("result");
                    while (rs1.next()) {
                %>
                <div class="modal-body">
                    <div class="text-dark">
                        <form>
                            <div class="form-group">
                                <lable>Party Id</lable>
                                <input type="text" class="form-control" value="<%=rs1.getString("partyId")%>" disabled name="partyId" id="partyId" placeholder="Enter Your Id">
                            </div>
                            <div class="form-group mt-1">
                                <lable>Party Name </lable>
                                <input type="text" class="form-control text-dark" value="<%=rs1.getString("partyName")%>" name="partyName" id="partyName" placeholder="Enter  Party Name">
                            </div>

                            <div class="form-group mt-1">
                                <lable>Phone No</lable>
                                <input type="text"  class="form-control text-dark" value="<%=rs1.getString("phoneNo")%>" name="phoneNo" id="phoneNo" placeholder="9876543210">
                            </div>

                            <div class="form-group mt-1">
                                <lable>Address</lable>
                                <input type="text" class="form-control text-dark" value="<%=rs1.getString("address")%>" name="address" id="address" placeholder="Enter address">
                            </div>

                            <div class="form-group mt-1">
                                <lable>City</lable>
                                <input type="text" class="form-control text-dark" value="<%=rs1.getString("city")%>"  name="city" id="city"  placeholder="Enter city">
                            </div>

                            <div class="form-group mt-1">
                                <lable>State</lable>
                                <input type="text" class="form-control text-dark" value="<%=rs1.getString("state")%>"  name="state" id="state"  placeholder="Enter state">
                            </div>

                            <div class="form-group mt-1">
                                <lable>Transport</lable>
                                <input type="text" class="form-control text-dark" value="<%=rs1.getString("transport")%>" name="transport" id="transport" placeholder="Enter Your transport">
                            </div>

                            <br/>
                            <input type="hidden" id="insertAjax">
                        </form>
                    </div>       
                </div>
                <%
                    }
                %>
                <div class="modal-footer">
                    <button type="button" id="closeModal" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button id="btn" onclick="partyUpdate(this, 'Party')" type="button" class="btn btn-primary">UPDATE</button>
                </div>
                <div id="mAjax"></div>
            </div>
        </div>
    </div>
</c:if>




<!---for add party------>
<c:if test="${process eq 'addParty'}">
    <!--Modal--> 
    <div class="modal fade" id="staticBackdrop">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">Add New Party</h5>
                    <button type="button" id="cancelBtnPartyAdd" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <div class="text-dark">
                        <form id="addparty">
                            <div class="form-group">
                                <lable>Party Id</lable>
                                <input type="text" class="form-control"name="partyId" id="partyId" placeholder="Enter Your Id">
                            </div>

                            <div class="form-group mt-1">
                                <lable>Party Name</lable>
                                <input type="text" class="form-control text-dark"  name="partyName" id="partyName" placeholder="Enter  Party Name">
                            </div>

                            <div class="form-group mt-1">
                                <lable>Party Type</lable>
                                <input type="text" class="form-control text-dark" name="partyType" id="partyType"
                                       value="<c:if test='${process eq "customer"}'>customer</c:if><c:if test='${process eq "vendor"}'>vendor</c:if>">
                            </div>

                            <div class="form-group mt-1">
                                <lable>Phone No</lable>
                                <input type="text"  class="form-control text-dark"  name="phoneNo" id="phoneNo" placeholder="9876543210">
                            </div>

                            <div class="form-group mt-1">
                                <lable>Address</lable>
                                <input type="text" class="form-control text-dark" name="address" id="address" placeholder="Enter address">
                            </div>

                            <div class="form-group mt-1">
                                <lable>City</lable>
                                <input type="text" class="form-control text-dark"   name="city" id="city"  placeholder="Enter city">
                            </div>

                            <div class="form-group mt-1">
                                <lable>State</lable>
                                <input type="text" class="form-control text-dark"   name="state" id="state"  placeholder="Enter state">
                            </div>

                            <div class="form-group mt-1">
                                <lable>Transport</lable>
                                <input type="text" class="form-control text-dark"  name="transport" id="transport" placeholder="Enter Your transport">
                            </div>
                            <input type="hidden" id="insertAjax">
                        </form>
                    </div>       
                </div>
                <div class="modal-footer">
                    <button id="btn" onclick="addcommonparty()" type="button" class="btn btn-primary">ADD</button>

                    <button onclick="resetform()"type="button" class="btn btn-secondary">RESET</button>
                </div>

                <input type="hidden" id="mAjax" >
                <input type="hidden" id="addprocess" >
            </div>
        </div>
    </div>
</c:if>

