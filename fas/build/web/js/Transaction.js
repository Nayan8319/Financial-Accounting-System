/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */

function validationEmpty(elementId, elementName) {
    var value = document.getElementById(elementId).value.trim();
    if (value === '') {
        alert(elementName + " can'not be Empty!");
        document.getElementById(elementId).focus();
        return false;
    }
    return true;
}

function ajaxCall(method, url, data, destination, ishtml) {
    var xhttp = new XMLHttpRequest();
    // event
    xhttp.onload = function () {
        if (ishtml) {
            document.getElementById(destination).innerHTML = this.responseText;
        } else {
            document.getElementById(destination).value = this.responseText;
        }
    };
    xhttp.open(method, url, false);

    xhttp.setRequestHeader('content-type', 'application/x-www-form-urlencoded');
    xhttp.send(data);
}

function btnRemover() {
    div = document.getElementById("BTNcontainer").style = "display:none !important";
}
function btnAdd() {
    div = document.getElementById("BTNcontainer").style = "display:block";
}

function removeFormInput() {
    form = document.getElementById("formINPUT").elements;
    for (i = 0; i < form.length; i++) {
        if (form[i].type !== 'button') {
            form[i].value = "";
        }
    }
    itemFooter = document.getElementById('itemFooter').getElementsByClassName('col');
    for (i = 0; i < itemFooter.length; i++) {
        itemFooter[i].innerHTML = "-";

    }
    items = document.getElementById('itemsList').getElementsByClassName('row');
    rowNoInput = items[0].getElementsByTagName('input')[0].value = "1";
    for (i = 1; i < items.length; i++) {
        items[i].remove();
    }
}
function disabelopner() {
    form = document.getElementById("formINPUT").elements;
    for (i = 0; i < form.length; i++) {
        if (form[i].type !== 'button') {
            form[i].disabled = false;
        }
    }
    items = document.getElementById('itemsList').getElementsByClassName('row');
    rowNoInput = items[0].getElementsByTagName('input')[0].disabled = true;
}
function disabelMaker() {
    form = document.getElementById("formINPUT").elements;
    for (i = 0; i < form.length; i++) {
        if (form[i].type !== 'button') {
            form[i].disabled = true;
        }
    }
}
//first time sales(process.jsp) just for down nav bar
function Salestransaction() {
    setPage("Sales Transactions");
    ajaxCall('POST', 'TransactionController', 'process=sales', 'mainDiv', 'html');
    lastsales();
}
// for last data
function lastsales() {
    ajaxCall('POST', 'TransactionController', 'process=saleslast', 'dataLoader', 'html');
    disabelMaker();
}
// for bottom view button
function viewAllSales() {
    btnRemover();
    ajaxCall('POST', 'TransactionController', 'process=Allsales', 'dataLoader', 'html');
    let table = new DataTable('#myTable');
}
//purchase
function Purchasetransaction() {
    setPage("Purchase Transactions");
    ajaxCall('POST', 'TransactionController', 'process=purchase', 'mainDiv', 'html');
    lastPurchase();
}
function lastPurchase() {
    ajaxCall('POST', 'TransactionController', 'process=Purchaselast', 'dataLoader', 'html');
    disabelMaker();
}
function viewAllpurchase() {
    ajaxCall('POST', 'TransactionController', 'process=AllPurchase', 'dataLoader', 'html');
    btnRemover();
    let table = new DataTable('#myTable');
}
//for table row data into input box
function dataToInput(element, miniProcess) {
    rowid = element.getAttribute('rowid');
    ajaxCall('POST', 'TransactionController', 'process=EditViewData' + '&rowid=' + rowid + '&miniProcess=' + miniProcess, 'dataLoader', 'html');
    disabelMaker();
    btnAdd();
}
//for update view form
function editTransaction() {
    disabelopner();
    btn = document.getElementById("submitUpdate").style.display = "block";
    document.getElementById("cancelBtn").style.display = "block";
    btn = document.getElementById("submitNew").style.display = "none";
    btnRemover();
}

