/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.UserService;

/**
 *
 * @author NSP
 */
public class UserController extends HttpServlet {

    UserService userService = new UserService();

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
            String process = request.getParameter("process");

            if (process.equals("insert") || process.equals("update")) {

                String user = request.getParameter("user");
                String email = request.getParameter("email");
                String gender = request.getParameter("gender");
                String phoneNo = request.getParameter("phoneNo");
                String address = request.getParameter("address");
                String city = request.getParameter("city");
                String state = request.getParameter("state");
                String salary = request.getParameter("salary");
                String joiningDate = request.getParameter("joiningDate");
                String permissions = request.getParameter("permissions");
                String salesSub = request.getParameter("sales_SubPermission");
                String purchaseSub = request.getParameter("purchase_SubPermission");
                String productsSub = request.getParameter("products_SubPermission");
                String vendorsSub = request.getParameter("vendors_SubPermission");
                String customersSub = request.getParameter("customers_SubPermission");

                if (process.equals("insert")) {
                    Random random = new Random();
                    String pass = "abc" + random.nextInt(999);
//                emailSender.sendEmail(email, "otp verification", "your otp for email verification is"+pass);
                    int status = userService.insertUser(user, pass, email, gender, phoneNo, address, city, state, salary, joiningDate, permissions, salesSub, purchaseSub, productsSub, vendorsSub, customersSub);
                    out.print(status);
                } else if (process.equals("update")) {

                    int userId = Integer.parseInt(request.getParameter("userId"));
                    int status = userService.updateUser(userId, user, email, gender, phoneNo, address, city, state, salary, joiningDate, permissions, salesSub, purchaseSub, productsSub, vendorsSub, customersSub);
                    out.print(status);
                }
            } else {
                if (process.equals("viewUser")) {
                    ResultSet rs = userService.getAllUser();
                    request.setAttribute("result", rs);
                } else if (process.equals("deleteUser")) {
                    request.setAttribute("process", process);
                    int userId = Integer.parseInt(request.getParameter("userId"));
                    int result = userService.deleteUser(userId);
                    System.out.println(result);
                    if (result > 0) {
                        out.print("1");
                    } else {
                        out.print("0");
                    }
                } else if (process.equals("userEdit")) {
                    int id = Integer.parseInt(request.getParameter("userid"));
                    ResultSet rs = userService.getUser(id);
                    request.setAttribute("result", rs);
                }
                request.setAttribute("process", process);
                RequestDispatcher rd = request.getRequestDispatcher("UserManagement.jsp");
                rd.forward(request, response);
            }

        } catch (IOException | SQLException ex) {
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
