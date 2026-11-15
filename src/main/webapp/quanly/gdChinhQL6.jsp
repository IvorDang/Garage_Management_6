<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.*"%>
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
<title>GDChinhQL6 - Trang chủ Quản lý</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <%
        SystemMember6 ql = (SystemMember6) session.getAttribute("manager");
    %>
    <h2>Garage System - Quản lý</h2>
    <p>Xin chào: <b><%= (ql != null) ? ql.getName() : "Quản lý" %></b></p>
    <p><a id="subXemThongKe" href="gdChonThongKe6.jsp">[Xem báo cáo thống kê]</a></p>
    <p><a href="#" onclick="alert('Chức năng đang phát triển (ngoài phạm vi 2 module)'); return false;">[Quản lý dịch vụ]</a></p>
    <p><a href="#" onclick="alert('Chức năng đang phát triển (ngoài phạm vi 2 module)'); return false;">[Quản lý phụ tùng]</a></p>
    <p><a href="../thanhvien/doDangXuat6.jsp">[Đăng xuất]</a></p>
</body>
</html>