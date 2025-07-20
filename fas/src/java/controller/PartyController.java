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
import service.PartyService;

/**
 *
 * @author NSP
 */
public class PartyController extends HttpServlet {

    PartyService partyService = new PartyService();

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
            try {
                String process = request.getParameter("process");
                if (process.equals("vendors")) {
                    ResultSet rs = partyService.getAllVendors();
                    request.setAttribute("result", rs);
                } else if (process.equals("customers")) {
                    ResultSet rs = partyService.getAllCustomers();
                    request.setAttribute("result", rs);
                } else if (process.equals("editParty")) {
                    String partyId = request.getParameter("partyId");
                    ResultSet rs = partyService.getParty(partyId);
                    request.setAttribute("result", rs);
                } else if (process.equals("addParty")) {
                    ResultSet rs = partyService.getParty("partyId");
                    request.setAttribute("result", rs);

                } else if (process.equals("insertParty")) {

                    String partyId = request.getParameter("partyId");
                    String partyName = request.getParameter("partyName");
                    String partyType = request.getParameter("partyType");
                    String phoneNo = request.getParameter("phoneNo");
                    String address = request.getParameter("address");
                    String city = request.getParameter("city");
                    String state = request.getParameter("state");
                    String transport = request.getParameter("transport");
                    
                    ResultSet rs = partyService.getParty("partyId");
                    request.setAttribute("result", rs);

                    int status = partyService.insertParty(partyId, partyName, partyType,phoneNo, address, city,state, transport);
                    System.out.println(status);
                    if (status > 0) {
                        out.print(1);
                    } else {
                        out.print(0);
                    }
                } else if (process.equals("partyUpdate")) {

                    String partyName = request.getParameter("partyName");
                    String phoneNo = request.getParameter("phoneNo");
                    String address = request.getParameter("address");
                    String city = request.getParameter("city");
                    String state = request.getParameter("state");
                    String transport = request.getParameter("transport");
                    String partyId = request.getParameter("partyId");

                    int status = partyService.updateParty(partyName,phoneNo, address, city,state, transport, partyId);
                    System.out.println(status);
                    if (status > 0) {
                        out.print(1);
                    } else {
                        out.print(0);
                    }

                }

                if (process.equals("deleteParty")) {
                    request.setAttribute("process", process);
                    String partyId = request.getParameter("partyId");
                    int status = partyService.deleteParty(partyId);
                    if (status > 0) {
                        out.print("1");
                    } else {
                        out.print("0");
                    }
                }
                if (!(process.equals("partyUpdate")) && !(process.equals("deleteParty"))) {

                    request.setAttribute("process", process);
                    RequestDispatcher rd = request.getRequestDispatcher("Party.jsp");
                    rd.forward(request, response);
                }

            } catch (SQLException ex) {
                if (ex.getMessage().contains("partyMaster.PRIMARY")) {
                    out.print("DuplicateEntry");
                } else {
                    out.print(ex.getMessage());
                }
            }
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
        protected void doGet
        (HttpServletRequest request, HttpServletResponse response)
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
        protected void doPost
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request, response);
        }

        /**
         * Returns a short description of the servlet.
         *
         * @return a String containing servlet description
         */
        @Override
        public String getServletInfo
            
        
            () {
        return "Short description";
        }// </editor-fold>
    }
