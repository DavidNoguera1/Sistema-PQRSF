/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.sistemapqrsf.gestionarSolicitud;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author PC
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SvRespuesta", urlPatterns = {"/SvRespuesta"})
public class SvRespuesta extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los parámetros enviados desde el formulario
        String idSolicitudStr = request.getParameter("idSolicitud");
        String respuesta = request.getParameter("respuesta");

        // Convertir idSolicitudStr a un entero
        int idSolicitud = Integer.parseInt(idSolicitudStr);

        // Llamar a la función para atender la solicitud
        gestionarSolicitud.atenderSolicitud(idSolicitud, respuesta);

        // Redirigir a una página de confirmación o a la página principal
        response.sendRedirect("Solicitudes.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Servlet para procesar la respuesta a una solicitud";
    }
}
