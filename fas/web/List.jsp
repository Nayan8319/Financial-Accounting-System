<%-- 
    Document   : List
    Created on : 4 Jan 2024, 16:32:48
    Author     : NSP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet" %>

<link href="css/list.css" rel="stylesheet">

<div class="dropdown">
  <div id="myDropdown" class="dropdown-content show active">
    <%
        ResultSet rs = (ResultSet) request.getAttribute("resultList");
        String column = (String) request.getAttribute("column");
        while(rs.next())
        {
    %>
            <a onclick="fillValue(this)"><%=rs.getString(column)%></a>
    <%
        }
    %>
  </div>
</div>



<!--

/* When the user clicks on the button,
toggle between hiding and showing the dropdown content */
function myFunction() {
  document.getElementById("myDropdown").classList.toggle("show");
}

function filterFunction() {
  var input, filter, ul, li, a, i;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
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