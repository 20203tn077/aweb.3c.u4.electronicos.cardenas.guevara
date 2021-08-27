package mx.edu.utez.electronicos.model.address;

public class BeanAddress {
    private int id;
    private String street;
    private String town;
    private int zipCode;
    private String state;
    private String country;

    public BeanAddress() {
    }

    public BeanAddress(int id, String street, String town, int zipCode, String state, String country) {
        this.id = id;
        this.street = street;
        this.town = town;
        this.zipCode = zipCode;
        this.state = state;
        this.country = country;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getTown() {
        return town;
    }

    public void setTown(String town) {
        this.town = town;
    }

    public int getZipCode() {
        return zipCode;
    }

    public void setZipCode(int zipCode) {
        this.zipCode = zipCode;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
}
