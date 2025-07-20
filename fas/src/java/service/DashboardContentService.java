/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import java.sql.ResultSet;
import java.sql.SQLException;
import repository.DashboardContentRepository;

/**
 *
 * @author NSP
 */
public class DashboardContentService {
     DashboardContentRepository deshContentRepository = new DashboardContentRepository();

    public ResultSet countProducts() throws SQLException {
        return deshContentRepository.countProducts();
    }
    public ResultSet countVendors() throws SQLException {
        return deshContentRepository.countVendors();
    }

    public ResultSet countCustomers() throws SQLException {
        return deshContentRepository.countCustomers();
    }
    
    public ResultSet countSales() throws SQLException {
        return deshContentRepository.countSales();
    }
    
    public ResultSet rsTotalSales() throws SQLException {
        return deshContentRepository.rsTotalSales();
    }
    
    public ResultSet rsLastYearSales() throws SQLException {
        return deshContentRepository.rsLastYearSales();
    }
}
