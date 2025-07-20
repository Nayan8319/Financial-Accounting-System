<%-- 
    Document   : Product
    Created on : 29 Dec 2023, 20:40:16
    Author     : NSP
--%>


<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String productsPermission = (String) session.getAttribute("productsPermission");
%>

<c:if test="${process eq 'products'}">
    <%
        if (productsPermission != null) {
            if (productsPermission.contains("add")) {
    %>
    <a href="#" onclick="addProduct()" class="float" id="floatingBtn">
        <i class="fa fa-plus my-float text-white"></i>
    </a>
    <%}%>
    <div class="bg-white my-2 px-3 py-2 rounded shadow card-header d-flex justify-content-between">
        <div class="d-flex align-items-center">
            <i class="fa-solid fa-person-walking-luggage mx-2"></i>
            Product Reports
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
                    <th scope="col">Quantity</th>
                        <%
                            boolean is_update = productsPermission.contains("update");
                            boolean is_delete = productsPermission.contains("delete");
                            if (is_update || is_delete) {
                        %>
                    <th scope="col" class="text-center"> Action </th>
                        <%
                            }
                        %>
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

                    <td class="text-center">
                        <%
                            if (is_update) {
                        %>
                        <button type="button" class="btn btn-primary mx-2" rowid="<%=rs3.getString("productId")%>" onclick="editCommon(this, 'Product')"> <i class="fa-solid fa-pencil"></i> </button>
                        <%
                            }
                            if (is_delete) {
                        %>
                        <button type="button" class="btn btn-danger mx-2"  onclick="delprod(<%=rs3.getString("productId")%>)" > <i class="fa-solid fa-trash"></i></button>
                            <%
                                }
                            %>
                    </td>
                </tr>
                <% }
                    } %>
            </tbody>
        </table>
        <div id="productDIV">

        </div>
    </div>
</c:if>

<c:if test="${process eq 'editProduct'}">
    <!--Modal--> 
    <div class="modal fade" id="staticBackdrop">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">Edit Product Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <%
                    ResultSet rs1 = (ResultSet) request.getAttribute("result");
                    while (rs1.next()) {
                %>
                <div class="modal-body">
                    <div class="text-dark">
                        <form id="addUserForm">
                            <div class="form-group">
                                <lable>Product Id </lable>
                                <input type="text" disabled class="form-control" value="<%=rs1.getString("productId")%>" name="productId" id="productId">
                            </div>
                            <div class="form-group mt-1">
                                <lable>Product Name</lable>
                                <input type="email" class="form-control text-dark" value="<%=rs1.getString("productName")%>" name="productName" id="productName" placeholder="Enter Product Name">
                            </div>

                            <div class="form-group mt-1">
                                <lable>Price</lable>
                                <input type="text" class="form-control text-dark" value="<%=rs1.getString("price")%>" name="price" id="price" placeholder="Enter Product price">
                            </div>

                            <div class="form-group mt-1">
                                <lable>Quantity</lable>
                                <input type="text" class="form-control text-dark" value="<%=rs1.getString("quantity")%>"  name="quantity" id="quantity"  placeholder="Enter Product Quantity">
                            </div>
                            <input type="hidden" id="insertAjax">
                        </form>
                    </div>       
                </div>
                <%
                    }
                %>
                <div class="modal-footer">
                    <button type="button" id="closeModal" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button id="btn" onclick="productUpdate(this, 'Product')" type="submit" class="btn btn-primary">UPDATE</button>
                </div>
                <input type="hidden" id="mAjax">
            </div>
        </div>
    </div>
</c:if>


<!---for add product------>
<c:if test="${process eq 'addProduct'}">
    <!--Modal--> 
    <div class="modal fade" id="staticBackdrop">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">Add Product Details</h5>
                    <button type="button" id="cancelBtnProductAdd" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <div class="text-dark">
                        <form id="addparty">
                            <div class="form-group mt-1">
                                <lable>Product Id</lable>
                                <input type="text" class="form-control text-dark"name="productId" id="productId" placeholder="Enter Product Id">
                            </div>
                            <div class="form-group mt-1">
                                <lable>Product Name</lable>
                                <input type="text" class="form-control text-dark"  name="productName" id="productName" placeholder="Enter  product Name ">
                            </div>

                            <div class="form-group mt-1">
                                <lable>Product Price</lable>
                                <input type="text" class="form-control text-dark"  name="price" id="price" placeholder="Enter  product Price">
                            </div>
                            <div class="form-group mt-1">
                                <lable> Product Quantity</lable>
                                <input type="text" class="form-control text-dark" name="quantity" id="quantity" placeholder="Enter product Quantity">
                            </div>

                            <input type="hidden" id="insertAjax">
                        </form>
                    </div>       
                </div>
                <div class="modal-footer">
                    <button id="btn" onclick="insertProduct()" id="cancelBtnProductAdd" type="button" class="btn btn-primary">ADD</button>

                    <button onclick="resetform()"type="button" class="btn btn-secondary">RESET</button>
                </div>
                <div id="mAjax"></div>
                <input type="hidden" id="addprocess" >
            </div>
        </div>
    </div>
</c:if>