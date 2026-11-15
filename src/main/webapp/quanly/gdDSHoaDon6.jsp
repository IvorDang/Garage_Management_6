<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.sql.Date, model.*, dao.*"%>
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
<title>GDDSHoaDon6 - Danh sách hóa đơn khách hàng</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <%
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String tuNgayStr = request.getParameter("inTuNgay");
        String denNgayStr = request.getParameter("inDenNgay");
        Date startDate = Date.valueOf(tuNgayStr);
        Date endDate = Date.valueOf(denNgayStr);

        InvoiceDAO6 invDAO = new InvoiceDAO6();
        List<Invoice6> listInvoice = invDAO.getInvoicesByCustomer(customerId, startDate, endDate);
        String customerName = (listInvoice != null && !listInvoice.isEmpty()) ? listInvoice.get(0).getCustomer().getName() : "";
    %>
    <h2>Danh sách hóa đơn - Khách hàng: <%= customerName %></h2>
    <p><a href="gdKetQuaThongKe6.jsp?inTuNgay=<%= tuNgayStr %>&inDenNgay=<%= denNgayStr %>">[Quay lại]</a></p>

    <table id="tblHoaDon" border="1" cellpadding="6" style="border-collapse: collapse;">
        <thead>
            <tr>
                <th>STT</th>
                <th>Mã HĐ</th>
                <th>Ngày lập</th>
                <th>Tổng tiền (VNĐ)</th>
                <th>Chi tiết</th>
            </tr>
        </thead>
        <tbody>
            <% if (listInvoice != null) {
                int stt = 1;
                for (Invoice6 inv : listInvoice) { %>
                <tr>
                    <td><%= stt++ %></td>
                    <td><%= inv.getInvoiceCode() %></td>
                    <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(inv.getCreatedDate()) %></td>
                    <td style="text-align:right;"><%= String.format("%,.0f", inv.getTotalAmount()) %></td>
                    <td>
                        <a href="gdChiTietHoaDon6.jsp?invoiceId=<%= inv.getId() %>&customerId=<%= customerId %>&inTuNgay=<%= tuNgayStr %>&inDenNgay=<%= denNgayStr %>">
                            Xem chi tiết
                        </a>
                    </td>
                </tr>
            <%  }
               } %>
        </tbody>
    </table>
</body>
</html>