function UpdateTransaction(miniprocess) {
    var result = validationEmpty('id', 'transaction id')
            && validationEmpty('partyName', 'partyName')
            && validationEmpty('transport', 'transport')
            && validationEmpty('transactionDate', 'transaction Date');

    itemString = "";
    itemRows = document.getElementById('itemsList').getElementsByClassName('row');
    for (i = 0; i < itemRows.length; i++) {

        itemColumns = itemRows[i].getElementsByTagName('input');
        for (j = 1; j < itemColumns.length; j++) {
            colValue = itemColumns[j].value;
            if (colValue !== "") {
                if (j === 1)
                    itemString += colValue;
                else
                    itemString += "," + colValue;
            } else {
                alert('item field cannot be Empty!');
                itemColumns[j].focus();
                return;
            }
        }
        if (i !== itemRows.length - 1)
            itemString += ";";
    }

    if (result) {
        var id = document.getElementById("id").value;
        var partyName = document.getElementById("partyName").value;
        var productName = document.getElementById("productName").value;
        var rate = document.getElementById("rate").value;
        var quantity = document.getElementById("quantity").value;
        var netAmt = document.getElementById("netAmt").value;
        var gstPer = document.getElementById("gstPer").value;
        var gstAmt = document.getElementById('gstAmt').value;
        var transport = document.getElementById('transport').value;
        var transactionDate = document.getElementById('transactionDate').value;

        data = 'id=' + id +
                '&partyName=' + partyName +
                '&productName=' + productName +
                '&rate=' + rate +
                '&quantity=' + quantity +
                '&netAmt=' + netAmt +
                '&gstPer=' + gstPer +
                '&gstAmt=' + gstAmt +
                '&transport=' + transport +
                '&transactionDate=' + transactionDate +
                '&process=salesupdate' +
                '&itemString=' + itemString +
                '&miniProcess=' + miniprocess;

        ajaxCall('POST', 'TransactionController', data, 'dataLoader', 'html');

        status = document.getElementById("UpdateDelete").value;
        if (status > 0) {
            alert("transaction Updated");
        } else if (status === '0') {
            alert("inappropriate items Fiels");
        } else {
            alert("transaction Not Updated /ndata may be currupt");
        }
        if (miniprocess === 'sales') {
            lastsales();
        } else {
            lastPurchase();
        }
    }
    disabelMaker();
    btnAdd();
    return false;
}
// for insert
function newTransaction() {
    document.getElementById("submitNew").style.display = "block";
    document.getElementById("cancelBtn").style.display = "block";
    document.getElementById("transactionDate").disabled = false;
    removeFormInput();
    disabelopner();
    btnRemover();
}

function AddTransaction(miniprocess) {
    var result = validationEmpty('id', 'transaction id')
            && validationEmpty('partyName', 'partyName')
            && validationEmpty('transport', 'transport')
            && validationEmpty('transactionDate', 'transaction Date');

    itemString = "";
    itemRows = document.getElementById('itemsList').getElementsByClassName('row');
    for (i = 0; i < itemRows.length; i++) {

        itemColumns = itemRows[i].getElementsByTagName('input');
        for (j = 1; j < itemColumns.length; j++) {
            colValue = itemColumns[j].value;
            if (colValue !== "") {
                if (j === 1)
                    itemString += colValue;
                else
                    itemString += "," + colValue;
            } else {
                alert('item field cannot be Empty!');
                itemColumns[j].focus();
                return;
            }
        }
        if (i !== itemRows.length - 1)
            itemString += ";";
    }

    if (result) {
        var id = document.getElementById("id").value;
        var partyName = document.getElementById("partyName").value;
        var productName = document.getElementById("productName").value;
        var rate = document.getElementById("rate").value;
        var quantity = document.getElementById("quantity").value;
        var netAmt = document.getElementById("netAmt").value;
        var gstPer = document.getElementById("gstPer").value;
        var gstAmt = document.getElementById('gstAmt').value;
        var transport = document.getElementById('transport').value;
        var transactionDate = document.getElementById('transactionDate').value;

        data = 'id=' + id +
                '&partyName=' + partyName +
                '&productName=' + productName +
                '&rate=' + rate +
                '&quantity=' + quantity +
                '&netAmt=' + netAmt +
                '&gstPer=' + gstPer +
                '&gstAmt=' + gstAmt +
                '&transport=' + transport +
                '&transactionDate=' + transactionDate +
                '&process=AddTransaction' +
                '&itemString=' + itemString +
                '&miniProcess=' + miniprocess;

        ajaxCall('POST', 'TransactionController', data, 'dataLoader', 'isHtml');

        status = document.getElementById("UpdateDelete").value;
        if (status > 0) {
            alert("transaction Inserted");
        } else if (status === '0') {
            alert("inappropriate items Fiels");
        } else {
            alert("transaction Not Inserted /ndata may be currupt");
        }
        if (miniprocess === 'sales') {
            lastsales();
        } else {
            lastPurchase();
        }
    }
    btnAdd();
    return false;
}

function deleteTransaction(miniProcess) {
    var TransactionId = document.getElementById("id").value;
    var result = confirm("do you Want to delete this ?");
    if (result) {
        data = 'tranId=' + TransactionId + '&process=deleteSales' + '&miniProcess=' + miniProcess;
        ajax_call('POST', 'TransactionController', data, 'dataLoader', 'html');
        if (document.getElementById("UpdateDelete").value > 0) {
            alert("data deleted!");
        }
        if (miniProcess === 'sales') {
            lastsales();
        } else {
            lastPurchase();
        }
    }
}

