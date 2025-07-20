/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.PaymentsService;

/**
 *
 * @author NSP
 */
public class PaymentsController extends HttpServlet {

    PaymentsService paymentsService = new PaymentsService();

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
            if (process.equals("insertPayment")) {
                int paymentId = Integer.parseInt(request.getParameter("paymentId"));
                int transactionId = Integer.parseInt(request.getParameter("transactionId").trim());
                String transactionDate = request.getParameter("transactionDate");
                String partyName = request.getParameter("partyName");
                String address = request.getParameter("address");
                String city = request.getParameter("city");
                String state = request.getParameter("state");
                String transport = request.getParameter("transport");
                String productName = request.getParameter("productName");
                int rate = Integer.parseInt(request.getParameter("rate").trim());
                int quantity = Integer.parseInt(request.getParameter("quantity").trim());
                int netAmt = Integer.parseInt(request.getParameter("netAmt").trim());
                int gstPer = Integer.parseInt(request.getParameter("gstPer").trim());
                int gstAmt = Integer.parseInt(request.getParameter("gstAmt").trim());
                int totalAmt = Integer.parseInt(request.getParameter("totalAmt").trim());
                String paymentMethod = request.getParameter("paymentMethod");

                int status = paymentsService.insertPayment(paymentId, transactionId, transactionDate, partyName, address, city, state, transport, productName, rate, quantity, netAmt, gstPer, gstAmt, totalAmt, paymentMethod);

                if (status > 0) {
                    out.print(1);
                } else {
                    out.print(0);
                }
            } else if (process.equals("viewAllPayments")) {
                ResultSet rs = paymentsService.getAllPayments();
                request.setAttribute("result", rs);
            } 
            //for add to invoice page
            else if (process.equals("invoice")) {
                int rowid = Integer.parseInt(request.getParameter("rowid"));
                ResultSet rs = paymentsService.getPayment(rowid,"payment");
                request.setAttribute("rs", rs);
                request.setAttribute("process", process);
                RequestDispatcher view = request.getRequestDispatcher("Sales.jsp");
                view.forward(request, response);
            }
            request.setAttribute("process", process);
            RequestDispatcher rd = request.getRequestDispatcher("Sales.jsp");
            rd.forward(request, response);

        } catch (SQLException ex) {
            out.print(ex);
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
