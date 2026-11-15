// File: model/SparePartDetail6.java
package model;

import java.io.Serializable;

public class SparePartDetail6 implements Serializable {
    private int id;
    private int quantity;
    private float unitPrice;
    private float subTotal;
    private SparePart6 sparePart;

    public SparePartDetail6() {
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

    public SparePart6 getSparePart() {
        return sparePart;
    }

    public void setSparePart(SparePart6 sparePart) {
        this.sparePart = sparePart;
    }
}