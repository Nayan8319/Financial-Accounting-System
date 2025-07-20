/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */



function validate(id, label) {
    if (document.getElementById(id).value.trim() === "") {
        alert(label + " cannot be Empty.");
        document.getElementById(id).focus();
        return false;
    }
    return true;
}

function ajax_call(method, url, data, dest, isHtml, isfile) {
    var xhttp = new XMLHttpRequest();
    xhttp.onload = function () {
        if (isHtml) {
            document.getElementById(dest).innerHTML = this.responseText;
        } else {
            document.getElementById(dest).value = this.responseText;
        }
    };
    xhttp.open(method, url, false);
    if (!isfile) {
        xhttp.setRequestHeader('content-type', 'application/x-www-form-urlencoded');
    }
    xhttp.send(data);
}

function LoginUser() {
    user = document.getElementById("username").value;
    pass = document.getElementById("password").value;
    var validated = validate("username", "User Name") && validate("password", "Password");
    if (validated) {
        var usertype = document.querySelector('input[name="option"]:checked').value;
        ajax_call("POST", "LoginServlet", "user=" + user + "&pass=" + pass + "&type=" + usertype, "ajax");
        var status = document.getElementById('ajax').value;
        if (status === 'admin') {
            window.location.href = "AdminDashboard.jsp";
        } else if (status === 'user') {
            window.location.href = "UserDashboard.jsp";
        } else {
            alert("User Name or Password is incorrect!");
        }
    }
    return false;
}

function logout() {
    var res = confirm("Are you sure, you want to Logout!!");
    if (res) {
        window.location.href = "LogoutServlet";
    }
}

function addUser() {
    ajax_call("POST", "UserController", "process=addUser", "modalContainer", "html");
    var modal = new bootstrap.Modal(document.getElementById("staticBackdrop"));
    modal.show();
}

function InsertorUpdateUser(process) {


    var user = document.getElementById("username").value;
    var email = document.getElementById("email").value;
    var gender = document.getElementById("gender").value;
    var phoneNo = document.getElementById("phoneNo").value;
    var address = document.getElementById("address").value;
    var city = document.getElementById("city").value;
    var state = document.getElementById("state").value;
    var salary = document.getElementById("salary").value;
    var joiningDate = document.getElementById("joiningDate").value;

    var permissions = "";
    var permissionsCheckboxes = document.getElementsByClassName('permissions');
    for (var i = 0; i < permissionsCheckboxes.length; i++) {
        if (permissionsCheckboxes[i].checked) {
            if (permissions === "") {
                permissions += permissionsCheckboxes[i].value;
            } else {
                permissions += "," + permissionsCheckboxes[i].value;
            }
        }
    }

    function validateForm() {
        var phoneNo = document.getElementById("phoneNo").value;
        var salary = document.getElementById("salary").value;

        var phoneNoPattern = /^[5-9]\d{9}$/;
        var salaryPattern = /^\d+$/;

        var isValid = true;
        var errorMessage = "";

        if (!phoneNoPattern.test(phoneNo) ) {
            errorMessage += "Mobile number must be valid Format and 10 digits long.\n";
            isValid = false;
        }

        if (!salaryPattern.test(salary) || salary < 5000 || salary > 30000) {
            errorMessage += "Salary must be an integer between 5000 and 30000.\n";
            isValid = false;
        }

        if (!isValid) {
            alert(errorMessage);
            return false;
        }

        return true;
    }
    var validated =
            validate("username", "User Name") &&
            validate("email", "Email") &&
            validate("gender", "Gender") &&
            validateForm("phoneNO", "Phone No") &&
            validate("address", "Address") &&
            validate("city", "City") &&
            validate("state", "State");
            validate("salary", "Salary") &&
            validate("joiningDate", "Join Date");

    sub_permission_value();

    var data =
            "user=" + user +
            "&email=" + email +
            "&gender=" + gender +
            "&phoneNo=" + phoneNo +
            "&address=" + address +
            "&city=" + city +
            "&state=" + state +
            "&salary=" + salary +
            "&joiningDate=" + joiningDate +
            "&permissions=" + permissions +
            "&sales_SubPermission=" + sales_SubPermission +
            "&purchase_SubPermission=" + purchase_SubPermission +
            "&products_SubPermission=" + products_SubPermission +
            "&vendors_SubPermission=" + vendors_SubPermission +
            "&customers_SubPermission=" + customers_SubPermission;

    if (validated) {

        if (process === 'update') {
            var userId = document.getElementById("userId").value;
            data += "&userId=" + userId;
        }
        ajax_call("POST", "UserController", data + "&process=" + process, "insertAjax");
        let status = document.getElementById('insertAjax').value;
        document.getElementById("closeModal").click();
        if (status > 0) {
            User('viewUser');
            alert('data ' + process + ' succesfully');

        } else {
            alert('something went wrong!');
        }
    }
    return false;
}


