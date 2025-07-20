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
public class LoginRepository {
    
    String url = "jdbc:mysql://localhost:3306/test";
    String username = "root";
    String password = "nayan";

 

    public int adminLogin(String user, String pass) throws SQLException {

        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select count(username) from AdminLogin where username=? and password=?");
        pstmt.setString(1, user);
        pstmt.setString(2, pass);
        ResultSet rs = pstmt.executeQuery();
        int status = 0;
        if (rs.next()) {
            status = rs.getInt(1);
        }
        
        return status;
       
    }

    public int userLogin(String user, String pass) throws SQLException {

        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select count(username) from UserLogin where username=? and password=?");
        pstmt.setString(1, user);
        pstmt.setString(2, pass);
        ResultSet rs = pstmt.executeQuery();
        int status = 0;
        if (rs.next()) {
            status = rs.getInt(1);
        }
                  

        return status;
    }

    public ResultSet getUserPermission(String user, String pass) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select * from UserLogin where username=? and  password=?");

        pstmt.setString(1, user);
        pstmt.setString(2, pass);
        ResultSet rs = pstmt.executeQuery();
                  
        return rs;
    }

    public ResultSet userProfile(String username, String password) throws SQLException{
    Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select * from UserLogin where username=? and  password=?");

        pstmt.setString(1, "username");
        pstmt.setString(2, "gender");
        pstmt.setString(3, "email");
        pstmt.setString(4, "phoneNo");
        pstmt.setString(5, "address");
        pstmt.setString(6, "city");
        pstmt.setString(7, "state");
        pstmt.setString(8, "salary");
        pstmt.setString(9, "joinDate");
        ResultSet rs = pstmt.executeQuery();
                  
        return rs;
    }

}