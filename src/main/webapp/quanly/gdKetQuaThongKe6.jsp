<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.sql.Date, model.*, dao.*"%>
<%
    if (session.getAttribute("manager") == null) {
        response.sendRedirect("../thanhvien/gdDangNhap6.jsp?err=timeout");
        return;
    }
%>
<%!
    private Date parseNgay(String s) throws java.text.ParseException {
        java.text.SimpleDateFormat f = new java.text.SimpleDateFormat(s.contains("/") ? "dd/MM/yyyy" : "yyyy-MM-dd");
        f.setLenient(false);
        java.text.ParsePosition pos = new java.text.ParsePosition(0);
        java.util.Date d = f.parse(s, pos);
        if (d == null || pos.getIndex() != s.length()) throw new java.text.ParseException(s, pos.getErrorIndex());
        return new Date(d.getTime());
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

        String loaiTK = request.getParameter("inLoaiTK");

        if (loaiTK != null && !loaiTK.isEmpty() && !"KH_DOANHTHU".equals(loaiTK)) {
            // Thong ke dich vu / phu tung / nha cung cap: ngoai pham vi 2 module
            errorMsg = "Chức năng đang phát triển (ngoài phạm vi 2 module). Hiện chỉ hỗ trợ thống kê khách hàng theo doanh thu.";
        } else if (tuNgayStr == null || tuNgayStr.isEmpty() || denNgayStr == null || denNgayStr.isEmpty()) {
            errorMsg = "Vui lòng nhập đầy đủ Ngày bắt đầu và Ngày kết thúc!";
        } else {
            try {
                // Nhận ngày dạng dd/MM/yyyy (từ form) hoặc yyyy-MM-dd (từ link Quay lại); strict: 31/02 là ngày không tồn tại
                startDate = parseNgay(tuNgayStr.trim());
                endDate = parseNgay(denNgayStr.trim());
                tuNgayStr = startDate.toString();   // chuyển sang yyyy-MM-dd để truyền tiếp cho gdDSHoaDon6
                denNgayStr = endDate.toString();
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