package mx.edu.utez.electronicos.model.address;

import mx.edu.utez.electronicos.service.ConnectionMySQL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DaoAddress {
    private Connection con;
    private CallableStatement cstm;
    private ResultSet rs;

    public int createAddress(BeanAddress address) {
        int id = 0;
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("call createAddress(?,?,?,?,?,?)");
            cstm.setString(1, address.getStreet());
            cstm.setString(2, address.getTown());
            cstm.setInt(3, address.getZipCode());
            cstm.setString(4, address.getState());
            cstm.setString(5, address.getCountry());
            cstm.registerOutParameter(6, Types.INTEGER);
            cstm.execute();
            id = cstm.getInt(6);
        } catch (SQLException e) {
            System.out.println("DaoAddress - error: "+e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm);
        }
        System.out.println(id);
        return id;
    }

    public List<BeanAddress> getAllAdresses() {
        List<BeanAddress> addresses = new ArrayList<>();
        BeanAddress address;
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("call getAllAddresses()");
            rs = cstm.executeQuery();
            while (rs.next()) {
                address = new BeanAddress(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6)
                );
                addresses.add(address);
            }
        } catch (SQLException e) {
            System.out.println("DaoAddress - error: "+e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm, rs);
        }
        return addresses;
    }
}
