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
            session.setAttribute("customer", tv);
            response.sendRedirect("../khachhang/gdChinhKH6.jsp");
        } else if ("MANAGEMENT".equalsIgnoreCase(tv.getRole())) {
            session.setAttribute("manager", tv);
            response.sendRedirect("../quanly/gdChinhQL6.jsp");
        } else {
            response.sendRedirect("gdDangNhap6.jsp?err=fail");
        }
    } else {
        response.sendRedirect("gdDangNhap6.jsp?err=fail");
    }
%>