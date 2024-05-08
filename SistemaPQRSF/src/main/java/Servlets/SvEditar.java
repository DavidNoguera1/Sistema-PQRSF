/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.sistemapqrsf.gestionarSolicitud;
import static com.mycompany.sistemapqrsf.gestionarSolicitud.editarSolicitud;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
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
@WebServlet(name = "SvEditar", urlPatterns = {"/SvEditar"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB

public class SvEditar extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los parámetros del formulario
        int idSolicitud = Integer.parseInt(request.getParameter("idSolicitud"));
        String titulo = request.getParameter("titulo");
        String mensaje = request.getParameter("mensaje");
        int idTipoSolicitud = Integer.parseInt(request.getParameter("tipoSolicitud"));

        // Verificar si se ha adjuntado un nuevo archivo
        Part filePart = request.getPart("archivo");
        String rutaArchivo = null;
        if (filePart != null && filePart.getSize() > 0) {
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
            rutaArchivo = File.separator + fileName;
        } else {
            // Si no se ha adjuntado un nuevo archivo, utilizar la ruta del archivo anterior
            rutaArchivo = request.getParameter("rutaArchivoAnterior");
        }

        // Llamar a la función editarSolicitud
        gestionarSolicitud.editarSolicitud(idSolicitud, titulo, mensaje, rutaArchivo, idTipoSolicitud);

        // Redirigir a la página de inicio o mostrar un mensaje de éxito
        response.sendRedirect("MisSolicitudes.jsp"); // o mostrar un mensaje de éxito
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