function CancelBtn(process) {
    if (process === 'sales') {
        lastsales();

    } else if (process === 'purchase') {
        lastPurchase();
    }
    btnAdd();
}


function addItemsRow() {
    var itemsList = document.getElementById('itemsList');
    rowCount = itemsList.childElementCount;
    var newRow = document.createElement('div');
    newRow.className = "row";
    newRow.innerHTML = `<div style="width: 150px;"><input style="width: 150px;"class="bg-white border border-dark"  onkeyup="changeTotals()" class="bg-white" type="number" disabled value="${rowCount + 1}"></div>
                        &nbsp;
                        <div style="width: 150px;"><input style="width: 150px;"class="bg-white border border-dark" onkeyup="changeTotals()" type="text"></div>
                        &nbsp;
                        <div style="width: 150px;"><input style="width: 150px;"class="bg-white border border-dark" onkeyup="changeTotals()" type="number"></div>
                        &nbsp;
                        <div style="width: 150px;"><input style="width: 150px;"class="bg-white border border-dark" <div class="col"><input onkeyup="changeTotals()" type="number"></div>
                        &nbsp;
                        <div style="width: 150px;"><input style="width: 150px;"class="bg-white border border-dark" <div class="col"><input onkeyup="changeTotals()" type="number"></div>
                        &nbsp;
                        <div style="width: 150px;"><input style="width: 150px;"class="bg-white border border-dark" <div class="col"><input onkeyup="changeTotals()" type="number"></div>
                        &nbsp;
                        <div style="width: 150px;"><input style="width: 150px;"class="bg-white border border-dark" <div class="col"><input onkeyup="changeTotals()" type="number"></div>
                        &nbsp;
                        <div style="width: 150px;"><input style="width: 150px;"class="bg-white border border-dark" <div class="col"><input onkeyup="changeTotals()" type="number"></div>
                `;
    itemsList.append(newRow);
    nameInput = newRow.getElementsByClassName('col')[0].getElementsByTagName('input')[0];
    nameInput.focus();
    return false;
}

// updating total values on current time

function changeTotals() {
    var netAmt = 0, gstAmt = 0, totalAmt = 0;
    itemRows = document.getElementById('itemsList').getElementsByClassName('row');
    for (i = 0; i < itemRows.length; i++) {
        itemColumns = itemRows[i].getElementsByTagName('input');
        netAmt = netAmt + valToInt(itemColumns[4].value);
        gstAmt = gstAmt + valToInt(itemColumns[6].value);
        totalAmt = totalAmt + valToInt(itemColumns[7].value);
        itemColumns[4].value = itemColumns[2].value * itemColumns[3].value;
        itemColumns[6].value = itemColumns[4].value * itemColumns[5].value / 100;
        itemColumns[7].value = valToInt(itemColumns[4].value) + valToInt(itemColumns[6].value);
    }
    document.getElementById("netAmt").innerText = netAmt;
    document.getElementById("gstAmt").innerText = gstAmt;
    document.getElementById("totalAmt").innerText = totalAmt;
}

// changing input values into integer...

function valToInt(val) {
    val = parseInt(val);

    if (isNaN(val)) {
        return 0;
    } else {
        return val;
    }

}


// function for showing the list for inputs...
function showList(process, element) {
    var parent = element.parentElement;
    if (parent.childElementCount < 3) {
        let div = document.createElement("div");
        div.setAttribute("id", "list");
        div.setAttribute("style", "width:80%;position:absolute;background:white;");
        parent.append(div);
        ajax_call('POST', 'ListController', "process=" + process, 'list', 'html');

    }
    document.getElementById("myDropdown").classList.add("show");
}


// function for Removes the list for inputs...
function removeList() {
    setTimeout(function () {
        document.getElementById("list").remove();
    }, 200);

}

// function for filter the list for inputs...
function filterList(element) {
    var filter, a, i;
    filter = element.value.toUpperCase();
    div = document.getElementById("myDropdown");
    a = div.getElementsByTagName("a");
    for (i = 0; i < a.length; i++) {
        txtValue = a[i].textContent || a[i].innerText;
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            a[i].style.display = "";
        } else {
            a[i].style.display = "none";
        }
    }
}

//for fill the value which come from the db
function fillValue(element) {
    var list = document.getElementById("list");
    var parent = list.parentElement;
    var input = parent.getElementsByTagName("input");
    input[0].value = element.textContent;

}


//for InvoicePage
function invoice(element, process) {

    rowid = element.getAttribute('rowid');
    ajax_call('POST', 'PaymentsController', 'process=' + process + '&rowid=' + rowid, 'mainDiv', 'html');
}


function payment(element, process) {
    rowid = element.getAttribute('rowid');
    ajax_call('POST', 'TransactionController', 'process=' + process + '&rowid=' + rowid, 'dataLoader', 'html');
}



