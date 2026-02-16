package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {

        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3307/course_registration?useSSL=false&serverTimezone=UTC",
                "root",
                ""
            );

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}
