package model;

import java.io.Serializable;

public class SparePart6 implements Serializable {
    private int id;
    private String partCode;
    private String name;
    private String description;
    private float price;
    private int stock;
    private String supportedVehicleType;
    private int warrantyPeriod;

    public SparePart6() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPartCode() {
        return partCode;
    }

    public void setPartCode(String partCode) {
        this.partCode = partCode;
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

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
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