package mx.edu.utez.electronicos.model.device;

import mx.edu.utez.electronicos.model.address.BeanAddress;
import mx.edu.utez.electronicos.service.ConnectionMySQL;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoDevice {
    private Connection con;
    private CallableStatement cstm;
    private ResultSet rs;

    public boolean createDevice(BeanDevice device) {
        boolean flag = false;
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("call createDevice(?,?)");
            cstm.setString(1, device.getName());
            cstm.setInt(2,device.getAddress().getId());
            flag = cstm.execute();
        } catch (SQLException e) {
            System.out.println("DaoDevice - error: "+e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm);
        }
        return flag;
    }

    public boolean deleteDevice(int id) {
        boolean flag = false;
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("call createDevice(?)");
            cstm.setInt(1, id);
        } catch (SQLException e) {
            System.out.println("DaoDevice - error: "+e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm);
        }
        return flag;
    }

    public List<BeanDevice> getAllDevices() {
        List<BeanDevice> devices = new ArrayList<>();
        BeanAddress address;
        BeanDevice device;
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("call getAllDevices()");
            rs = cstm.executeQuery();
            while (rs.next()) {
                address = new BeanAddress(
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getInt(9),
                        rs.getString(10),
                        rs.getString(11)
                );
                device = new BeanDevice(
                        rs.getInt(1),
                        rs.getString(1),
                        address,
                        rs.getString(4),
                        rs.getByte(5)
                );
                devices.add(device);
            }
        } catch (SQLException e) {
            System.out.println("DaoDevice - error: "+e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm, rs);
        }
        return devices;
    }

    public BeanDevice getDeviceById(int id) {
        BeanDevice device = null;
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("call getDeviceById(?)");
            rs = cstm.executeQuery();
            if (rs.next()) {
                BeanAddress address = new BeanAddress(
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getInt(9),
                        rs.getString(10),
                        rs.getString(11)
                );
                device = new BeanDevice(
                        rs.getInt(1),
                        rs.getString(1),
                        address,
                        rs.getString(4),
                        rs.getByte(5)
                );
            }
        } catch (SQLException e) {
            System.out.println("DaoDevice - error: "+e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm, rs);
        }
        return device;
    }

    public boolean updateDevice(BeanDevice device) {
        boolean flag = false;
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("call createDevice(?,?,?)");
            cstm.setInt(1, device.getId());
            cstm.setString(2, device.getName());
            cstm.setInt(3,device.getAddress().getId());
            flag = cstm.execute();
        } catch (SQLException e) {
            System.out.println("DaoDevice - error: "+e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm);
        }
        return flag;
    }
}
