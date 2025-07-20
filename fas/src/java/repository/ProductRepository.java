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
public class ProductRepository {
    String url = "jdbc:mysql://localhost:3306/test";
    String username = "root";
    String password = "nayan";

    public ResultSet getAllProducts() throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select productId,productName,price,quantity from products");
        ResultSet rs = pstmt.executeQuery();

        return rs;
    }

    public ResultSet getProduct(int productId) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select productId,productName,price,quantity from products where  productId=?");
        pstmt.setInt(1, productId);
        ResultSet rs = pstmt.executeQuery();

        return rs;
    }

    public int productUpdate(String productName, int price, int quantity, int productId) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("update products set productName=?,price=?,quantity=? where productId=?;");
        pstmt.setString(1, productName);
        pstmt.setInt(2, price);
        pstmt.setInt(3, quantity);
        pstmt.setInt(4, productId);
        int status = pstmt.executeUpdate();

        return status;
    }

    public int delprod(int productId) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("delete from products where productId=?;");
        pstmt.setInt(1, productId);
        int status = 0;
        status = pstmt.executeUpdate();
        System.out.println("rep : " + status);

        return status;
    }

    public int insertProduct(int productId, String productName, int price, int quantity) throws SQLException {
        try {
            Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement pstmt = con.prepareStatement("insert into products values(?,?,?,?);");

            pstmt.setInt(1, productId);
            pstmt.setString(2, productName);
            pstmt.setInt(3, price);
            pstmt.setInt(4, quantity);

            int status = pstmt.executeUpdate();

            return status;

        } finally {
//             
        }
    } 
}

