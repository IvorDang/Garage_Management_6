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
<title>GDKetQuaThongKe6 - Kết quả thống kê khách hàng</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <%
        String tuNgayStr = request.getParameter("inTuNgay");
        String denNgayStr = request.getParameter("inDenNgay");
        Date startDate = null, endDate = null;
        List<CustomerStatistic6> listTK = null;
        String errorMsg = null;

        if (tuNgayStr == null || tuNgayStr.isEmpty() || denNgayStr == null || denNgayStr.isEmpty()) {
            errorMsg = "Vui lòng nhập đầy đủ Ngày bắt đầu và Ngày kết thúc!";
        } else {
            try {
                startDate = Date.valueOf(tuNgayStr);
                endDate = Date.valueOf(denNgayStr);
            } catch (Exception e) {
                errorMsg = "Vui lòng nhập thời gian tồn tại!";
            }
        }

        if (errorMsg != null) {
            // da co loi o tren
        } else if (startDate.after(endDate)) {
            errorMsg = "Vui lòng nhập thời gian hợp lệ (Ngày bắt đầu không được lớn hơn Ngày kết thúc)!";
        } else {
            CustomerStatisticDAO6 tkDAO = new CustomerStatisticDAO6();
            listTK = tkDAO.getCustomerStatistic(startDate, endDate);
        }
    %>
    <h2>Thống kê khách hàng theo doanh thu</h2>
    <p><% if (startDate != null && endDate != null) { %>Giai đoạn: <b><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(startDate) %></b> đến <b><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(endDate) %></b> | <% } %><a href="gdChonThongKe6.jsp">[Quay lại]</a></p>

    <% if (errorMsg != null) { %>
        <p style="color:red;"><%= errorMsg %></p>
    <% } else if (listTK == null || listTK.isEmpty()) { %>
        <p style="color:red;">Không có dữ liệu trong khoảng thời gian này.</p>
    <% } else { %>
        <table id="tblKhachHang" border="1" cellpadding="6" style="border-collapse: collapse;">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã KH</th>
                    <th>Họ tên</th>
                    <th>SĐT</th>
                    <th>Tổng doanh thu (VNĐ)</th>
                    <th>Xem hóa đơn</th>
                </tr>
            </thead>
            <tbody>
                <% int stt = 1;
                   for (CustomerStatistic6 tk : listTK) { %>
                <tr>
                    <td><%= stt++ %></td>
                    <td><%= tk.getCustomerCode() %></td>
                    <td><%= tk.getName() %></td>
                    <td><%= tk.getPhone() %></td>
                    <td style="text-align:right;"><%= String.format("%,.0f", tk.getTotalRevenue()) %></td>
                    <td>
                        <a href="gdDSHoaDon6.jsp?customerId=<%= tk.getId() %>&inTuNgay=<%= tuNgayStr %>&inDenNgay=<%= denNgayStr %>">
                            Xem DS hóa đơn
                        </a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</body>
</html>