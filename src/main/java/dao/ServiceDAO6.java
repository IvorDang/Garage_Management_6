package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Service6;

public class ServiceDAO6 extends DAO6 {
    public ServiceDAO6() {
        super();
    }

    public List<Service6> searchService(String keyword) {
        List<Service6> list = new ArrayList<>();
        String sql = "SELECT * FROM tblService6 WHERE name LIKE ? OR serviceCode LIKE ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            String kw = "%" + (keyword == null ? "" : keyword.trim()) + "%";
            ps.setString(1, kw);
            ps.setString(2, kw);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service6 s = new Service6();
                s.setId(rs.getInt("id"));
                s.setServiceCode(rs.getString("serviceCode"));
                s.setName(rs.getString("name"));
                s.setDescription(rs.getString("description"));
                s.setPrice(rs.getFloat("price"));
                s.setStatus(rs.getString("status"));
                s.setSupportedVehicleType(rs.getString("supportedVehicleType"));
                s.setWarrantyPeriod(rs.getInt("warrantyPeriod"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Service6 getServiceDetail(int id) {
        Service6 s = null;
        String sql = "SELECT * FROM tblService6 WHERE id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                s = new Service6();
                s.setId(rs.getInt("id"));
                s.setServiceCode(rs.getString("serviceCode"));
                s.setName(rs.getString("name"));
                s.setDescription(rs.getString("description"));
                s.setPrice(rs.getFloat("price"));
                s.setStatus(rs.getString("status"));
                s.setSupportedVehicleType(rs.getString("supportedVehicleType"));
                s.setWarrantyPeriod(rs.getInt("warrantyPeriod"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return s;
    }
}