//For Prmissions
let sales_SubPermission = null;
let purchase_SubPermission = null;
let customers_SubPermission = null;
let vendors_SubPermission = null;
let products_SubPermission = null;


function sub_permission_value() {
    sales_SubPermission = subPermissionChecker('sales');
    purchase_SubPermission = subPermissionChecker('purchase');
    products_SubPermission = subPermissionChecker('products');
    vendors_SubPermission = subPermissionChecker('vendors');
    customers_SubPermission = subPermissionChecker('customers');

}

//create sub permission boxes
function subPermissionChecker(SectionName) {
    const subPermission = document.getElementById(SectionName + "-subpermission");
    const checkedPermission = subPermission.querySelectorAll('input[type="checkbox"]:checked');
    if (checkedPermission.length > 0) {
        const selectedOptions = Array.from(checkedPermission).map((checkbox) => checkbox.value);
        return selectedOptions.join(', ');
    } else {
        return null;
    }
}

function Subpermission(process) {
    const ProcessType = document.getElementById(process + "-permission");
    const divData = document.getElementById(process + "-subpermission");

    if (process === 'sales' || process === 'purchase' || process === 'products' || process === 'vendors' || process === 'customers') {
        if (ProcessType.checked) {
            CRUDoperation(process);
        } else {
            divData.innerHTML = "";
        }
    }


}
//for sub Permissions
function CRUDoperation(process) {
    const divData = document.getElementById(process + "-subpermission");

    var crud = ['View', 'Add', 'Update', 'Delete'];
    crud.forEach((permission) => {
        const div = document.createElement("div");
        div.className = "form-check d-inline-flex px-3  " + process + "Sub-permissionDiv";
        const checkbox = document.createElement("input");
        checkbox.type = "checkbox";
        if (permission === 'View') {
            checkbox.checked = "true";
            checkbox.disabled = "true";
        }
        checkbox.className = "form-check-input";
        checkbox.id = process + "-" + permission.toLowerCase() + "-checkbox";
        checkbox.value = permission.toLowerCase();

        const label = document.createElement("label");
        label.htmlFor = checkbox.id;
        label.textContent = permission;
        label.className = "ps-2";

        div.append(checkbox);
        div.append(label);

        if (process === 'sales' || process === 'purchase' || process === 'products'
                || process === 'vendors' || process === 'customers') {
            divData.append(div);
        }
    });
}


function loadEditModal(element) {
    var id = element.getAttribute("data-row-id");
    ajax_call("POST", "UserController", "userid=" + id + "&process=userEdit", "modalContainer", 'html');
    var modal = new bootstrap.Modal(document.getElementById("staticBackdrop"));
    EditsubPermissionChecker();
    modal.show();

}
function EditsubPermissionChecker() {
    var sectionName = ['sales', 'purchase', 'products', 'vendors', 'customers'];
    sectionName.forEach((SectionName) => {
        const Permission = document.getElementById(SectionName + "-permission");
        const SubPermission = document.getElementById(SectionName + "-subpermission");
        if (!Permission.checked) {
            SubPermission.innerHTML = "";
        }
    }
    );

}

function reports(process) {
    if (process === 'sales') {
        setPage("Sales Reports");
    } else if (process === 'purchase') {
        setPage("Purchase Report");
    } else if (process === 'products') {
        setPage("Products Report");
    } else if (process === 'vendors') {
        setPage("Vendors Report");
    } else if (process === 'customers') {
        setPage("Customers Report");
    }

    ajax_call("POST", "ReportsController", "process=" + process, "mainDiv", 'html');
    let table = new DataTable('#myTable');
}

function User(process) {
    setPage('Users');
    ajax_call("POST", "UserController", "process=" + process, "mainDiv", 'html');
    if (process === 'viewUser') {
        let table = new DataTable('#myTable');
    }
}

