<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="javax.servlet.http.*" %>

<%
    // Invalidar la sesi�n actual
    HttpSession session = request.getSession(false);
    if (session != null) {
        session.invalidate();
    }
    
    // Redirigir a la p�gina de inicio despu�s de cerrar sesi�n
    response.sendRedirect("index.jsp");
%>
