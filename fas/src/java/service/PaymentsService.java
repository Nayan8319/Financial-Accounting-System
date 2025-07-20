/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import java.sql.ResultSet;
import java.sql.SQLException;
import repository.PaymentsRepository;
/**
 *
 * @author NSP
 */
public class PaymentsService {
    
    PaymentsRepository paymentsRepository = new PaymentsRepository();
 
      public int insertPayment(int paymentId, int transactionId, String transactionDate, String partyName,
            String address, String city, String state, String transport,String productName, int rate, int quantity,
            int netAmt, int gstPer, int gstAmt, int totalAmt, String paymentMethod) throws SQLException {
        return paymentsRepository.insertPayment(paymentId, transactionId, transactionDate, partyName, address,
                city, state,transport, productName, rate, quantity, netAmt, gstPer, gstAmt, totalAmt, paymentMethod);
    }
      
      
    public ResultSet getAllPayments() throws SQLException {
        return paymentsRepository.getAllPayments();
    }

    public ResultSet getPayment(int paymentId,String table) throws SQLException {
        return paymentsRepository.getPayment(paymentId,table);
    }

    
}
