///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package controller;
//
//import com.mysql.cj.result.Row;
//import java.io.IOException;
//import java.io.InputStream;
//import java.io.PrintWriter;
//import java.util.ArrayList;
//import java.util.List;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.MultipartConfig;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.Part;
//import oracle.jdbc.driver.parser.Cell;
//import org.apache.poi.ss.usermodel;
//import org.apache.poi.ss.usermodel.Sheet;
//import org.apache.poi.ss.usermodel.Workbook;
//import org.apache.poi.xssf.usermodel.XSSFWorkbook;
//import service.ImportService;
//
///**
// *
// * @author NSP
// */
//
//
//@MultipartConfig(
//       fileSizeThreshold = 0,
//       maxFileSize = 1024 * 1024,
//       maxRequestSize = 1024 * 1024 * 50)
//
//
//public class ImportFile extends HttpServlet {
//
//    ImportService importsService = new ImportService();
//
//    
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
//       try {
//           /* TODO output your page here. You may use following sample code. */
//           Part filePart = request.getPart("file");
//           InputStream inputstream = filePart.getInputStream();
//           //Create Workbook instance holding reference to .xlsx file
//           Workbook workbook = new XSSFWorkbook(inputstream);
//
//           //Get first/desired sheet from the workbook
//           Sheet sheet = workbook.getSheetAt(0);
//           int status = 0;
//           boolean first = true;
//
//           for (Row row : sheet) {
//
//               List li = new ArrayList();
//
//               if (first) {
//                   first = false;
//                   continue;
//               }
//               for (Cell cell : row) {
//
//                   li.add(cell.getStringCellValue());
//                    out.print(cell.getStringCellValue());
//               }
//
//               String gstNo = li.get(0).toString();
//
//               String partyname = li.get(1).toString();
//
//               String partytype = li.get(2).toString();
//
//               String address = li.get(3).toString();
//
//               String state = li.get(4).toString();
//
//               String transport = li.get(5).toString();
//
//               String broker = li.get(6).toString();
//
//               status = importsService.UploadDetails(gstNo, partyname, partytype, address, state, transport, broker);
//           }
//           out.println("Docoment uploaded...");
//       } catch (Exception e) {
//           out.println("Somthing went wrong!.." + e);
//       }
//   }
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
