/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.sistemapqrsf.gestionarSolicitud;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author PC
 */
@WebServlet(name = "SvSolicitud", urlPatterns = {"/SvSolicitud"})
public class SvSolicitud extends HttpServlet {

    

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los parámetros del formulario
        String titulo = request.getParameter("titulo");
        String mensaje = request.getParameter("mensaje");
        int tipoSolicitud = Integer.parseInt(request.getParameter("tipoSolicitud"));
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        LocalDateTime fechaSolicitud = LocalDateTime.now();
        String rutaArchivo = ""; // Aquí puedes agregar lógica para manejar el archivo adjunto si es necesario
        
        // Insertar la solicitud en la base de datos
        gestionarSolicitud.crearSolicitud(idUsuario, tipoSolicitud, titulo, mensaje, rutaArchivo, fechaSolicitud);
        
        // Redirigir a una página de confirmación o a donde sea necesario
        response.sendRedirect("MisSolicitudes.jsp"); 
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
