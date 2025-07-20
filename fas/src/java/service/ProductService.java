/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import java.sql.ResultSet;
import java.sql.SQLException;
import repository.ProductRepository;

/**
 *
 * @author NSP
 */
public class ProductService {
     ProductRepository prductRepository = new ProductRepository();

       public ResultSet getAllProducts() throws SQLException {
        return prductRepository.getAllProducts();
    }

    public ResultSet getProduct(int ProductId) throws SQLException {
        return prductRepository.getProduct(ProductId);
    }
    
     public int insertProduct(int productId,String productName,int price,int quantity) throws SQLException{
         return prductRepository.insertProduct(productId,productName,price,quantity);
    }

    public int productUpdate(String productName, int price, int quantity, int productId) throws SQLException {
        return prductRepository.productUpdate(productName, price, quantity, productId);
    }

    public int delprod(int productId) throws SQLException {
        return prductRepository.delprod(productId);
    }
}