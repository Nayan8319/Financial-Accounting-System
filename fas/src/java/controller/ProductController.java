/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.ProductService;

/**
 *
 * @author NSP
 */
public class ProductController extends HttpServlet {

    ProductService productService = new ProductService();

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
            if (process.equals("products")) {
                ResultSet rs = productService.getAllProducts();
                request.setAttribute("result", rs);
            } else if (process.equals("editProduct")) {
                int id = Integer.parseInt(request.getParameter("productId"));
                ResultSet rs = productService.getProduct(id);
                request.setAttribute("result", rs);
            } else if (process.equals("insertProduct")) {

                int productId = Integer.parseInt(request.getParameter("productId"));
                String productName = request.getParameter("productName");
                int price = Integer.parseInt(request.getParameter("price"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                ResultSet rs = productService.getProduct(productId);

                request.setAttribute("result", rs);

                int status = productService.insertProduct(productId, productName, price, quantity);
                System.out.println(status);
                if (status > 0) {
                    out.print(1);
                } else {
                    out.print(0);
                }
            } else if (process.equals("productUpdate")) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                String productName = request.getParameter("productName");
                int price = Integer.parseInt(request.getParameter("price"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                int status = productService.productUpdate(productName, price, quantity, productId);
                out.print(status);
                System.out.println(status);

            } else if (process.equals("delprod")) {
                request.setAttribute("process", process);
                int productId = Integer.parseInt(request.getParameter("productId"));
                int result = productService.delprod(productId);
                System.out.println(result);
                if (result > 0) {
                    out.print("1");
                } else {
                    out.print("0");
                }
            }

            if (!(process.equals("productUpdate")) && !(process.equals("delprod"))) {
                request.setAttribute("process", process);
                RequestDispatcher rd = request.getRequestDispatcher("Product.jsp");
                rd.forward(request, response);
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
