/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author NSP
 */
public class PaymentsRepository {

    String url = "jdbc:mysql://localhost:3306/test";
    String username = "root";
    String password = "nayan";

    public ResultSet getAllPayments() throws SQLException {

        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select * from payment;");
        ResultSet rs = pstmt.executeQuery();

        return rs;

    }
    
    public ResultSet getPayment(int paymentId, String table) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement stmt = con.prepareStatement("SELECT * FROM " + table + " where paymentId=?");
        stmt.setInt(1, paymentId);
        ResultSet rs = stmt.executeQuery();
        return rs;
    }

    public int insertPayment(int paymentId, int transactionId, String transactionDate, String partyName,
            String address, String city, String state, String transport, String productName, int rate, int quantity,
            int netAmt, int gstPer, int gstAmt, int totalAmt, String paymentMethod) throws SQLException {
        try {
            Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement pstmt = con.prepareStatement("insert into payment "
                    + "(paymentId, transactionId,transactionDate,partyName, address, city, state,transport,productName,rate,quantity,netAmt,gstPer,gstAmt,totalAmt,paymentMethod)"
                    + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");

            pstmt.setInt(1, paymentId);
            pstmt.setInt(2, transactionId);
            pstmt.setString(3, transactionDate);
            pstmt.setString(4, partyName);
            pstmt.setString(5, address);
            pstmt.setString(6, city);
            pstmt.setString(7, state);
            pstmt.setString(8, transport);
            pstmt.setString(9, productName);
            pstmt.setInt(10, rate);
            pstmt.setInt(11, quantity);
            pstmt.setInt(12, netAmt);
            pstmt.setInt(13, gstPer);
            pstmt.setInt(14, gstAmt);
            pstmt.setInt(15, totalAmt);
            pstmt.setString(16, paymentMethod);
            int status = pstmt.executeUpdate();
            System.out.println("repo");
            return status;

        } finally {

        }
    }

}
