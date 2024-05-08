/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.sistemapqrsf.gestionarSolicitud;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author PC
 */
@WebServlet(name = "SvSolicitud", urlPatterns = {"/SvSolicitud"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class SvSolicitud extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener el ID de la solicitud a eliminar desde los parámetros de la solicitud
        int idSolicitud = Integer.parseInt(request.getParameter("idSolicitud"));

        // Llamar al método para eliminar la solicitud
        gestionarSolicitud.borrarSolicitud(idSolicitud);

        // Redirigir a una página de confirmación o a donde sea necesario
        response.sendRedirect("MisSolicitudes.jsp"); // Reemplaza "confirmacion.jsp" con la página que desees
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

        Part filePart = request.getPart("archivoAdjunto");

        // Obtener el nombre del archivo
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.

        // Guardar el archivo en la carpeta "archivos"
        String uploadPath = getServletContext().getRealPath("") + File.separator + "archivos";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        String filePath = uploadPath + File.separator + fileName;
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
        }

        // Ruta del archivo (ruta relativa)
        String pdf = File.separator + fileName;

       
        // Insertar la solicitud en la base de datos
        gestionarSolicitud.crearSolicitud(idUsuario, tipoSolicitud, titulo, mensaje, pdf, fechaSolicitud);

        // Redirigir a una página de confirmación o a donde sea necesario
        response.sendRedirect("MisSolicitudes.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
