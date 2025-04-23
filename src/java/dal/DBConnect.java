package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {

    protected Connection c;

    public DBConnect() {
        try {
            String url = "jdbc:sqlserver://localhost:1433;databaseName=Fruit12;encrypt=true;trustServerCertificate=true;characterEncoding=UTF-8;sendStringParametersAsUnicode=true";
            String username = "sa";
            String pass = "123";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            c = DriverManager.getConnection(url, username, pass);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void closeConnection() {
        try {
            if (c != null && !c.isClosed()) {
                c.close();
                System.out.println("Connection closed successfully.");
            }
        } catch (SQLException e) {
            System.out.println("Error closing connection: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
    DBConnect db = new DBConnect();
    try {
        if (db.c != null && !db.c.isClosed()) {
            System.out.println("Connection established successfully.");

            // Test case: Execute a simple query
            var stmt = db.c.createStatement();
            var rs = stmt.executeQuery("SELECT * from Products");

            while (rs.next()) {
                System.out.println("Current date from DB: " + rs.getString("CurrentDate"));
            }

            rs.close();
            stmt.close();
        } else {
            System.out.println("Failed to establish connection.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        db.closeConnection();
    }
}
}
