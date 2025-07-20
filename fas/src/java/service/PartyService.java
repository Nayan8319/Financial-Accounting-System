/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import java.sql.ResultSet;
import java.sql.SQLException;
import repository.PartyRepository;

/**
 *
 * @author NSP
 */
public class PartyService {
     PartyRepository partyRepository = new PartyRepository();
     public ResultSet getAllVendors() throws SQLException {
        return partyRepository.getAllVendors();
    }
    public ResultSet getAllCustomers() throws SQLException {
        return partyRepository.getAllCustomer();
    }
     public ResultSet getParty(String partyId) throws SQLException {
        return partyRepository.getParty(partyId);
    } 
    public int insertParty(String partyId,String partyName,String partyType,String phoneNo,String address,String city, String state, String transport) throws SQLException{
         return partyRepository.insertParty(partyId,partyName,partyType,phoneNo,address,city,state,transport);
    }
    public int updateParty(String partyName,String phoneNo, String address,String city, String state, String transport, String partyId) throws SQLException {
        return partyRepository.updateParty(partyName, phoneNo,address,city, state, transport,  partyId);
    }

    public int deleteParty(String partyId) throws SQLException{
         return partyRepository.delete(partyId);
    }
}