//for delete product
function deleteUser(element) {
    ;
    var res = confirm("Sure to Delete..?");
    if (res) {
        var status = document.getElementById("modalContainer").innerHTML;
        ajax_call('POST', 'UserController', 'process=deleteUser&userId=' + element, 'modalContainer', true);
        if (status > 0) {
            alert("Record Delete successfully..!");
            User();
        } else {
            alert("Somethoing went Wrong..!");
        }
    }
}
function party(process) {
//    (process === "vendors" ? setPage("Vendor Management") :setPage("Customer Management"));
//    localStorage.setItem('process', process);

    setPage("Customer Management");
    ajax_call("POST", "PartyController", "process=" + process, "mainDiv", 'html');
    let table = new DataTable('#myTable');
}

function editCommon(element, editProcess) {
    if (editProcess === 'Transaction') {
        var rowid = element.getAttribute("rowid");
        ajax_call("POST", "TransactionController", "process=editTransaction" + "&transactionId=" + rowid, "transactionDIV", "html");

    } else if (editProcess === 'Party') {
        var rowid = element.getAttribute("rowid");
        ajax_call("POST", "PartyController", "process=editParty" + "&partyId=" + rowid, "partyDIV", "html");

    } else if (editProcess === 'Product') {
        var rowid = element.getAttribute("rowid");
        ajax_call("POST", "ProductController", "process=editProduct" + "&productId=" + rowid, "productDIV", "html");
    }

    var modal = new bootstrap.Modal(document.getElementById("staticBackdrop"));
    modal.show();
}


function exportExcel() {
    var location = 'data:application/vnd.ms-excel;base64,';
    var excelTemplate = '<html> ' +
            '<head> ' +
            '<meta http-equiv="content-type" content="text/plain; charset=UTF-8"/> ' +
            '</head> ' +
            '<body> ' +
            '<table> ' +
            document.getElementById("myTable").innerHTML +
            '</table> ' +
            '</body> ' +
            '</html>';
    window.location.href = location + window.btoa(excelTemplate);
}

let partyprocess;
//to Add party for customers and vendors
function addParty() {
    ajax_call("POST", "PartyController", "process=addParty", "partyDIV", "html");
    var modal = new bootstrap.Modal(document.getElementById("staticBackdrop"));
    modal.show();
    partyprocess = document.getElementById("miniprocess").value;

}

function addcommonparty() {
    var partyId = document.getElementById("partyId").value;
    var partyName = document.getElementById("partyName").value;
    var partyType = document.getElementById("partyType").value;
    var phoneNo = document.getElementById("phoneNo").value;
    var address = document.getElementById("address").value;
    var city = document.getElementById("city").value;
    var state = document.getElementById("state").value;
    var transport = document.getElementById("transport").value;

    var validated =
            validate("partyId", "Party Id") &&
            validate("partyName", "Party Name") &&
            validate("partyType", "Party Type") &&
            validate("phoneNo", "Phone No") &&
            validate("address", "Address") &&
            validate("city", "city") &&
            validate("state", "State") &&
            validate("transport", "Transport");

    var data =
            "partyId=" + partyId +
            "&partyName=" + partyName +
            "&partyType=" + partyType +
            "&phoneNo=" + phoneNo +
            "&address=" + address +
            "&city=" + city +
            "&state=" + state +
            "&transport=" + transport;

    if (validated) {
        ajax_call("POST", "PartyController", data + "&process=insertParty", "mAjax");

        status = document.getElementById('mAjax').value;
        document.getElementById("cancelBtnPartyAdd").click();

        if (status === "DuplicateEntry") {
            alert('Duplicate ID It is Already Registered..!!!');
        } else if (status > 0 || '0') {
            alert('data inserted Succesfully!');
            party('customers');
        } else {
            alert("something went wrong!");
        }
    }

    return false;
}

function resetform() {
    document.getElementById('addparty' || 'addProduct' || 'addPayment').reset();
}


//to edit party for customers and vendors
function partyUpdate() {
    var partyId = document.getElementById("partyId").value;
    result =
            validate('partyName', 'Party Name') &&
            validate('phoneNo', 'PhoneNo') &&
            validate('address', 'Address') &&
            validate('city', 'city') &&
            validate('state', 'State') &&
            validate('transport', 'Transport');

    if (result) {

        var partyName = document.getElementById("partyName").value;
        var phoneNo = document.getElementById("phoneNo").value;
        var address = document.getElementById("address").value;
        var city = document.getElementById("city").value;
        var state = document.getElementById("state").value;
        var transport = document.getElementById("transport").value;


        data = "partyName=" + partyName +
                "&phoneNo=" + phoneNo +
                "&address=" + address +
                "&city=" + city +
                "&state=" + state +
                "&transport=" + transport +
                "&partyId=" + partyId +
                "&process=partyUpdate";

        ajax_call("POST", "PartyController", data, "mAjax");

        status = document.getElementById("mAjax").value;

        document.getElementById("closeModal").click();
        if (status > 0) {
            alert('data Updated succesfully');
            party(localStorage.getItem('process'));

        } else {
            alert('something went wrong!');
        }
    }

    return false;
}
//to delete party
function deleteParty(process) {
    var result = confirm("Are you sure!");
    if (result) {
        ajax_call("POST", "PartyController", "process=deleteParty&partyId=" + process, "partyDIV", false);
        var status = document.getElementById("partyDIV").value;
        if (status > 0) {
            alert("Deleted Successfully!");
            party(localStorage.getItem('process'));
        } else {
            alert("Technical error!");
        }
    }
}

