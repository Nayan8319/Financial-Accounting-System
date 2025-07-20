/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import java.sql.ResultSet;
import java.sql.SQLException;
import repository.LoginRepository;

/**
 *
 * @author NSP
 */
public class LoginService {
    
    LoginRepository loginRepository = new LoginRepository();
    
    
    public int adminLogin(String user, String pass) throws SQLException {
        return loginRepository.adminLogin(user, pass);
    }
    
    public int userLogin(String user, String pass) throws SQLException {
        return loginRepository.userLogin(user, pass);
    }
    
    public ResultSet userPermission(String user, String pass) throws SQLException {
        return loginRepository.getUserPermission(user, pass);
    }
    
    
    public ResultSet userProfile(String username, String password) throws SQLException {
        return loginRepository.userProfile(username, password);
    }
}
    
