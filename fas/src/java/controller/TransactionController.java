/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.TransactionService;

/**
 *
 * @author NSP
 */
public class TransactionController extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            try {
                String process = request.getParameter("process");
                String miniProcess = request.getParameter("miniProcess");                        
                if (process.equals("sales")) {
                    request.setAttribute("process", process);
                    RequestDispatcher view = request.getRequestDispatcher("Sales.jsp");
                    view.forward(request, response);
                } else if (process.equals("saleslast")) {
                    ResultSet rs = transactionService.SalesLast();
                    int saleId = transactionService.getLastSaleTransactionId();
                    ResultSet rs2 = transactionService.getItemsForTransaction(saleId, "sales");
                    request.setAttribute("result", rs);
                    request.setAttribute("result1", rs2);
                    request.setAttribute("process", process);
                    RequestDispatcher view = request.getRequestDispatcher("Sales.jsp");
                    view.forward(request, response);
                } else if (process.equals("Allsales")) {
                    ResultSet rs = transactionService.getAllSales();
                    request.setAttribute("result", rs);

                    request.setAttribute("process", process);
                    RequestDispatcher view = request.getRequestDispatcher("Sales.jsp");
                    view.forward(request, response);
                } 
               
                //for payment page
                else if (process.equals("payment")) {                    
                    int rowid = Integer.parseInt(request.getParameter("rowid"));
                    ResultSet rs= transactionService.getSale(rowid,"saleTransactions");
                    request.setAttribute("rs", rs);
                    request.setAttribute("process", process);
                    RequestDispatcher view = request.getRequestDispatcher("Sales.jsp");
                    view.forward(request, response);
                }
                //for editViewData
                else if (process.equals("EditViewData")) {
                    int rowid = Integer.parseInt(request.getParameter("rowid"));
                    ResultSet rs;
                    if (miniProcess.equals("sales")) {
                        rs = transactionService.EditViewData(rowid, "saleTransactions");
                    } else {
                        rs = transactionService.EditViewData(rowid, "purchaseTransactions");
                    }
                    ResultSet rs2 = transactionService.getItemsForTransaction(rowid, miniProcess);
                    request.setAttribute("result", rs);
                    request.setAttribute("result1", rs2);
                    request.setAttribute("process", process);
                    if (miniProcess.equals("sales")) {
                        RequestDispatcher view = request.getRequestDispatcher("Sales.jsp");
                        view.forward(request, response);
                    } else if (miniProcess.equals("purchase")) {
                        RequestDispatcher view = request.getRequestDispatcher("Purchase.jsp");
                        view.forward(request, response);
                    }

                } else if (process.equals("AddTransaction") || process.equals("salesupdate")) {
                    int transactionId = Integer.parseInt(request.getParameter("id"));
                    String partyName = request.getParameter("partyName");                    
                    String productName = request.getParameter("productName");
                    int rate = Integer.parseInt(request.getParameter("rate"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    int netAmt = Integer.parseInt(request.getParameter("netAmt"));
                    int gstPer = Integer.parseInt(request.getParameter("gstPer"));
                    int gstAmt = Integer.parseInt(request.getParameter("gstAmt"));
                    String transport = request.getParameter("transport");
                    String transactionDate = request.getParameter("transactionDate");
                    int totalAmt = netAmt + gstAmt;
                    
                    String table = "";
                    if (miniProcess.equals("sales")) {
                        table = "saleTransactions";
                    } else if (miniProcess.equals("purchase")) {
                        table = "purchaseTransactions";
                    }

                    //for sales items
                    String items = request.getParameter("itemString");
                    String[] itemsRow = items.split(";");

                    boolean valid = true;
                    outerloop:
                    for (String row : itemsRow) {
                        String[] itemsValue = row.split(",");

                        if (itemsValue.length != 7) {
                            valid = false;
                            break;
                        }
                        for (String value : itemsValue) {

                            if (value.trim().equals("")) {
                                valid = false;
                                break outerloop;
                            }
                        }
                    }
                    int status = 0;

                    if (valid) {
                        int itemId, intemRate, itemQuantity, itemNetAmt, itemGstPer, itemGstAmt, itemTotalAmt;
                        String itemName;
                        for (String row : itemsRow) {
                            String[] itemsValue = row.split(",");

                            // itemId should be change after item managment... 
                            itemId = 12;
                            itemName = itemsValue[0];
                            intemRate = Integer.parseInt(itemsValue[1]);
                            itemQuantity = Integer.parseInt(itemsValue[2]);
                            itemNetAmt = Integer.parseInt(itemsValue[3]);
                            itemGstPer = Integer.parseInt(itemsValue[4]);
                            itemGstAmt = Integer.parseInt(itemsValue[5]);
                            itemTotalAmt = Integer.parseInt(itemsValue[6]);
                            if (process.equals("AddTransaction")) {
                                transactionService.insertItemToTransaction(itemId, itemName, intemRate, itemQuantity, itemNetAmt, itemGstPer, itemGstAmt, itemTotalAmt, transactionId, miniProcess);
                            } else {
                                transactionService.updateItemForTransaction(itemId, itemName, intemRate, itemQuantity, itemNetAmt, itemGstPer, itemGstAmt, itemTotalAmt, transactionId, miniProcess);
                            }

                        }
                         if (process.equals("AddTransaction")) {
                             transactionService.InsertTransaction(transactionId, partyName, productName,rate,quantity,netAmt,gstPer, gstAmt, totalAmt, transport, transactionDate, table);
                        } else {
                            transactionService.updateTransaction(partyName, productName, rate,quantity,netAmt, gstPer,gstAmt, totalAmt, transport, transactionDate,  transactionId, table);
                        }
                    } else {
                        status = 0;
                    }
                    request.setAttribute("status", status);
                    request.setAttribute("process", process);
                    if (miniProcess.equals("sales")) {
                        RequestDispatcher view = request.getRequestDispatcher("Sales.jsp");
                        view.forward(request, response);
                    } else if (miniProcess.equals("purchase")) {
                        RequestDispatcher view = request.getRequestDispatcher("Purchase.jsp");
                        view.forward(request, response);
                    }

                } else if (process.equals("deleteSales")) {
                    String table = "";
                    if (miniProcess.equals("sales")) {
                        table = "saletransactions";
                    } else if (miniProcess.equals("purchase")) {
                        table = "purchasetransactions";
                    }
                    int transactionId = Integer.parseInt(request.getParameter("tranId"));
                    int status = transactionService.deleteTransaction(transactionId, table);

                    transactionService.deleteItemFromTransaction(transactionId, miniProcess);
                    request.setAttribute("process", process);
                    request.setAttribute("status", status);

                    if (miniProcess.equals("sales")) {
                        RequestDispatcher view = request.getRequestDispatcher("Sales.jsp");
                        view.forward(request, response);
                    } else if (miniProcess.equals("purchase")) {
                        RequestDispatcher view = request.getRequestDispatcher("Purchase.jsp");
                        view.forward(request, response);
                    }
                } else if (process.equals("purchase")) {
                    request.setAttribute("process", process);
                    RequestDispatcher view = request.getRequestDispatcher("Purchase.jsp");
                    view.forward(request, response);
                } else if (process.equals("Purchaselast")) {
                    ResultSet rs = transactionService.PurchaseLast();
                    int id = transactionService.getLastPurchaseTransactionId();
                    ResultSet rs1 = transactionService.getItemsForTransaction(id, "purchase");
                    request.setAttribute("result", rs);
                    request.setAttribute("result1", rs1);
                    request.setAttribute("process", process);
                    RequestDispatcher view = request.getRequestDispatcher("Purchase.jsp");
                    view.forward(request, response);
                } else if (process.equals("AllPurchase")) {
                    ResultSet rs = transactionService.getAllPurchases();
                    request.setAttribute("result", rs);

                    request.setAttribute("process", process);
                    RequestDispatcher view = request.getRequestDispatcher("Purchase.jsp");
                    view.forward(request, response);
                }
            } catch (Exception ex) {
                out.print(ex.getMessage());
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
