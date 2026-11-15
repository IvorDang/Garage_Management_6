package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.SparePart6;

public class SparePartDAO6 extends DAO6 {
    public SparePartDAO6() {
        super();
    }

    public List<SparePart6> searchSparePart(String keyword) {
        List<SparePart6> list = new ArrayList<>();
        String sql = "SELECT * FROM tblSparePart6 WHERE name LIKE ? OR partCode LIKE ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            String kw = "%" + (keyword == null ? "" : keyword.trim()) + "%";
            ps.setString(1, kw);
            ps.setString(2, kw);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SparePart6 p = new SparePart6();
                p.setId(rs.getInt("id"));
                p.setPartCode(rs.getString("partCode"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getFloat("price"));
                p.setStock(rs.getInt("stock"));
                p.setSupportedVehicleType(rs.getString("supportedVehicleType"));
                p.setWarrantyPeriod(rs.getInt("warrantyPeriod"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public SparePart6 getSparePartDetail(int id) {
        SparePart6 p = null;
        String sql = "SELECT * FROM tblSparePart6 WHERE id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                p = new SparePart6();
                p.setId(rs.getInt("id"));
                p.setPartCode(rs.getString("partCode"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getFloat("price"));
                p.setStock(rs.getInt("stock"));
                p.setSupportedVehicleType(rs.getString("supportedVehicleType"));
                p.setWarrantyPeriod(rs.getInt("warrantyPeriod"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }
}