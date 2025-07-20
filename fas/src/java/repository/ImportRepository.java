/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author NSP
 */
public class ImportRepository {

    String url = "jdbc:mysql://localhost:3306/test";
    String username = "root";
    String password = "nayan";

//importRepository
    public int insertUploadData(String gstNo, String partyname, String partytype, String address, String state, String transport, String broker) throws SQLException {

        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ImportRepository.class.getName()).log(Level.SEVERE, null, ex);
        }

        Connection con = DriverManager.getConnection(url, username, password);

        PreparedStatement stmt = con.prepareStatement("insert into partyMaster values(?,?,?,?,?,?,?);");

        stmt.setString(1, gstNo);
        stmt.setString(2, partyname);
        stmt.setString(3, partytype);
        stmt.setString(4, address);
        stmt.setString(5, state);
        stmt.setString(6, transport);
        stmt.setString(7, broker);

        return stmt.executeUpdate();
    }
}
