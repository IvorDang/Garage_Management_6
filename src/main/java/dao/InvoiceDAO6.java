package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Customer6;
import model.Invoice6;
import model.Service6;
import model.ServiceDetail6;
import model.SparePart6;
import model.SparePartDetail6;
import model.TechnicalStaff6;

public class InvoiceDAO6 extends DAO6 {
    public InvoiceDAO6() {
        super();
    }

    public List<Invoice6> getInvoicesByCustomer(int customerId, Date startDate, Date endDate) {
        List<Invoice6> list = new ArrayList<>();
        String sql = "SELECT i.*, c.customerCode, m.name AS customerName "
                + "FROM tblInvoice6 i "
                + "JOIN tblReception6 r ON i.tblReception6id = r.id "
                + "JOIN tblVehicle6 v ON r.tblVehicle6id = v.id "
                + "JOIN tblCustomer6 c ON v.tblCustomer6id = c.id "
                + "JOIN tblSystemMember6 m ON c.tblSystemMember6id = m.id "
                + "WHERE c.id = ? AND DATE(i.createdDate) BETWEEN ? AND ? "
                + "ORDER BY i.createdDate ASC";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, customerId);
            ps.setDate(2, startDate);
            ps.setDate(3, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Invoice6 inv = new Invoice6();
                inv.setId(rs.getInt("id"));
                inv.setInvoiceCode(rs.getString("invoiceCode"));
                inv.setCreatedDate(rs.getDate("createdDate"));
                inv.setTotalAmount(rs.getFloat("totalAmount"));

                Customer6 cus = new Customer6();
                cus.setId(customerId);
                cus.setCustomerCode(rs.getString("customerCode"));
                cus.setName(rs.getString("customerName"));
                inv.setCustomer(cus);

                list.add(inv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Invoice6 getInvoiceDetail(int invoiceId) {
        Invoice6 inv = null;
        String sqlInv = "SELECT i.*, c.customerCode, m.name AS customerName "
                + "FROM tblInvoice6 i "
                + "JOIN tblReception6 r ON i.tblReception6id = r.id "
                + "JOIN tblVehicle6 v ON r.tblVehicle6id = v.id "
                + "JOIN tblCustomer6 c ON v.tblCustomer6id = c.id "
                + "JOIN tblSystemMember6 m ON c.tblSystemMember6id = m.id "
                + "WHERE i.id = ?";

        String sqlSrv = "SELECT sd.*, s.serviceCode, s.name AS serviceName, "
                + "st.staffCode, m.name AS techName "
                + "FROM tblServiceDetail6 sd "
                + "JOIN tblService6 s ON sd.tblService6id = s.id "
                + "JOIN tblTechnicalStaff6 ts ON sd.tblTechnicalStaff6id = ts.id "
                + "JOIN tblStaff6 st ON ts.tblStaff6id = st.id "
                + "JOIN tblSystemMember6 m ON st.tblSystemMember6id = m.id "
                + "WHERE sd.tblInvoice6id = ?";

        String sqlPrt = "SELECT pd.*, p.partCode, p.name AS partName "
                + "FROM tblSparePartDetail6 pd "
                + "JOIN tblSparePart6 p ON pd.tblSparePart6id = p.id "
                + "WHERE pd.tblInvoice6id = ?";
        try {
            // 1. Lấy thông tin chung Hóa đơn
            PreparedStatement psInv = con.prepareStatement(sqlInv);
            psInv.setInt(1, invoiceId);
            ResultSet rsInv = psInv.executeQuery();
            if (rsInv.next()) {
                inv = new Invoice6();
                inv.setId(rsInv.getInt("id"));
                inv.setInvoiceCode(rsInv.getString("invoiceCode"));
                inv.setCreatedDate(rsInv.getDate("createdDate"));
                inv.setTotalAmount(rsInv.getFloat("totalAmount"));

                Customer6 cus = new Customer6();
                cus.setCustomerCode(rsInv.getString("customerCode"));
                cus.setName(rsInv.getString("customerName"));
                inv.setCustomer(cus);

                // 2. Lấy danh sách Chi tiết Dịch vụ + Thợ kỹ thuật
                PreparedStatement psSrv = con.prepareStatement(sqlSrv);
                psSrv.setInt(1, invoiceId);
                ResultSet rsSrv = psSrv.executeQuery();
                while (rsSrv.next()) {
                    ServiceDetail6 sd = new ServiceDetail6();
                    sd.setId(rsSrv.getInt("id"));
                    sd.setQuantity(rsSrv.getInt("quantity"));
                    sd.setUnitPrice(rsSrv.getFloat("unitPrice"));
                    sd.setSubTotal(rsSrv.getFloat("subTotal"));

                    Service6 s = new Service6();
                    s.setServiceCode(rsSrv.getString("serviceCode"));
                    s.setName(rsSrv.getString("serviceName"));
                    sd.setService(s);

                    TechnicalStaff6 tech = new TechnicalStaff6();
                    tech.setStaffCode(rsSrv.getString("staffCode"));
                    tech.setName(rsSrv.getString("techName"));
                    sd.setTechnicalStaff(tech);

                    inv.getServiceDetails().add(sd);
                }

                // 3. Lấy danh sách Chi tiết Phụ tùng
                PreparedStatement psPrt = con.prepareStatement(sqlPrt);
                psPrt.setInt(1, invoiceId);
                ResultSet rsPrt = psPrt.executeQuery();
                while (rsPrt.next()) {
                    SparePartDetail6 pd = new SparePartDetail6();
                    pd.setId(rsPrt.getInt("id"));
                    pd.setQuantity(rsPrt.getInt("quantity"));
                    pd.setUnitPrice(rsPrt.getFloat("unitPrice"));
                    pd.setSubTotal(rsPrt.getFloat("subTotal"));

                    SparePart6 p = new SparePart6();
                    p.setPartCode(rsPrt.getString("partCode"));
                    p.setName(rsPrt.getString("partName"));
                    pd.setSparePart(p);

                    inv.getSparePartDetails().add(pd);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return inv;
    }
}