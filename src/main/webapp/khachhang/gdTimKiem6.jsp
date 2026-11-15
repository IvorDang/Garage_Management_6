<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, model.*, dao.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GDTimKiem6 - Tìm kiếm phụ tùng/dịch vụ</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");
        String keyword = request.getParameter("inTuKhoa");
        List<Service6> listService = null;
        List<SparePart6> listSparePart = null;

        if (keyword != null) {
            if (!keyword.trim().isEmpty()) {
                ServiceDAO6 sDAO = new ServiceDAO6();
                SparePartDAO6 pDAO = new SparePartDAO6();
                listService = sDAO.searchService(keyword);
                listSparePart = pDAO.searchSparePart(keyword);
            }
        }
    %>
    <h2>Tìm kiếm phụ tùng/dịch vụ</h2>
    <p><a href="gdChinhKH6.jsp">[Quay lại Trang chủ]</a></p>

    <form action="gdTimKiem6.jsp" method="get">
        Từ khóa: 
        <input type="text" name="inTuKhoa" value="<%= (keyword != null) ? keyword : "" %>" placeholder="Nhập tên DV/PT (VD: má phanh, Vios)..." />
        <input type="submit" name="subXacNhan" value="Tìm kiếm" />
    </form>
    <br/>

    <% if (keyword != null && keyword.trim().isEmpty()) { %>
        <p style="color:red;">Vui lòng nhập tên dịch vụ/phụ tùng vào ô tìm kiếm!</p>
    <% } else if (keyword != null) { 
        int stt = 1;
        boolean hasResult = (listService != null && !listService.isEmpty()) || (listSparePart != null && !listSparePart.isEmpty());
        if (!hasResult) {
    %>
        <p style="color:red;">Không tìm thấy kết quả phù hợp.</p>
    <%  } else { %>
        <table id="tblKetQua" border="1" cellpadding="6" style="border-collapse: collapse;">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã DV/PT</th>
                    <th>Tên DV/PT</th>
                    <th>Đơn giá (VNĐ)</th>
                    <th>Tình trạng / Tồn kho</th>
                    <th>Dòng xe hỗ trợ</th>
                    <th>Chọn xem</th>
                </tr>
            </thead>
            <tbody>
                <% for (SparePart6 p : listSparePart) { %>
                <tr>
                    <td><%= stt++ %></td>
                    <td><%= p.getPartCode() %></td>
                    <td><%= p.getName() %></td>
                    <td style="text-align:right;"><%= String.format("%,.0f", p.getPrice()) %></td>
                    <td><%= (p.getStock() > 0) ? "Còn hàng (Tồn: " + p.getStock() + ")" : "Hết hàng (Tồn: 0)" %></td>
                    <td><%= p.getSupportedVehicleType() %></td>
                    <td><a href="gdChiTiet6.jsp?id=<%= p.getId() %>&loai=SPAREPART&inTuKhoa=<%= keyword %>">Xem chi tiết</a></td>
                </tr>
                <% } %>
                <% for (Service6 s : listService) { %>
                <tr>
                    <td><%= stt++ %></td>
                    <td><%= s.getServiceCode() %></td>
                    <td><%= s.getName() %></td>
                    <td style="text-align:right;"><%= String.format("%,.0f", s.getPrice()) %></td>
                    <td><%= s.getStatus() %></td>
                    <td><%= s.getSupportedVehicleType() %></td>
                    <td><a href="gdChiTiet6.jsp?id=<%= s.getId() %>&loai=SERVICE&inTuKhoa=<%= keyword %>">Xem chi tiết</a></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <%  } 
       } %>
</body>
</html>