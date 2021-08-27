package mx.edu.utez.electronicos.model.device;

import mx.edu.utez.electronicos.model.address.BeanAddress;

public class BeanDevice {
    private int id;
    private String name;
    private BeanAddress address;
    private String registerDate;
    private byte status;

    public BeanDevice() {
    }

    public BeanDevice(int id, String name, BeanAddress address, String registerDate, byte status) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.registerDate = registerDate;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BeanAddress getAddress() {
        return address;
    }

    public void setAddress(BeanAddress address) {
        this.address = address;
    }

    public String getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(String registerDate) {
        this.registerDate = registerDate;
    }

    public byte getStatus() {
        return status;
    }

    public void setStatus(byte status) {
        this.status = status;
    }
}
