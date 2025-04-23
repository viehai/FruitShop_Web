/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Categories;


/**
 *
 * @author pc
 */
public class CategoriesDao extends DBConnect{
     public List<Categories> getAllCategories() {
        List<Categories> list = new ArrayList();
        String query = "SELECT * FROM Categories";
        try {
            
            PreparedStatement stmt = c.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Categories u = new Categories(rs.getInt(1), rs.getString(2));
                list.add(u);}
            }catch (SQLException e) { 
                
        }
            return list;
        }
    
    public static void main(String[] args) {
        CategoriesDao d = new CategoriesDao();
        List<Categories> list = d.getAllCategories();
        for (Categories categories : list) {
            System.out.println(categories);
        }
    }
    
}
