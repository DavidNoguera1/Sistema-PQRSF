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
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
        String correoUsuario = request.getParameter("correoUsuario");
        String respuesta = request.getParameter("respuesta");

        // Convertir idSolicitudStr a un entero
        int idSolicitud = Integer.parseInt(idSolicitudStr);
        
        // Llamar a la función para atender la solicitud (opcional)
        gestionarSolicitud.atenderSolicitud(idSolicitud, respuesta);

        // Enviar correo electrónico
        String asunto = "Respuesta a su solicitud PQRS";
        String mensaje = "Estimado usuario,\n\n" + respuesta + "\n\nAtentamente,\nEquipo de Soporte, \natt: Juan Arevalo - David Noguera";

        try {
            gestionarSolicitud.enviarCorreo(correoUsuario, asunto, mensaje);
        } catch (MessagingException e) {
            e.printStackTrace();
            // Manejar la excepción si es necesario
        }

        // Redirigir a una página de confirmación o a la página principal
        response.sendRedirect("Solicitudes.jsp");
    }

    

    @Override
    public String getServletInfo() {
        return "Servlet para procesar la respuesta a una solicitud";
    }
}