//Product Ajax_call

function products() {
    setPage("Product Management");
    ajax_call("POST", "ProductController", "process=products", "mainDiv", 'html');

    let table = new DataTable('#myTable');

}

function addProduct() {

    ajax_call("POST", "ProductController", "process=addProduct", "productDIV", "html");
    var modal = new bootstrap.Modal(document.getElementById("staticBackdrop"));
    modal.show();
}

//insert Products

function insertProduct() {
    var productId = document.getElementById("productId").value;
    var productName = document.getElementById("productName").value;
    var price = document.getElementById("price").value;
    var quantity = document.getElementById("quantity").value;

    var validated =
            validate("productId", "Product Id") &&
            validate("productName", "Product Name") &&
            validate("price", "Product Price") &&
            validate("quantity", "GST Per(%)");

    var data = "productId=" + productId + "&productName=" + productName + "&price=" + price +
            "&quantity=" + quantity;

    if (validated) {
        ajax_call("POST", "ProductController", data + "&process=insertProduct", "mAjax", "isHTML");
        status = document.getElementById('mAjax').innerHTML;
        document.getElementById("cancelBtnProductAdd").click();
        if (status > 0 || '0') {
            alert('data inserted Succesfully!');
            products(partyprocess);
        } else {
            alert("something went wrong!");
        }
    }

    return false;
}


//to update product
function productUpdate() {
//    var rowid = element.getAttribute("rowid");
    var productId = document.getElementById("productId").value;
    result =
            validate("productId", "Product Id") &&
            validate("productName", "Product Name") &&
            validate("price", "Product Price") &&
            validate("quantity", "GST Per(%)");
    if (result) {
        var productName = document.getElementById("productName").value;
        var price = document.getElementById("price").value;
        var quantity = document.getElementById("quantity").value;

        data = "productId=" + productId + "&productName=" + productName +
                "&price=" + price + "&quantity=" + quantity +
                "&process=productUpdate";

        ajax_call("POST", "ProductController", data, "insertAjax");

        status = document.getElementById("insertAjax").value;
        document.getElementById("closeModal").click();
        if (status > 0) {
            products(localStorage.getItem('process'));
            alert('data Updated succesfully');
        } else {
            alert('something went wrong!');
        }

    }
    return false;
}
//for delete product
function delprod(element) {
//    var productId = element.closest("tr").cells[0].innerText;
    var res = confirm("Sure to Delete..?");
    if (res) {
        var status = document.getElementById("productDIV").innerHTML;
        ajax_call('POST', 'ProductController', 'process=delprod&productId=' + element, 'productDIV', true);
        var status = document.getElementById("productDIV").innerHTML;
        if (status > 0) {
            alert("Record Delete successfully..!");
            products();
        } else {
            alert("Somethoing went Wrong..!");
        }
    }
}
//import Excel
function toexcel() {
    var fileinput = document.getElementById("fileinput");
    fileinput.click();
}

//importFile
function importExcel() {
    var file = document.getElementById('fileinput');
    var file1 = file.files[0];
    var formData = new FormData();
    formData.append('file', file1);

    if (file) {
        ajax_call('POST', 'ImportFile', formData, 'partyDIV', 'isHtml', 'isfile');
        alert('FILE UPDLOADED SUCCESSFULLY..!');
    } else {
        alert('FILE TO SELECT KAR...!!');
    }
    return false;
}



//for Home Page
function dashboardContent(process) {

    document.getElementById("pageTitle").innerText = "Dashboard";
    ajax_call('POST', 'DashboardContent', 'process=' + process, 'mainDiv', 'isHtml');
}
function profile(process) {
    document.getElementById("pageTitle").innerText = "Profile";
    ajax_call('POST', 'ProfileController', 'process=' + process, 'mainDiv', 'isHtml');
}