//insert payment
function insertPayment() {

    var paymentId = document.getElementById("paymentId").value;
    var transactionId = document.getElementById("transactionId").value;
    var transactionDate = document.getElementById("transactionDate").value;
    var partyName = document.getElementById("partyName").value;
    var address = document.getElementById("address").value;
    var city = document.getElementById("city").value;
    var state = document.getElementById("state").value;
    var transport = document.getElementById("transport").value;
    var productName = document.getElementById("productName").value;
    var rate = document.getElementById("rate").value;
    var quantity = document.getElementById("quantity").value;
    var netAmt = document.getElementById("netAmt").value;
    var gstPer = document.getElementById("gstPer").value;
    var gstAmt = document.getElementById("gstAmt").value;
    var totalAmt = document.getElementById("totalAmt").value;
    var paymentMethod = document.getElementById("paymentMethod").value;

    var validated =
            validationEmpty("paymentId", "paymentId") &&
            validationEmpty("transactionId", "transactionId") &&
            validationEmpty("transactionDate", "transactionDate") &&
            validationEmpty("partyName", "partyName") &&
            validationEmpty("address", "address ") &&
            validationEmpty("city", "city ") &&
            validationEmpty("state", "state ") &&
            validationEmpty("transport", "transport") &&
            validationEmpty("productName", "productName") &&
            validationEmpty("rate", "rate") &&
            validationEmpty("quantity", "quantity") &&
            validationEmpty("netAmt", "netAmt") &&
            validationEmpty("gstPer", "gstPer") &&
            validationEmpty("gstAmt", "gstAmt") &&
            validationEmpty("totalAmt", "totalAmt") &&
            validationEmpty("paymentMethod", "paymentMethod");

    var data = "paymentId=" + paymentId +
            "&transactionId=" + transactionId +
            "&transactionDate=" + transactionDate +
            "&partyName=" + partyName +
            "&address=" + address +
            "&city=" + city +
            "&state=" + state +
            "&transport=" + transport +
            "&productName=" + productName +
            "&rate=" + rate +
            "&quantity=" + quantity +
            "&netAmt=" + netAmt +
            "&gstPer=" + gstPer +
            "&gstAmt=" + gstAmt +
            "&totalAmt=" + totalAmt +
            "&paymentMethod=" + paymentMethod;

    if (validated) {
        ajax_call('POST', 'PaymentsController', data + '&process=insertPayment', 'paymentsDiv',"htm");
        
        status = document.getElementById('paymentsDiv').innerHTML;
        if (status > 0) {
            alert("Payment successfull.");
            viewAllPayments('viewAllPyments');
        } else if (status === '0') {
            alert("inappropriate items Fiels");
        } else {
//            alert("Payment Not Inserted Some Technical problem .");
        }
    }
    return false;
}

function success(){
    
}

function viewAllPayments() {
    
    setPage("Payment");
    ajaxCall('POST', 'PaymentsController', 'process=viewAllPayments', 'mainDiv', 'html');
    let table = new DataTable('#myTable');
}




//for PaymentMethod Page
//function payment(process) {
//    ajax_call('POST', 'TransactionController', "process=" + process, 'dataLoader', 'html');
//}

//for show and hode card and cash div
//function showCard() {
//    document.getElementById('cardDiv').style.display = 'block';
//    document.getElementById('cashDiv').style.display = 'none';
//}
//
//function showCash() {
//    document.getElementById('cardDiv').style.display = 'none';
//    document.getElementById('cashDiv').style.display = 'block';
//}
//
//
////validateCard
//function validationEmpty(elementId, elementName) {
//    var value = document.getElementById(elementId).value.trim();
//    if (value === '') {
//        alert(elementName + " can'not be Empty!");
//        document.getElementById(elementId).focus();
//        return false;
//    }
//
//    // Get input values
//    var cardNumber = document.getElementById('cardNo').value.trim();
//    var expiryMonth = document.getElementById('expMonth').value.trim();
//    var expiryYear = document.getElementById('expYear').value.trim();
//
//    // Validate card number format (assuming it's a 16-digit number)
//    var cardNumberPattern = /^\d{16}$/;
//    if (!cardNumberPattern.test(cardNumber)) {
//        alert('Please enter a valid 16-digit card number');
//        return false;
//    }
//
//    // Validate expiry month (1 to 12)
//    var month = parseInt(expiryMonth);
//    if (month < 1 || month > 12) {
//        alert('Please enter a valid month (1 - 12)');
//        return false;
//    }
//
//    // Validate expiry year (24 to 35)
//    var year = parseInt(expiryYear);
//    if (year < 24 || year > 35) {
//        alert('Please enter a valid year (24 - 35)');
//        return false;
//    }
//    // If all validations pass, return true
//    return true;
//}