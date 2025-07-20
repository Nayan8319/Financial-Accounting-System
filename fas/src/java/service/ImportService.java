/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import java.sql.SQLException;
import repository.ImportRepository;

/**
 *
 * @author NSP
 */
public class ImportService {
  
    ImportRepository importRepository = new ImportRepository();

    public int UploadDetails(String gstNo, String partyname,String partytype, String address, String state, String transport, String broker) throws SQLException {
        return importRepository.insertUploadData(gstNo, partyname, partytype, address, state, transport, broker);
    }   
}
