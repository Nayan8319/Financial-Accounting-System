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
public class PartyRepository {

    String url = "jdbc:mysql://localhost:3306/test";
    String username = "root";
    String password = "nayan";

    public ResultSet getAllVendors() throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select partyId,partyName,phoneNo,address,state,transport from partyMaster where partyType='vendor'");
        ResultSet rs = pstmt.executeQuery();

        return rs;
    }

    public ResultSet getAllCustomer() throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select partyId,partyName,phoneNo,address,city,state,transport from partyMaster where partyType='customer';");
        ResultSet rs = pstmt.executeQuery();

        return rs;
    }

    public ResultSet getParty(String partyId) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
        PreparedStatement pstmt = con.prepareStatement("select partyId,partyName,phoneNo,address,city,state,transport from partyMaster where partyId=?");
        pstmt.setString(1, partyId);
        ResultSet rs = pstmt.executeQuery();

        return rs;
    }

    public int insertParty(String partyId, String partyName, String partyType,String phoneNo, String address, String city, String state, String transport) throws SQLException {
        try {
            Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement pstmt = con.prepareStatement("insert into partyMaster(partyId,partyName,partyType,phoneNo,address,city,state,transport) values(?,?,?,?,?,?,?,?);");

            pstmt.setString(1, partyId);
            pstmt.setString(2, partyName);
            pstmt.setString(3, partyType);
            pstmt.setString(4, phoneNo);
            pstmt.setString(5, address);
            pstmt.setString(6, city);
            pstmt.setString(7, state);
            pstmt.setString(8, transport);

            int status = pstmt.executeUpdate();

            return status;

        } finally {
//             
        }
    }

    public int updateParty(String partyName,String phoneNo, String address, String city, String state, String transport,  String partyId) throws SQLException {
        Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement pstmt = con.prepareStatement("update partyMaster set partyName=?,phoneNo=?,address=?,city=?,state=?,transport=? where partyId=?;");

        pstmt.setString(1, partyName);
        pstmt.setString(2, phoneNo);
        pstmt.setString(3, address);
        pstmt.setString(4, city);
        pstmt.setString(5, state);
        pstmt.setString(6, transport);
        pstmt.setString(7, partyId);

        int status = pstmt.executeUpdate();

        return status;
    }

    public int delete(String partyId) throws SQLException {
        int status = 0;
        try {
            Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement stmt = con.prepareStatement("delete from partyMaster where partyId=?;");
            stmt.setString(1, partyId);
            status = stmt.executeUpdate();

            return status;
        } finally {
//              
        }
    }

}
