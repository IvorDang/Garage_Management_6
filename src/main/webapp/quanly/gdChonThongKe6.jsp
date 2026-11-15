<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>GDChonThongKe6 - Chọn loại thống kê</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <h2>Chọn loại thống kê</h2>
    <p><a href="gdChinhQL6.jsp">[Quay lại]</a></p>

    <form action="gdKetQuaThongKe6.jsp" method="get">
        <table>
            <tr>
                <td>Loại thống kê:</td>
                <td>
                    <select name="inLoaiTK">
                        <option value="KH_DOANHTHU" selected>Thống kê khách hàng theo doanh thu</option>
                        <option value="DICHVU">Thống kê dịch vụ</option>
                        <option value="PHUTUNG">Thống kê phụ tùng</option>
                        <option value="NHACUNGCAP">Thống kê nhà cung cấp</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Từ ngày:</td>
                <td><input type="date" name="inTuNgay" value="2026-01-01" required /></td>
            </tr>
            <tr>
                <td>Đến ngày:</td>
                <td><input type="date" name="inDenNgay" value="2026-06-30" required /></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="submit" name="subTimKiem" value="Tìm kiếm" /></td>
            </tr>
        </table>
    </form>
</body>
</html>