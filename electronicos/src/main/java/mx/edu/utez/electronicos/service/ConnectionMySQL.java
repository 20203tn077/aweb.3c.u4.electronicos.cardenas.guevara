package mx.edu.utez.electronicos.service;

import java.sql.*;

public class ConnectionMySQL {

    public static Connection getConnection() throws SQLException {
        String host = "127.0.0.1";
        String port = "3306";
        String database = "electronicos";
        String useSSL = "false";
        String timezone = "UTC-5";
        String url = String.format("jdbc:mysql://%s:%s/%s?allowPublicKeyRetrieval=true&useSSL=%s&serverTimezone=%s", host, port, database, useSSL, timezone);
        DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
        return DriverManager.getConnection(url, "root", "C1i2$3co");
    }

    public static void closeConnection(Connection con, CallableStatement cstm, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }

            if (cstm != null) {
                cstm.close();
            }

            if (con != null) {
                con.close();
            }

        } catch (SQLException e) {
        }
    }

    public static void closeConnection(Connection con, CallableStatement cstm) {
        try {
            if (cstm != null) {
                cstm.close();
            }

            if (con != null) {
                con.close();
            }

        } catch (SQLException e) {
        }
    }

}
