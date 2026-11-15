<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GDChinhKH6 - Trang chủ Khách hàng</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <%
        // Trang chu khach hang: khach vang lai (chua dang nhap) van xem duoc
        Customer6 kh = (Customer6) session.getAttribute("customer");
    %>
    <h2>GARAGE SYSTEM - Khách hàng</h2>
    <p>Xin chào: <b><%= (kh != null) ? kh.getName() : "Khách" %></b></p>
    <p><a id="subTimKiem" href="gdTimKiem6.jsp">[ Tìm kiếm dịch vụ/phụ tùng ]</a></p>
    <% if (kh != null) { %>
        <p><a href="#" onclick="alert('Chức năng đang phát triển (ngoài phạm vi 2 module)'); return false;">[ Đặt lịch hẹn ]</a></p>
        <p><a href="#" onclick="alert('Chức năng đang phát triển (ngoài phạm vi 2 module)'); return false;">[ Xe của tôi ]</a></p>
        <p><a href="../thanhvien/doDangXuat6.jsp">[ Đăng xuất ]</a></p>
    <% } else { %>
        <p><a href="../thanhvien/gdDangNhap6.jsp?err=needlogin">[ Đặt lịch hẹn ]</a> <i>(cần đăng nhập)</i></p>
        <p><a href="../thanhvien/gdDangNhap6.jsp">[ Đăng nhập ]</a></p>
    <% } %>
</body>
</html>
