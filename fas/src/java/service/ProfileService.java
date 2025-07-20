/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import java.sql.ResultSet;
import java.sql.SQLException;
import repository.ProfileRepository;

/**
 *
 * @author NSP
 */
public class ProfileService {
    ProfileRepository profileRepository = new ProfileRepository();
    
    public ResultSet profile() throws SQLException {
        return profileRepository.Profile();
    }
}
