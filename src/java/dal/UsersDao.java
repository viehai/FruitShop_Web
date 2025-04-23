/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.*;
import model.*;

public class UsersDao extends DBConnect {

    // Method : Đọc dữ liệu có trong bảng Users từ database lên Java
    public List<Users> readUsers() {
        // Tạo 1 list kết quả của Java -> đọc đc thằng nào từ db, thì thêm thằng đó vào List Java
        List<Users> res = new ArrayList();
        // Hành trình đọc dữ liệu từ Database
        String query = "Select *  from Users";
        try {
            PreparedStatement stmt = c.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Users u = new Users(rs.getInt(1), rs.getString(2), rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7), rs.getInt(8));
                res.add(u);
            }
        } catch (Exception e) {
        }
        
        return res;
    }

    public void addUsers(Users u) {
        String query = "INSERT INTO [dbo].[Users] ([username],[password],[name],[email],[phone],[address],[role]) " +
                      "VALUES (?,?,?,?,?,?,?)";
        try {
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1, u.getUsername());
            stmt.setString(2, u.getPassword());
            stmt.setString(3, u.getName());
            stmt.setString(4, u.getEmail());
            stmt.setString(5, u.getPhone());
            stmt.setString(6, u.getAddress());
            stmt.setInt(7, u.getRole());
            stmt.executeUpdate();
        } catch(Exception e) {
            System.out.println("Error in addUsers: " + e.getMessage());
        }
    }
    
    public Users login(String username, String password) {
        String query = "select * from Users where username = ? and password = ?";
        try {
            if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
                return null;
            }
            
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1, username.trim());
            stmt.setString(2, password.trim());
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return new Users(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("address"),
                    rs.getInt("role")
                );
            }
        } catch (Exception e) {
            System.out.println("Error in login method: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean getUser(String username){
        String query = "select * from Users where username = ?";
        
        try {
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if(rs.next() == true){
                return true;
            }
        } catch (Exception e) {
        }
        return false; 
    }
    
//    public boolean checkIdExist(int id){
//        List<Users> check = readUsers();
//        for (Users users : check) {
//            if(users.getId() == id){
//                return true;
//            }
//        }
//        return false;
//    }
    
//    public void deleteUsers(int id){
//        if(getUser(id)  == null){
//            return;
//        }
//        String query = "DELETE FROM [dbo].[users] WHERE Id = ?";
//        try{
//            PreparedStatement stmt = c.prepareStatement(query);
//            stmt.setInt(1,id);
//            stmt.executeUpdate();
//        }catch(Exception e){  
//        }  
//    }
    // Update

    public boolean updateUser(Users u) {
        String query = "UPDATE [dbo].[Users] SET "
                + "[password] = ?, "
                + "[name] = ?, "
                + "[email] = ?, "
                + "[phone] = ?, "
                + "[address] = ?, "
                + "[role] = ? "
                + "WHERE [username] = ?";
        try {
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1, u.getPassword());
            stmt.setString(2, u.getName());
            stmt.setString(3, u.getEmail());
            stmt.setString(4, u.getPhone());
            stmt.setString(5, u.getAddress());
            stmt.setInt(6, u.getRole());
            stmt.setString(7, u.getUsername());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch(Exception e) {
            System.out.println("Error in updateUser: " + e.getMessage());
            return false;
        }
    }
    
    public Users getUserById(int userId) {
        String query = "SELECT * FROM Users WHERE id = ?";
        try {
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Users(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getInt("role")
                );
            }
        } catch (Exception e) {
            System.out.println("Error in getUserById: " + e.getMessage());
        }
        return null;
    }
    
    public boolean deleteUser(int id) {
        String query = "DELETE FROM [dbo].[Users] WHERE Id = ?";
        try {
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch(Exception e) {
            System.out.println("Error in deleteUser: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updateUserPassword(Users u) {
        String query = "UPDATE [dbo].[Users] SET [password] = ? WHERE [id] = ?";
        try {
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1, u.getPassword());
            stmt.setInt(2, u.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch(Exception e) {
            System.out.println("Error in updateUserPassword: " + e.getMessage());
            return false;
        }
    }

    public Users getUserByEmail(String email) {
        String query = "SELECT * FROM Users WHERE email = ?";
        try {
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1, email);
            System.out.println("Executing query for email: " + email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                String username = rs.getString("username");
                String retrievedEmail = rs.getString("email");
                System.out.println("Found user data:");
                System.out.println("- Name: " + name);
                System.out.println("- Username: " + username);
                System.out.println("- Email: " + retrievedEmail);
                return new Users(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    name,
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("address"),
                    rs.getInt("role")
                );
            } else {
                System.out.println("No user found with email: " + email);
            }
        } catch (Exception e) {
            System.out.println("Error in getUserByEmail: " + e.getMessage());
        }
        return null;
    }
}
