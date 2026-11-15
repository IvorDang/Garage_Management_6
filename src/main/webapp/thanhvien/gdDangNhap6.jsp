<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng nhập - Garage System</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <h2>ĐĂNG NHẬP HỆ THỐNG GARAGE</h2>
    <% if ("fail".equals(request.getParameter("err"))) { %>
        <p style="color:red;">Sai tên đăng nhập hoặc mật khẩu!</p>
    <% } else if ("needlogin".equals(request.getParameter("err"))) { %>
        <p style="color:red;">Vui lòng đăng nhập để sử dụng chức năng này!</p>
    <% } else if ("timeout".equals(request.getParameter("err"))) { %>
        <p style="color:red;">Hết phiên làm việc. Vui lòng đăng nhập lại!</p>
    <% } %>
    <form action="doDangNhap6.jsp" method="post">
        <table>
            <tr>
                <td>Tên đăng nhập:</td>
                <td><input type="text" name="username" required placeholder="kh1 hoặc ql1" /></td>
            </tr>
            <tr>
                <td>Mật khẩu:</td>
                <td><input type="password" name="password" required placeholder="123" /></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="submit" value="Đăng nhập" /></td>
            </tr>
        </table>
    </form>
    <p><a href="../khachhang/gdChinhKH6.jsp">[ Về trang chủ - xem dịch vụ/phụ tùng không cần đăng nhập ]</a></p>
</body>
</html>