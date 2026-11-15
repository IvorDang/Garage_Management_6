<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.*, dao.*"%>
<%
    request.setCharacterEncoding("UTF-8");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    SystemMember6 tv = new SystemMember6();
    tv.setUsername(username);
    tv.setPassword(password);

    SystemMemberDAO6 dao = new SystemMemberDAO6();
    if (dao.checkLogin(tv)) {
        if ("CUSTOMER".equalsIgnoreCase(tv.getRole())) {
            // Lưu đúng kiểu lớp thực thể theo thiết kế (gdChinhKH6: -kh : Customer6)
            Customer6 kh = new Customer6();
            kh.setId(tv.getId());
            kh.setUsername(tv.getUsername());
            kh.setName(tv.getName());
            kh.setRole(tv.getRole());
            session.setAttribute("customer", kh);
            response.sendRedirect("../khachhang/gdChinhKH6.jsp");
        } else if ("MANAGEMENT".equalsIgnoreCase(tv.getRole())) {
            // gdChinhQL6: -ql : ManagementStaff6
            ManagementStaff6 ql = new ManagementStaff6();
            ql.setId(tv.getId());
            ql.setUsername(tv.getUsername());
            ql.setName(tv.getName());
            ql.setRole(tv.getRole());
            session.setAttribute("manager", ql);
            response.sendRedirect("../quanly/gdChinhQL6.jsp");
        } else {
            response.sendRedirect("gdDangNhap6.jsp?err=fail");
        }
    } else {
        response.sendRedirect("gdDangNhap6.jsp?err=fail");
    }
%>