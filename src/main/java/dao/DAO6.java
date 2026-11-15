package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO6 {
    public static Connection con;

    public DAO6() {
        if (con == null) {
            String dbUrl = "jdbc:mysql://localhost:3306/garage_db6?useSSL=false&allowPublicKeyRetrieval=true"
                    + "&useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Ho_Chi_Minh";
            String dbClass = "com.mysql.cj.jdbc.Driver";
            try {
                Class.forName(dbClass);
                con = DriverManager.getConnection(dbUrl, "root", "root"); // Chỉnh lại password MySQL của máy bạn
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}