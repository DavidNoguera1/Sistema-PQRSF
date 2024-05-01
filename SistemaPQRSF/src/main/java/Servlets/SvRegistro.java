/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.sistemapqrsf.gestionarSistema;
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
@WebServlet(name = "SvRegistro", urlPatterns = {"/SvRegistro"})
public class SvRegistro extends HttpServlet {

    gestionarSistema gestionar = new gestionarSistema();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // No es necesario implementar nada en el doGet
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String cedula = request.getParameter("cedula");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        String rol = request.getParameter("rol");

        boolean error = false;

        // Verificar si la cédula ya está registrada
        if (gestionar.cedulaDuplicada(cedula)) {
            error = true;
        } else {
            gestionar.crearUsuario(nombre, apellido, cedula, correo, contrasena, rol);
        }

        // Redirigir a index.jsp con un parámetro de éxito o error
        if (error) {
            response.sendRedirect("index.jsp?error=true");
        } else {
            response.sendRedirect("index.jsp?success=true");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para el registro de usuarios";
    }
}
