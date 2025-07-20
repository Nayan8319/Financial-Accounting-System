<%-- 
    Document   : UserManagement
    Created on : 28 Dec 2023, 13:13:48
    Author     : NSP
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.SQLException" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<c:if test="${process eq 'viewUser'}">
    <div class="card mt-2">
        <a href="#" class="float" onclick="addUser()">
            <i class="fa fa-plus my-float"></i>
        </a>
        <div class="bg-white rounded card-header d-flex justify-content-between">
            <div class="d-flex align-items-center">
                <i class="fa-solid fa-person-walking-luggage mx-2"></i>
                User Reports
            </div>
            <div>
                <button class="btn btn-success py-2 px-3" onclick="exportExcel()">Export</button>
            </div>
        </div>
        <div id="reportstable" class=" bg-white p-3 rounded shadow overflow-auto">
            <table id="myTable" class="table">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Username</th>
                        <th scope="col">Password</th>
                        <!--<th scope="col">Email</th>-->
                        <th scope="col">Gender</th>
                        <th scope="col">Phone NO</th>
                        <!--<th scope="col">Address</th>-->
                        <!--<th scope="col">City</th>-->
                        <!--<th scope="col">State</th>-->
                        <th scope="col">Salary</th>
                        <th scope="col">Join Date</th>
                        <th scope="col">Sale</th>
                        <th scope="col">Purchase</th>
                        <th scope="col">Product</th>
                        <th scope="col">Vendor</th>
                        <th scope="col">Customer</th>
                        <th scope="col">Edit</th>
                        <th scope="col">Delete</th>
                    </tr>
                </thead>

                <tbody>
                    <%
                        ResultSet rs = (ResultSet) request.getAttribute("result");
                        int tmp = 0;
                        while (rs.next()) {
                    %>
                    <tr>
                        <th scope="row"><%=++tmp%></th>
                        <td><%=rs.getString("username")%></td>                        
                        <td><%=rs.getString("password")%></td>
                        <!--<td><//%=rs.getString("email")%></td>-->
                        <td><%=rs.getString("gender")%></td>
                        <td><%=rs.getString("phoneNo")%></td>
<!--                        <td><//%=rs.getString("address")%></td>
                        <td><//%=rs.getString("city")%></td>
                        <td><//%=rs.getString("state")%></td>-->
                        <td><%=rs.getString("salary")%></td>
                        <td><%=rs.getString("joiningDate")%></td>
                        <%
                            String permission = rs.getString("permissions");
                            int i = 0;
                            if (permission != null) {
                                String[] permissions = permission.split(",");
                                while (i < permissions.length) {
                                    out.print("<td>" + permissions[i] + "</td>");
                                    i++;
                                }
                            }
                            while (i < 5) {
                                out.print("<td>-</td>");
                                i++;
                            }
                        %>
                        <td>
                            <button onclick="loadEditModal(this)" data-row-id="<%=rs.getString("userId")%>" class="btn btn-primary" style="width: 70px">
                                Edit
                            </button>
                        </td>
                        <td>
                            <button onclick="deleteUser(<%=rs.getString("userId")%>)"  class="btn btn-danger" style="width: 70px">
                                Delete
                            </button>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <div id="modalContainer">

    </div>
</c:if>
<c:if test="${process eq 'addUser'}">
    <!--Modal--> 
    <div class="modal fade" id="staticBackdrop">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">Add User Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div>
                        <form>
                            <!--username Feild-->
                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-user"></i> </span>
                                </div>
                                <input name="" class="form-control" name="username" id="username" placeholder="Enter Your Name">
                            </div> 
                            <!--email Feild-->
                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-envelope"></i> </span>
                                </div>
                                <input name="" class="form-control" name="email" id="email" type="email" placeholder="Email address"  >
                            </div>
                            <!--gsnder Feild-->
                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-building"></i> </span>
                                </div>
                                <select class="form-control" name="gender" id="gender">     
                                    <option class="text-muted">--Select Gender--</option>
                                    <option value="male">Male</option>
                                    <option value="female">Female</option>
                                </select>
                            </div>
                            <!--phone NO Feild-->
                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-volume-control-phone"></i> </span>
                                </div>
                                <input class="form-control" name="phoneNo" id="phoneNo" placeholder="+91 9876543210">
                            </div>
                            <!--address Feild-->
                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-address-card"></i> </span>
                                </div>
                                <input class="form-control" name="address" id="address" placeholder="Enter Your Address">
                            </div>
                            <!--city Feild-->
                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-map-marker"></i> </span>
                                </div>
                                <input class="form-control" name="city" id="city" placeholder="Enter Your City">
                            </div>
                            <!--state Feild-->
                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-map-marker"></i> </span>
                                </div>
                                <input class="form-control" name="state" id="state" placeholder="Enter Your State">
                            </div>
                            <!--salary feild-->
                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-inr"></i> </span>
                                </div>
                                <input class="form-control" name="salary" id="salary" placeholder="Enter User salary">
                            </div>
                            <!--joiningDate Feild-->
                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-calendar"></i> </span>
                                </div>
                                <input class="form-control" type="date" name="joiningDate" id="joiningDate" placeholder="Enter User Joining Date">
                            </div>
 

                            <h5>Permission</h5>
                            <div class="d-flex">
                                <div>
                                    <div class="form-check">
                                        <input class="form-check-input permissions" type="checkbox" value="sales" id="sales-permission" onchange="Subpermission('sales')">
                                        <label class="form-check-label" for="sales">
                                            Sales
                                        </label>
                                        <div id="sales-subpermission" class="ps-3"> </div>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input permissions" name="check" type="checkbox" value="purchase" id="purchase-permission"  onchange="Subpermission('purchase')">
                                        <label class="form-check-label" for="purchase">
                                            Purchase
                                        </label>
                                        <div id="purchase-subpermission" class="ps-3"></div>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input permissions" type="checkbox" value="products" id="products-permission" onchange="Subpermission('products')">
                                        <label class="form-check-label" for="products">
                                            Products
                                        </label>
                                        <div id="products-subpermission" class="ps-3"></div>
                                    </div>

                                    <div class="form-check">
                                        <input class="form-check-input permissions"  type="checkbox" value="vendors" id="vendors-permission" onchange="Subpermission('vendors')">
                                        <label class="form-check-label" for="vendors">
                                            Vendors
                                        </label>
                                        <div id="vendors-subpermission" class="ps-3"></div>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input permissions" type="checkbox" value="customers" id="customers-permission" onchange="Subpermission('customers')">
                                        <label class="form-check-label" for="customers">
                                            Customers
                                        </label>
                                        <div id="customers-subpermission" class="ps-3"></div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="closeModal" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button id="btn" onclick="InsertorUpdateUser('insert')" type="submit" class="btn btn-primary">ADD</button>
                </div>
                <input type="hidden" id="insertAjax">
            </div>
        </div>
    </div>
</c:if>

<c:if test="${process eq 'userEdit'}">
    <div class="modal fade" id="staticBackdrop">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">Edit User Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body h-15 overflow-y-auto">
                    <%
                        ResultSet rs1 = (ResultSet) request.getAttribute("result");

                        while (rs1.next()) {
                    %>
                    <div>

                        <form>
                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-user"></i> </span>
                                </div>
                                <input id="userId" value="<%=rs1.getString("userId")%>" type="hidden">
                                <input name="" value="<%=rs1.getString("username")%>" class="form-control" name="username" id="username" placeholder="Enter Your Name">
                            </div>
                            
                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-envelope"></i> </span>
                                </div>
                                <input name="" value="<%=rs1.getString("email")%>" class="form-control" placeholder="Email address"  name="email" id="email" type="email">
                            </div>

                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-building"></i> </span>
                                </div>

                                <select class="form-control" name="gender" id="gender">    
                                    <%
                                        if (rs1.getString("gender").equals("male")) {
                                    %>
                                    <option selected="" value="male">Male</option>
                                    <option value="female">Female</option>
                                    <%
                                    } else {
                                    %>
                                    <option value="male">Male</option>
                                    <option selected="" value="female">Female</option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div> 

                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-volume-control-phone"></i> </span>
                                </div>
                                <input class="form-control" value="<%=rs1.getString("phoneNo")%>" name="phoneNo" id="phoneNo" placeholder="+91 9876543210">
                            </div> 
                            
                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-address-card"></i> </span>
                                </div>
                                <input class="form-control" value="<%=rs1.getString("address")%>" name="address" id="address" placeholder="Enter Your address">
                            </div>

                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-map-marker"></i> </span>
                                </div>
                                <input class="form-control" value="<%=rs1.getString("city")%>" name="city" id="city" placeholder="Enter Your City">
                            </div>
                            
                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-map-marker"></i> </span>
                                </div>
                                <input class="form-control" value="<%=rs1.getString("state")%>" name="state" id="state" placeholder="Enter Your State">
                            </div> 
                            
                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-inr"></i> </span>
                                </div>
                                <input class="form-control" value="<%=rs1.getString("salary")%>"name="salary" id="salary" placeholder="Enter User salary">
                            </div>
                            
                            <div class="form-group input-group my-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text h-100"> <i class="fa fa-calendar"></i> </span>
                                </div>
                                <input class="form-control" type="date"value="<%=rs1.getString("joiningDate")%>" name="joiningDate" id="joiningDate" placeholder="Enter User Joining Date">
                            </div>
 
                            <h5>Permission</h5>
                            <div class="d-flex">
                                <div>
                                    <%
                                        String permission = rs1.getString("permissions");
                                        String salePermission = rs1.getString("salesPermission");
                                        String purchasePermission = rs1.getString("purchasePermission");
                                        String productsPermission = rs1.getString("productsPermission");
                                        String customersPermission = rs1.getString("customersPermission");
                                        String vendorsPermission = rs1.getString("vendorsPermission");

                                    %>
                                    <div class="form-check">
                                        <input class="form-check-input permissions" type="checkbox" value="sales" id="sales-permission"  <%=((permission != null) && permission.contains("sales")) ? "checked" : ""%> onchange="Subpermission('sales')">
                                        <label class="form-check-label" for="sales">
                                            Sales
                                        </label>
                                        <div id="sales-subpermission" class="ps-3">
                                            <div class="form-check d-inline-flex px-3  salesSub-permissionDiv">
                                                <input type="checkbox" disabled="" checked class="form-check-input" id="sales-view-checkbox" value="view" <%=((salePermission != null) && salePermission.contains("view")) ? "checked" : ""%> >
                                                <label for="sales-view-checkbox" class="ps-2" >View</label>
                                            </div>
                                            <div class="form-check d-inline-flex px-3  salesSub-permissionDiv">
                                                <input type="checkbox" class="form-check-input" id="sales-add-checkbox" value="add"  <%=((salePermission != null) && salePermission.contains("add")) ? "checked" : ""%>>
                                                <label for="sales-add-checkbox" class="ps-2" >Add</label>
                                            </div>
                                            <div class="form-check d-inline-flex px-3  salesSub-permissionDiv">
                                                <input type="checkbox" class="form-check-input" id="sales-update-checkbox" value="update" <%=((salePermission != null) && salePermission.contains("update")) ? "checked" : ""%> >
                                                <label for="sales-update-checkbox" class="ps-2" > Update</label>
                                            </div>
                                            <div class="form-check d-inline-flex px-3  salesSub-permissionDiv">
                                                <input type="checkbox" class="form-check-input" id="sales-delete-checkbox" value="delete" <%=((salePermission != null) && salePermission.contains("delete")) ? "checked" : ""%>>
                                                <label for="sales-delete-checkbox" class="ps-2"  >Delete</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input permissions" name="check" type="checkbox" value="purchase" id="purchase-permission"  <%=((permission != null) && permission.contains("purchase")) ? "checked" : ""%> onchange="Subpermission('purchase')">
                                        <label class="form-check-label" for="purchase">
                                            Purchase
                                        </label>
                                        <div id="purchase-subpermission" class="ps-3">
                                            <div class="form-check d-inline-flex px-3  purchaseSub-permissionDiv">
                                                <input type="checkbox" disabled="" checked="" class="form-check-input" id="purchase-view-checkbox" value="view"<%=((purchasePermission != null) && purchasePermission.contains("view")) ? "checked" : ""%> >
                                                <label for="purchase-view-checkbox" class="ps-2">View</label>
                                            </div>
                                            <div class="form-check d-inline-flex px-3  purchaseSub-permissionDiv">
                                                <input type="checkbox" class="form-check-input" id="purchase-add-checkbox" value="add" <%=((purchasePermission != null) && purchasePermission.contains("add")) ? "checked" : ""%>>
                                                <label for="purchase-add-checkbox" class="ps-2">Add</label>
                                            </div>
                                            <div class="form-check d-inline-flex px-3  purchaseSub-permissionDiv">
                                                <input type="checkbox" class="form-check-input" id="purchase-update-checkbox" value="update"  <%=((purchasePermission != null) && purchasePermission.contains("update")) ? "checked" : ""%> >
                                                <label for="purchase-update-checkbox" class="ps-2">Update</label>
                                            </div>
                                            <div class="form-check d-inline-flex px-3  purchaseSub-permissionDiv">
                                                <input type="checkbox" class="form-check-input" id="purchase-delete-checkbox" value="delete" <%=((purchasePermission != null) && purchasePermission.contains("delete")) ? "checked" : ""%>>
                                                <label for="purchase-delete-checkbox" class="ps-2">Delete</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-check">
                                        <input class="form-check-input permissions" type="checkbox" value="products" id="products-permission" <%=((permission != null) && permission.contains("products")) ? "checked" : ""%> onchange="Subpermission('products')">
                                        <label class="form-check-label" for="products">
                                            Products
                                        </label>
                                        <div id="products-subpermission" class="ps-3">
                                            <div class="form-check d-inline-flex px-3  productsSub-permissionDiv"><input type="checkbox" disabled="" checked="" class="form-check-input" id="products-view-checkbox" value="view" <%=((productsPermission != null) && productsPermission.contains("view")) ? "checked" : ""%> ><label for="products-view-checkbox" class="ps-2">View</label></div>
                                            <div class="form-check d-inline-flex px-3  productsSub-permissionDiv"><input type="checkbox" class="form-check-input" id="products-add-checkbox" value="add" <%=((productsPermission != null) && purchasePermission.contains("add")) ? "checked" : ""%> ><label for="products-add-checkbox" class="ps-2">Add</label></div>
                                            <div class="form-check d-inline-flex px-3  productsSub-permissionDiv"><input type="checkbox" class="form-check-input" id="products-update-checkbox" value="update" <%=((productsPermission != null) && productsPermission.contains("update")) ? "checked" : ""%> ><label for="products-update-checkbox" class="ps-2">Update</label></div>
                                            <div class="form-check d-inline-flex px-3  productsSub-permissionDiv"><input type="checkbox" class="form-check-input" id="products-delete-checkbox" value="delete" <%=((productsPermission != null) && productsPermission.contains("delete")) ? "checked" : ""%> ><label for="products-delete-checkbox" class="ps-2">Delete</label></div>
                                        </div>
                                    </div>

                                    <div class="form-check">
                                        <input class="form-check-input permissions" type="checkbox" value="vendors" id="vendors-permission" <%=((permission != null) && permission.contains("vendors")) ? "checked" : ""%> onchange="Subpermission('vendors')">
                                        <label class="form-check-label" for="vendors">
                                            Vendors
                                        </label>
                                        <div id="vendors-subpermission" class="ps-3">
                                            <div class="form-check d-inline-flex px-3  vendorsSub-permissionDiv">
                                                <input type="checkbox" disabled="" checked="" class="form-check-input" id="vendors-view-checkbox" value="view" <%=((vendorsPermission != null) && vendorsPermission.contains("view")) ? "checked" : ""%> >
                                                <label for="vendors-view-checkbox" class="ps-2">View</label>
                                            </div>
                                            <div class="form-check d-inline-flex px-3  vendorsSub-permissionDiv"><input type="checkbox" class="form-check-input" id="vendors-add-checkbox" value="add" <%=((vendorsPermission != null) && vendorsPermission.contains("add")) ? "checked" : ""%> ><label for="vendors-add-checkbox" class="ps-2">Add</label></div>
                                            <div class="form-check d-inline-flex px-3  vendorsSub-permissionDiv"><input type="checkbox" class="form-check-input" id="vendors-update-checkbox" value="update" <%=((vendorsPermission != null) && vendorsPermission.contains("update")) ? "checked" : ""%> ><label for="vendors-update-checkbox" class="ps-2">Update</label></div>
                                            <div class="form-check d-inline-flex px-3  vendorsSub-permissionDiv"><input type="checkbox" class="form-check-input" id="vendors-delete-checkbox" value="delete" <%=((vendorsPermission != null) && vendorsPermission.contains("delete")) ? "checked" : ""%> ><label for="vendors-delete-checkbox" class="ps-2">Delete</label></div>
                                        </div>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input permissions" type="checkbox" value="customers" id="customers-permission" <%=((permission != null) && permission.contains("customers")) ? "checked" : ""%> onchange="Subpermission('customers')">
                                        <label class="form-check-label" for="customers">
                                            Customers
                                        </label>
                                        <div id="customers-subpermission" class="ps-3">
                                            <div class="form-check d-inline-flex px-3  customersSub-permissionDiv"><input type="checkbox" disabled="" checked="" class="form-check-input" id="customers-view-checkbox" value="view" <%=((customersPermission != null) && customersPermission.contains("view")) ? "checked" : ""%> ><label for="customers-view-checkbox" class="ps-2">View</label></div>
                                            <div class="form-check d-inline-flex px-3  customersSub-permissionDiv"><input type="checkbox" class="form-check-input" id="customers-add-checkbox" value="add" <%=((customersPermission != null) && customersPermission.contains("add")) ? "checked" : ""%> ><label for="customers-add-checkbox" class="ps-2">Add</label></div>
                                            <div class="form-check d-inline-flex px-3  customersSub-permissionDiv"><input type="checkbox" class="form-check-input" id="customers-update-checkbox" value="update" <%=((customersPermission != null) && customersPermission.contains("update")) ? "checked" : ""%> ><label for="customers-update-checkbox" class="ps-2">Update</label></div>
                                            <div class="form-check d-inline-flex px-3  customersSub-permissionDiv"><input type="checkbox" class="form-check-input" id="customers-delete-checkbox" value="delete" <%=((customersPermission != null) && customersPermission.contains("delete")) ? "checked" : ""%> ><label for="customers-delete-checkbox" class="ps-2">Delete</label></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <%
                        }
                    %>

                </div>
                <div class="modal-footer">
                    <button type="button" id="closeModal" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button id="btn" onclick="InsertorUpdateUser('update')" type="submit" class="btn btn-primary">Update</button>
                </div>
                <input type="hidden" id="insertAjax">
            </div>
        </div>
    </div>
</c:if>
