/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import java.sql.ResultSet;
import java.sql.SQLException;
import repository.UserRepository;

/**
 *
 * @author NSP
 */
public class UserService {
    
    UserRepository userRepository = new UserRepository();
    
    public int insertUser(String user, String pass, String email, String gender,String phoneNo,String address, String city,String state, String salary,String joiningDate,
            String permissions, String salesSub, String purchaseSub,String productSub, String vendorsSub, String customersSub) throws SQLException{
        return userRepository.insertUser(user, pass, email, gender, phoneNo,address,city,state,salary,joiningDate, permissions, salesSub, purchaseSub, productSub, vendorsSub, customersSub);
    }
    
    public ResultSet getAllUser() throws SQLException {
        return userRepository.getAllUser();
    }
    public ResultSet getUser(int id) throws SQLException {
        return userRepository.getUser(id);
    }

    public int updateUser(int userId, String user, String email, String gender, String phoneNo,String address,String city,String state,String salary,String joiningDate,
            String permissions,String salesSub, String purchaseSub,
            String productSub, String vendorsSub, String customersSub) throws SQLException{
        return userRepository.updateUser(userId, user, email, gender, phoneNo,address, city,state,salary,joiningDate, permissions, salesSub, purchaseSub, productSub, vendorsSub, customersSub);
    }
    public int deleteUser(int userId) throws SQLException {
        return userRepository.deleteUser(userId);
    }
}
