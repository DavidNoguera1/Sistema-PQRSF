<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="javax.servlet.http.*" %>

<%
    // Invalidar la sesión actual
    HttpSession session = request.getSession(false);
    if (session != null) {
        session.invalidate();
    }
    
    // Redirigir a la página de inicio después de cerrar sesión
    response.sendRedirect("index.jsp");
%>
