// File: model/ServiceDetail6.java
package model;

import java.io.Serializable;

public class ServiceDetail6 implements Serializable {
    private int id;
    private int quantity;
    private float unitPrice;
    private float subTotal;
    private Service6 service;
    private TechnicalStaff6 technicalStaff;

    public ServiceDetail6() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public float getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(float subTotal) {
        this.subTotal = subTotal;
    }

    public Service6 getService() {
        return service;
    }

    public void setService(Service6 service) {
        this.service = service;
    }

    public TechnicalStaff6 getTechnicalStaff() {
        return technicalStaff;
    }

    public void setTechnicalStaff(TechnicalStaff6 technicalStaff) {
        this.technicalStaff = technicalStaff;
    }
}