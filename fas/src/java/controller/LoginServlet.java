/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import service.LoginService;

/**
 *
 * @author NSP
 */
public class LoginServlet extends HttpServlet {
    
    LoginService loginService = new LoginService();
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String username = request.getParameter("user");
            String password = request.getParameter("pass");
            String userType = request.getParameter("type");
            int status = 0;
            HttpSession session = request.getSession();
            if (userType.equals("admin")) {
                status = loginService.adminLogin(username, password);
                if (status > 0) {
                    out.print("admin");
                    session.setAttribute("user", username);
                    session.setAttribute("usertype", userType);
                } else {
                    out.print("0");
                }

            } else {
                status = loginService.userLogin(username, password);
                if (status > 0) {
                    String permission = "";
                    String salePermission = "";
                    String purchasePermission = "";
                    String productsPermission = "";
                    String customersPermission = "";
                    String vendorsPermission = "";
                    String gender = "";
                    String email = "";
                    String phoneNo = "";
                    String address = "";
                    String city = "";
                    String state = "";
                    String salary = "";
                    String joiningDate = "";
                    out.print("user");
//                    out.print("email");
//                    out.print("gender");
//                    out.print("phoneNo");
//                    out.print("address");
//                    out.print("city");
                    ResultSet rs = loginService.userPermission(username, password);
                    while (rs.next()) {
                        permission = rs.getString("permissions");
                        salePermission = rs.getString("salesPermission");
                        purchasePermission = rs.getString("purchasePermission");
                        productsPermission = rs.getString("productsPermission");
                        customersPermission = rs.getString("customersPermission");
                        vendorsPermission = rs.getString("vendorsPermission");
                    }
                    session.setAttribute("permission", permission);
                    session.setAttribute("salePermission", salePermission);
                    session.setAttribute("purchasePermission", purchasePermission);
                    session.setAttribute("productsPermission", productsPermission);
                    session.setAttribute("customersPermission", customersPermission);
                    session.setAttribute("vendorsPermission", vendorsPermission);
                    session.setAttribute("user", username);
//                    session.setAttribute("email",email );
//                    session.setAttribute("gender",gender );
//                    session.setAttribute("phoneNo", phoneNo);
//                    session.setAttribute("address", address);
//                    session.setAttribute("city", city);
//                    session.setAttribute("state", state);
//                    session.setAttribute("salary", salary);
//                    session.setAttribute("joiningDate", joiningDate);
                    
                    session.setAttribute("usertype", userType);
                } else {
                    out.print("0");
                }
            }

        } catch (Exception ex) {
            out.print(ex.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
