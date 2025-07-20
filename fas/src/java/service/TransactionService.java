/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import java.sql.ResultSet;
import java.sql.SQLException;
import repository.TransactionRepository;

/**
 *
 * @author NSP
 */
public class TransactionService {

    TransactionRepository transactionRepository = new TransactionRepository();

    public ResultSet getAllPurchases() throws SQLException {
        return transactionRepository.getAllPurchase();
    }

    public ResultSet getAllSales() throws SQLException {
        return transactionRepository.getAllSales();
    }

    public ResultSet SalesLast() throws SQLException {
        return transactionRepository.SaleslastTransaction();
    }

    public ResultSet PurchaseLast() throws SQLException {
        return transactionRepository.PurchaselastTransaction();
    }

    public ResultSet EditViewData(int id, String table) throws SQLException {
        return transactionRepository.EditViewData(id, table);
    }

    public int InsertTransaction(int transactionId, String partyName, String productName, int rate, int quantity,int netAmt, int gstPer,int gstAmt, int totalAmt, String transport, String transactionDate, String table) throws SQLException {
        return transactionRepository.newTransaction(transactionId, partyName, productName, rate, quantity, netAmt,gstPer, gstAmt, totalAmt, transport, transactionDate, table);
    }

    public int updateTransaction(String partyName, String productName, int rate, int quantity,int netAmt,int gstPer,  int gstAmt, int totalAmt, String transport, String transactionDate, int transactionId, String table) throws SQLException {
        return transactionRepository.updatTransaction(partyName, productName, rate, quantity, netAmt,gstPer, gstAmt, totalAmt, transport, transactionDate, transactionId, table);
    }

    public int deleteTransaction(int no, String table) throws SQLException {
        return transactionRepository.deleteTransactiondetail(no, table);

    }

    public int insertItemToTransaction(int itemId, String itemName, int intemRate, int itemQuantity, int netAmt, int gstPer, int gstAmt, int totalAmt, int transactionId, String transactionType) throws SQLException {
        return transactionRepository.insertItemToTransaction(itemId, itemName, intemRate, itemQuantity, netAmt, gstPer, gstAmt, totalAmt, transactionId, transactionType);
    }

    public int updateItemForTransaction(int itemId, String itemName, int rate, int quantity, int netAmt, int gstPer, int gstAmt, int totalAmt, int transactionId, String transactionType) throws SQLException {
        return transactionRepository.updateItemForTransaction(itemId, itemName, rate, quantity, netAmt, gstPer, gstAmt, totalAmt, transactionId, transactionType);
    }

    public int deleteItemFromTransaction(int tranId, String tranType) throws SQLException {
        return transactionRepository.deleteItemFromTransaction(tranId, tranType);
    }

    public ResultSet getItemsForTransaction(int transactionId, String TransactionType) throws SQLException {
        return transactionRepository.getItemsForTransaction(transactionId, TransactionType);
    }

    public int getLastSaleTransactionId() throws SQLException {
        return transactionRepository.getLastSaleTransactionId();
    }

    public int getLastPurchaseTransactionId() throws SQLException {
        return transactionRepository.getLastPurchaseTransactionId();
    }

    public ResultSet getSale(int id, String table) throws SQLException {
        return transactionRepository.getSale(id, table);
    }
}
