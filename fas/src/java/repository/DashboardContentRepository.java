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
public class DashboardContentRepository {

    String url = "jdbc:mysql://localhost:3306/test";
    String username = "root";
    String password = "nayan";

    public ResultSet countProducts() throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select count(productId) as countProduct from products;");
        ResultSet rs = pstmt.executeQuery();

        return rs;
    }

    public ResultSet countVendors() throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select count(partyName) as countVendors from partyMaster where  partyType='vendor';");
        ResultSet rs = pstmt.executeQuery();

        return rs;
    }

    public ResultSet countCustomers() throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select count(partyName) as countCustomers from partyMaster where  partyType='customer';");
        ResultSet rs = pstmt.executeQuery();

        return rs;
    }

    public ResultSet countSales() throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select count(totalAmt) as countSales from saleTransactions;");
        ResultSet rs = pstmt.executeQuery();

        return rs;
    }
    public ResultSet rsTotalSales() throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select sum(totalAmt) as rsTotalSales from saleTransactions;");
        ResultSet rs = pstmt.executeQuery();

        return rs;
    }
    
    public ResultSet rsLastYearSales() throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("SELECT \n"
                + "    COUNT(CASE WHEN transactionDate >= CURRENT_DATE() - INTERVAL 7 DAY THEN 1 END) AS last_week_count,\n"
                + "    SUM(CASE WHEN transactionDate >= CURRENT_DATE() - INTERVAL 7 DAY THEN totalAmt END) AS last_week_total,\n"
                + "    COUNT(CASE WHEN transactionDate >= CURRENT_DATE() - INTERVAL 30 DAY THEN 1 END) AS last_30_days_count,\n"
                + "    SUM(CASE WHEN transactionDate >= CURRENT_DATE() - INTERVAL 30 DAY THEN totalAmt END) AS last_30_days_total,\n"
                + "    COUNT(CASE WHEN MONTH(transactionDate) = MONTH(CURRENT_DATE()) AND YEAR(transactionDate) = YEAR(CURRENT_DATE()) THEN 1 END) AS last_month_count,\n"
                + "    SUM(CASE WHEN MONTH(transactionDate) = MONTH(CURRENT_DATE()) AND YEAR(transactionDate) = YEAR(CURRENT_DATE())THEN totalAmt END) AS last_month_total,\n"
                + "    COUNT(CASE WHEN YEAR(transactionDate) = YEAR(CURRENT_DATE() - INTERVAL 1 YEAR) THEN 1 END) AS last_year_count,\n"
                + "    SUM(CASE WHEN YEAR(transactionDate) = YEAR(CURRENT_DATE() - INTERVAL 1 YEAR) THEN totalAmt END) AS last_year_total\n"
                + "\n"
                + "FROM \n"
                + "    saletransactions;");
        ResultSet rs = pstmt.executeQuery();

        return rs;
    }

}
