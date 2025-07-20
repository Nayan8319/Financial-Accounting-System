/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package repository;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author NSP
 */
public class ProfileRepository {

    String url = "jdbc:mysql://localhost:3306/test";
    String username = "root";
    String password = "nayan";


    public ResultSet Profile()throws SQLException {

        java.sql.Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement stmt = con.prepareStatement("select * from UserLogin where user;");
        ResultSet rs = stmt.executeQuery();

        return rs;
    }
}
