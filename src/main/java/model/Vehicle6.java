package model;

import java.io.Serializable;

public class Vehicle6 implements Serializable {
    private int id;
    private String licensePlate;
    private String vehicleType;
    private String brand;
    private String model;
    private Customer6 customer;

    public Vehicle6() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getLicensePlate() { return licensePlate; }
    public void setLicensePlate(String licensePlate) { this.licensePlate = licensePlate; }

    public String getVehicleType() { return vehicleType; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }

    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }

    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }

    public Customer6 getCustomer() { return customer; }
    public void setCustomer(Customer6 customer) { this.customer = customer; }
}
