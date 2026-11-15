package model;

import java.io.Serializable;

public class Service6 implements Serializable {
    private int id;
    private String serviceCode;
    private String name;
    private String description;
    private float price;
    private String status;
    private String supportedVehicleType;
    private int warrantyPeriod;

    public Service6() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getServiceCode() {
        return serviceCode;
    }

    public void setServiceCode(String serviceCode) {
        this.serviceCode = serviceCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSupportedVehicleType() {
        return supportedVehicleType;
    }

    public void setSupportedVehicleType(String supportedVehicleType) {
        this.supportedVehicleType = supportedVehicleType;
    }

    public int getWarrantyPeriod() {
        return warrantyPeriod;
    }

    public void setWarrantyPeriod(int warrantyPeriod) {
        this.warrantyPeriod = warrantyPeriod;
    }
}