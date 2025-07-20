/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.PartyService;
import service.ProductService;
import service.TransactionService;

/**
 *
 * @author NSP
 */
public class ReportsController extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            String process = request.getParameter("process");
            if (process.equals("sales")) {
                TransactionService ts = new TransactionService();
                ResultSet rs = ts.getAllSales();
                request.setAttribute("result", rs);
            } 
            else if (process.equals("purchase")) {
                TransactionService ts = new TransactionService();
                ResultSet rs = ts.getAllPurchases();
                request.setAttribute("result", rs);
            } 
            else if (process.equals("products")) {
                ProductService ps = new ProductService();
                ResultSet rs = ps.getAllProducts();
                request.setAttribute("result", rs);
            } 
            else if (process.equals("vendors")) {
                PartyService pas = new PartyService();
                ResultSet rs = pas.getAllVendors();
                request.setAttribute("result", rs);
            } 
            else if (process.equals("customers")) {
                PartyService pas = new PartyService();
                ResultSet rs = pas.getAllCustomers();
                request.setAttribute("result", rs);
            }
            request.setAttribute("process", process);
            RequestDispatcher rd = request.getRequestDispatcher("Reports.jsp");
            rd.forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(ReportsController.class.getName()).log(Level.SEVERE, null, ex);
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
  