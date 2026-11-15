// File: model/Invoice6.java
package model;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class Invoice6 implements Serializable {
    private int id;
    private String invoiceCode;
    private Date createdDate;
    private float totalAmount;
    private Customer6 customer; // Hỗ trợ hiển thị tên KH trên trang chi tiết HĐ
    private List<ServiceDetail6> serviceDetails = new ArrayList<>();
    private List<SparePartDetail6> sparePartDetails = new ArrayList<>();

    public Invoice6() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getInvoiceCode() {
        return invoiceCode;
    }

    public void setInvoiceCode(String invoiceCode) {
        this.invoiceCode = invoiceCode;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Customer6 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer6 customer) {
        this.customer = customer;
    }

    public List<ServiceDetail6> getServiceDetails() {
        return serviceDetails;
    }

    public void setServiceDetails(List<ServiceDetail6> serviceDetails) {
        this.serviceDetails = serviceDetails;
    }

    public List<SparePartDetail6> getSparePartDetails() {
        return sparePartDetails;
    }

    public void setSparePartDetails(List<SparePartDetail6> sparePartDetails) {
        this.sparePartDetails = sparePartDetails;
    }
}