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
public class UserRepository {

    String url = "jdbc:mysql://localhost:3306/test";
    String username = "root";
    String password = "nayan";

    public int insertUser(String user, String pass, String email, String gender,String phoneNo,String address, String city,String state, String salary,String joiningDate,
            String permissions, String salesSub, String purchaseSub,
            String productSub, String vendorsSub, String customersSub) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("insert into UserLogin "
                + "(username,password,email,gender,phoneNo,address,city,state,salary,joiningDate,permissions,"
                + "salesPermission,purchasePermission,productsPermission,vendorsPermission,customersPermission) "
                + "values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

        pstmt.setString(1, user);
        pstmt.setString(2, pass);
        pstmt.setString(3, email);
        pstmt.setString(4, gender);
        pstmt.setString(5, phoneNo);
        pstmt.setString(6, address);
        pstmt.setString(7, city);
        pstmt.setString(8, state);
        pstmt.setString(9, salary);
        pstmt.setString(10, joiningDate);
        pstmt.setString(11, permissions);
        pstmt.setString(12, salesSub);
        pstmt.setString(13, purchaseSub);
        pstmt.setString(14, productSub);
        pstmt.setString(15, vendorsSub);
        pstmt.setString(16, customersSub);
        int status = pstmt.executeUpdate();

        return status;
    }

    public int updateUser(int userId,String user, String email, String gender,String phoneNo,String address, String city,String state,String salary,String joiningDate,
            String permissions, String salesSub, String purchaseSub,
            String productSub, String vendorsSub, String customersSub) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("update UserLogin set username=?,"
                + "email=?,gender=?,phoneNo=?,address=?,city=?,state=?,salary=?,joiningDate=?,"
                + "permissions=?,salesPermission=?,purchasePermission=?,productsPermission=?,vendorsPermission=?,"
                + "customersPermission=? where userId=?");
        pstmt.setString(1, user);
        pstmt.setString(2, email);
        pstmt.setString(3, gender);
        pstmt.setString(4, phoneNo);
        pstmt.setString(5, address);
        pstmt.setString(6, city);
        pstmt.setString(7, state);
        pstmt.setString(8, salary);
        pstmt.setString(9, joiningDate);
        pstmt.setString(10, permissions);
        pstmt.setString(11, salesSub);
        pstmt.setString(12, purchaseSub);
        pstmt.setString(13, productSub);
        pstmt.setString(14, vendorsSub);
        pstmt.setString(15, customersSub);
        pstmt.setInt(16, userId);
        int status = pstmt.executeUpdate();

        return status;
    }

    public ResultSet getAllUser() throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select userId,username,password,email,gender,phoneNo,address,city,state,salary,joiningDate,permissions from UserLogin");
        ResultSet rs = pstmt.executeQuery();

        return rs;
    }

    public ResultSet getUser(int id) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement(""
                + "select userId,username,email,gender,phoneNo,address,city,state,salary,joiningDate,permissions,"
                + "salesPermission,purchasePermission,productsPermission,"
                + "vendorsPermission,customersPermission from"
                + " UserLogin where userId=?");
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();

        return rs;
    }

    public int deleteUser(int userId) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("delete from UserLogin where userId=?;");
        pstmt.setInt(1, userId);
        int status = 0;
        status = pstmt.executeUpdate();

        return status;
    }

}
