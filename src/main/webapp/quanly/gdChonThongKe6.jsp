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
<script>
    // Chi ho tro thong ke khach hang theo doanh thu; cac loai khac ngoai pham vi 2 module
    function kiemTraLoaiTK(sel) {
        if (sel.value !== "KH_DOANHTHU") {
            alert("Chức năng đang phát triển (ngoài phạm vi 2 module)");
            sel.value = "KH_DOANHTHU";
        }
    }
</script>
</head>
<body>
    <h2>Chọn loại thống kê</h2>
    <p><a href="gdChinhQL6.jsp">[Quay lại]</a></p>

    <form action="gdKetQuaThongKe6.jsp" method="get">
        <table>
            <tr>
                <td>Loại thống kê:</td>
                <td>
                    <select name="inLoaiTK" id="inLoaiTK" onchange="kiemTraLoaiTK(this)">
                        <option value="KH_DOANHTHU" selected>Thống kê khách hàng theo doanh thu</option>
                        <option value="DICHVU" disabled>Thống kê dịch vụ (đang phát triển - ngoài phạm vi)</option>
                        <option value="PHUTUNG" disabled>Thống kê phụ tùng (đang phát triển - ngoài phạm vi)</option>
                        <option value="NHACUNGCAP" disabled>Thống kê nhà cung cấp (đang phát triển - ngoài phạm vi)</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Từ ngày:</td>
                <td><input type="text" name="inTuNgay" value="01/01/2026" placeholder="dd/mm/yyyy" maxlength="10" required /></td>
            </tr>
            <tr>
                <td>Đến ngày:</td>
                <td><input type="text" name="inDenNgay" value="30/06/2026" placeholder="dd/mm/yyyy" maxlength="10" required /></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="submit" name="subTimKiem" value="Tìm kiếm" /></td>
            </tr>
        </table>
    </form>
</body>
</html>