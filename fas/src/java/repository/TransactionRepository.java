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
public class TransactionRepository {

    String url = "jdbc:mysql://localhost:3306/test";
    String username = "root";
    String password = "nayan";

    public ResultSet getAllSales() throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select transactionId,partyName,productName,rate,quantity,netAmt,gstAmt,totalAmt,transport,transactionDate from saleTransactions");
        ResultSet rs = pstmt.executeQuery();
        return rs;
    }

    public ResultSet SaleslastTransaction() throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement stmt = con.prepareStatement("SELECT transactionId,partyName,productName,rate,quantity,netAmt,gstAmt,totalAmt,transport,transactionDate FROM saleTransactions ORDER BY transactionId DESC LIMIT 1;");
        ResultSet rs = stmt.executeQuery();
        return rs;
    }

    public ResultSet getAllPurchase() throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement stmt = con.prepareStatement("select transactionId,partyName,productName,netAmt,gstAmt,totalAmt,transport,transactionDate from purchaseTransactions");
        ResultSet rs = stmt.executeQuery();
        return rs;
    }

    public ResultSet PurchaselastTransaction() throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement stmt = con.prepareStatement("SELECT transactionId,partyName,productName,netAmt,gstAmt,totalAmt,transport,transactionDate FROM purchaseTransactions ORDER BY transactionId DESC LIMIT 1;");
        ResultSet rs = stmt.executeQuery();
        return rs;
    }

    public ResultSet EditViewData(int id, String table) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement stmt = con.prepareStatement("SELECT transactionId,partyName,productName,rate,quantity,netAmt,gstAmt,totalAmt,transport,transactionDate FROM " + table + " where transactionId=?");
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        return rs;
    }

    public int newTransaction(int transactionId, String partyName, String productName,int rate,int quantity, int netAmt, int gstPer,int gstAmt, int totalAmt, String transport, String transactionDate, String table) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement stmt = con.prepareCall("insert into " + table + " \n"
                + "(transactionId,partyName,productName,rate,quantity,netAmt,gstPer,gstAmt,totalAmt,transport,transactionDate)\n"
                + "values (?,?,?,?,?,?,?,?,?,?,?);");
        stmt.setInt(1, transactionId);
        stmt.setString(2, partyName);
        stmt.setString(3, productName);
        stmt.setInt(4, rate);
        stmt.setInt(5, quantity);
        stmt.setInt(6, netAmt);
        stmt.setInt(7, gstPer);
        stmt.setInt(8, gstAmt);
        stmt.setInt(9, totalAmt);
        stmt.setString(10, transport);
        stmt.setString(11, transactionDate);
        int status = stmt.executeUpdate();
        return status;
    }

    public int updatTransaction(String partyName, String productName,int rate,int quantity, int netAmt,int gstPer, int gstAmt, int totalAmt, String transport, String transactionDate, int transactionId, String table) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement stmt = con.prepareCall("update " + table + " set partyName=?, productName=?,rate=?,quantity=?,netAmt=?,gstPer=?,gstAmt=?,totalAmt=?,transport=?,transactionDate=?  where transactionId=? ;");
        stmt.setString(1, partyName);
        stmt.setString(2, productName);
        stmt.setInt(3, rate);
        stmt.setInt(4, quantity);
        stmt.setInt(5, netAmt);
        stmt.setInt(6, gstPer);
        stmt.setInt(7, gstAmt);
        stmt.setInt(8, totalAmt);
        stmt.setString(9, transport);
        stmt.setString(10, transactionDate);
        stmt.setInt(11, transactionId);
        int status = stmt.executeUpdate();
        return status;
    }
    
    public int deleteTransactiondetail(int no, String table) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement stmt = con.prepareCall("delete from  " + table + " where transactionId=? ;");
        stmt.setInt(1, no);
        return stmt.executeUpdate();
    }

    public int getLastSaleTransactionId() throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement stmt = con.prepareStatement("SELECT transactionId FROM saleTransactions ORDER BY transactionId DESC LIMIT 1;");
        int id = 0;
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            id = rs.getInt("transactionId");
        }
        return id;
    }

    public int getLastPurchaseTransactionId() throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement stmt = con.prepareStatement("SELECT transactionId FROM purchaseTransactions ORDER BY transactionId DESC LIMIT 1;");
        int id = 0;
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            id = rs.getInt("transactionId");
        }
        return id;
    }

    public int insertItemToTransaction(int itemId, String itemName, int intemRate, int itemQuantity, int netAmt, int gstPer, int gstAmt, int totalAmt, int transactionId, String transactionType) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement stmt = con.prepareCall("insert into transactionItem \n"
                + "(itemId,itemName,rate,quantity,netAmt,gstPer,gstAmt,totalAmt,transactionId,transactionType)\n"
                + "values (?,?,?,?,?,?,?,?,?,?);");
        stmt.setInt(1, itemId);
        stmt.setString(2, itemName);
        stmt.setInt(3, intemRate);
        stmt.setInt(4, itemQuantity);
        stmt.setInt(5, netAmt);
        stmt.setInt(6, gstPer);
        stmt.setInt(7, gstAmt);
        stmt.setInt(8, totalAmt);
        stmt.setInt(9, transactionId);
        stmt.setString(10, transactionType);
        int status = stmt.executeUpdate();
        return status;
    }

    public int updateItemForTransaction(int itemId, String itemName, int rate, int quantity, int netAmt, int gstPer, int gstAmt, int totalAmt, int transactionId, String transactionType) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement stmt = con.prepareCall("update transactionItem set \n"
                + "itemName=?,rate=?,quantity=?,netAmt=?,gstPer=?,gstAmt=?,totalAmt=?,transactionId=?,transactionType=? \n"
                + "where itemId=?;");
        stmt.setString(1, itemName);
        stmt.setInt(2, rate);
        stmt.setInt(3, quantity);
        stmt.setInt(4, netAmt);
        stmt.setInt(5, gstPer);
        stmt.setInt(6, gstAmt);
        stmt.setInt(7, totalAmt);
        stmt.setInt(8, transactionId);
        stmt.setString(9, transactionType);
        stmt.setInt(10, itemId);
        int status = stmt.executeUpdate();
        return status;
    }

    public int deleteItemFromTransaction(int tranId, String tranType) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement stmt = con.prepareCall("delete from transactionItem where transactionId=? and transactionType=?;");
        stmt.setInt(1, tranId);
        stmt.setString(2, tranType);
        return stmt.executeUpdate();
    }

    public ResultSet getItemsForTransaction(int transactionId, String transactionType) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement stmt = con.prepareStatement("SELECT itemId,itemName,rate,quantity,netAmt,gstPer,gstAmt,totalAmt,transactionId from transactionItem where transactionId=? and transactionType=?");
        stmt.setInt(1, transactionId);
        stmt.setString(2, transactionType);
        ResultSet rs = stmt.executeQuery();
        return rs;
    }
    
    public ResultSet getSale(int id, String table) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement stmt = con.prepareStatement("SELECT transactionId,partyName,productName,rate,quantity,netAmt,gstPer,gstAmt,totalAmt,transport,transactionDate FROM " + table + " where transactionId=?");
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        return rs;
    }
    
}
