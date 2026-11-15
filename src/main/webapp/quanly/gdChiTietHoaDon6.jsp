<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, model.*, dao.*"%>
<%
    if (session.getAttribute("manager") == null) {
        response.sendRedirect("../thanhvien/gdDangNhap6.jsp?err=timeout");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GDChiTietHoaDon6 - Chi tiết hóa đơn</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <%
        int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
        String customerId = request.getParameter("customerId");
        String tuNgayStr = request.getParameter("inTuNgay");
        String denNgayStr = request.getParameter("inDenNgay");

        InvoiceDAO6 invDAO = new InvoiceDAO6();
        Invoice6 invoice = invDAO.getInvoiceDetail(invoiceId);
    %>
    <% if (invoice != null) { %>
        <h2>Chi tiết hóa đơn <%= invoice.getInvoiceCode() %></h2>
        <p><a href="gdDSHoaDon6.jsp?customerId=<%= customerId %>&inTuNgay=<%= tuNgayStr %>&inDenNgay=<%= denNgayStr %>">[Quay lại]</a></p>

        <div id="outThongTinChung">
            <p><b>Mã HĐ:</b> <%= invoice.getInvoiceCode() %></p>
            <p><b>Khách hàng:</b> <%= invoice.getCustomer().getName() %> (<%= invoice.getCustomer().getCustomerCode() %>)</p>
            <p><b>Ngày lập:</b> <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(invoice.getCreatedDate()) %></p>
            <p><b>Tổng tiền:</b> <%= String.format("%,.0f VNĐ", invoice.getTotalAmount()) %></p>
        </div>

        <h3>BẢNG DỊCH VỤ</h3>
        <table id="tblChiTietDichVu" border="1" cellpadding="6" style="border-collapse: collapse;">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã DV</th>
                    <th>Tên dịch vụ</th>
                    <th>Đơn giá (VNĐ)</th>
                    <th>Số lượng</th>
                    <th>Thành tiền (VNĐ)</th>
                    <th>Nhân viên kỹ thuật</th>
                </tr>
            </thead>
            <tbody>
                <% int sttDV = 1;
                   for (ServiceDetail6 sd : invoice.getServiceDetails()) { %>
                <tr>
                    <td><%= sttDV++ %></td>
                    <td><%= sd.getService().getServiceCode() %></td>
                    <td><%= sd.getService().getName() %></td>
                    <td style="text-align:right;"><%= String.format("%,.0f", sd.getUnitPrice()) %></td>
                    <td style="text-align:center;"><%= sd.getQuantity() %></td>
                    <td style="text-align:right;"><%= String.format("%,.0f", sd.getSubTotal()) %></td>
                    <td><%= sd.getTechnicalStaff().getName() %> (<%= sd.getTechnicalStaff().getStaffCode() %>)</td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <h3>BẢNG PHỤ TÙNG</h3>
        <table id="tblChiTietPhuTung" border="1" cellpadding="6" style="border-collapse: collapse;">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã PT</th>
                    <th>Tên phụ tùng</th>
                    <th>Đơn giá (VNĐ)</th>
                    <th>Số lượng</th>
                    <th>Thành tiền (VNĐ)</th>
                </tr>
            </thead>
            <tbody>
                <% int sttPT = 1;
                   for (SparePartDetail6 pd : invoice.getSparePartDetails()) { %>
                <tr>
                    <td><%= sttPT++ %></td>
                    <td><%= pd.getSparePart().getPartCode() %></td>
                    <td><%= pd.getSparePart().getName() %></td>
                    <td style="text-align:right;"><%= String.format("%,.0f", pd.getUnitPrice()) %></td>
                    <td style="text-align:center;"><%= pd.getQuantity() %></td>
                    <td style="text-align:right;"><%= String.format("%,.0f", pd.getSubTotal()) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</body>
</html>