package model;

import java.io.Serializable;
import java.util.Date;

public class Reception6 implements Serializable {
    private int id;
    private String receptionCode;
    private Date checkInTime;
    private String status;
    private Vehicle6 vehicle;

    public Reception6() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getReceptionCode() { return receptionCode; }
    public void setReceptionCode(String receptionCode) { this.receptionCode = receptionCode; }

    public Date getCheckInTime() { return checkInTime; }
    public void setCheckInTime(Date checkInTime) { this.checkInTime = checkInTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Vehicle6 getVehicle() { return vehicle; }
    public void setVehicle(Vehicle6 vehicle) { this.vehicle = vehicle; }
}
