package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.CustomerStatistic6;

public class CustomerStatisticDAO6 extends DAO6 {
    public CustomerStatisticDAO6() {
        super();
    }

    public List<CustomerStatistic6> getCustomerStatistic(Date startDate, Date endDate) {
        List<CustomerStatistic6> list = new ArrayList<>();
        String sql = "SELECT c.id AS customerId, c.customerCode, m.name, m.phone, m.email, "
                + "SUM(i.totalAmount) AS totalRevenue "
                + "FROM tblCustomer6 c "
                + "JOIN tblSystemMember6 m ON c.tblSystemMember6id = m.id "
                + "JOIN tblVehicle6 v ON v.tblCustomer6id = c.id "
                + "JOIN tblReception6 r ON r.tblVehicle6id = v.id "
                + "JOIN tblInvoice6 i ON i.tblReception6id = r.id "
                + "WHERE DATE(i.createdDate) BETWEEN ? AND ? "
                + "GROUP BY c.id, c.customerCode, m.name, m.phone, m.email "
                + "ORDER BY totalRevenue DESC";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CustomerStatistic6 tk = new CustomerStatistic6();
                tk.setId(rs.getInt("customerId"));
                tk.setCustomerCode(rs.getString("customerCode"));
                tk.setName(rs.getString("name"));
                tk.setPhone(rs.getString("phone"));
                tk.setEmail(rs.getString("email"));
                tk.setTotalRevenue(rs.getFloat("totalRevenue"));
                tk.setStartDate(startDate);
                tk.setEndDate(endDate);
                list.add(tk);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}