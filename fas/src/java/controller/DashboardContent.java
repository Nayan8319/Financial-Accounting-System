/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import static java.lang.System.out;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.DashboardContentService;
import service.PartyService;
import service.ProductService;
import service.TransactionService;

/**
 *
 * @author NSP
 */
public class DashboardContent extends HttpServlet {

    DashboardContentService deshContentService = new DashboardContentService();
    PartyService partyService = new PartyService();
    ProductService productService = new ProductService();
    TransactionService transactionService = new TransactionService();

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

        try {
            String process = request.getParameter("process");

            if (process.equals("dashboardContent")) {
                ResultSet rs = deshContentService.countProducts();
                ResultSet rs1 = deshContentService.countCustomers();
                ResultSet rs2 = deshContentService.countSales();
                ResultSet rs3 = deshContentService.rsTotalSales();
                ResultSet rs4 = deshContentService.rsLastYearSales();
                ResultSet rs5 = partyService.getAllCustomers();
                ResultSet rs6 = productService.getAllProducts();
                ResultSet rs7 = transactionService.getAllSales();

                request.setAttribute("rsProducts", rs);
                request.setAttribute("rsCustomers", rs1);
                request.setAttribute("rsSales", rs2);
                request.setAttribute("rsTotalSales", rs3);
                request.setAttribute("rsLastYearSales", rs4);
                request.setAttribute("rsAllCustomers", rs5);
                request.setAttribute("rsAllProducts", rs6);
                request.setAttribute("rsAllSales", rs7);
            }
            request.setAttribute("process", process);
            RequestDispatcher rd = request.getRequestDispatcher("DashboardContent.jsp");
            rd.forward(request, response);

        } catch (Exception ex) {
            out.print(ex.getMessage());
        }
//        finally {
//            out.close();
//        }
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
