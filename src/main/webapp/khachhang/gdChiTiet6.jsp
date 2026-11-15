<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.*, dao.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GDChiTiet6 - Chi tiết dịch vụ/phụ tùng</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <%
        int id = Integer.parseInt(request.getParameter("id"));
        String loai = request.getParameter("loai");
        String keyword = request.getParameter("inTuKhoa");

        Service6 service = null;
        SparePart6 sparePart = null;

        if ("SERVICE".equalsIgnoreCase(loai)) {
            service = (new ServiceDAO6()).getServiceDetail(id);
        } else {
            sparePart = (new SparePartDAO6()).getSparePartDetail(id);
        }
    %>
    <h2>Chi tiết phụ tùng/dịch vụ</h2>
    <p><a id="subQuayLai" href="gdTimKiem6.jsp?inTuKhoa=<%= (keyword != null) ? keyword : "" %>">[Quay lại]</a></p>

    <% if (sparePart != null && sparePart.getStock() <= 0) { %>
        <p style="color:orange;">Phụ tùng này hiện đang tạm hết, vui lòng liên hệ trực tiếp nhân viên bán hàng.</p>
    <% } %>
    <% if (service != null && !"Khả dụng".equals(service.getStatus())) { %>
        <p style="color:orange;">Dịch vụ/phụ tùng này hiện không khả dụng.</p>
    <% } %>
    <% if (sparePart != null) { %>
        <table border="1" cellpadding="6" style="border-collapse: collapse;">
            <tr><td><b>Mã</b></td><td><%= sparePart.getPartCode() %></td></tr>
            <tr><td><b>Tên</b></td><td><%= sparePart.getName() %></td></tr>
            <tr><td><b>Đơn giá</b></td><td><%= String.format("%,.0f VNĐ", sparePart.getPrice()) %></td></tr>
            <tr><td><b>Tình trạng</b></td><td><%= (sparePart.getStock() > 0) ? "Còn hàng (Tồn: " + sparePart.getStock() + ")" : "Hết hàng (Tồn: 0)" %></td></tr>
            <tr><td><b>Dòng xe hỗ trợ</b></td><td><%= sparePart.getSupportedVehicleType() %></td></tr>
            <tr><td><b>Bảo hành</b></td><td><%= sparePart.getWarrantyPeriod() %> tháng</td></tr>
            <tr><td><b>Mô tả</b></td><td><%= sparePart.getDescription() %></td></tr>
        </table>
    <% } else if (service != null) { %>
        <table border="1" cellpadding="6" style="border-collapse: collapse;">
            <tr><td><b>Mã</b></td><td><%= service.getServiceCode() %></td></tr>
            <tr><td><b>Tên</b></td><td><%= service.getName() %></td></tr>
            <tr><td><b>Đơn giá</b></td><td><%= String.format("%,.0f VNĐ", service.getPrice()) %></td></tr>
            <tr><td><b>Tình trạng</b></td><td><%= service.getStatus() %></td></tr>
            <tr><td><b>Dòng xe hỗ trợ</b></td><td><%= service.getSupportedVehicleType() %></td></tr>
            <tr><td><b>Bảo hành</b></td><td><%= service.getWarrantyPeriod() %> tháng</td></tr>
            <tr><td><b>Mô tả</b></td><td><%= service.getDescription() %></td></tr>
        </table>
    <% } %>
</body>
</html>