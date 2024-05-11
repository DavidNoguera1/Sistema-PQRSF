/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.sistemapqrsf.gestionarSistema;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author David Noguera
 */
@WebServlet(name = "SvEditarUsuario", urlPatterns = {"/SvEditarUsuario"})
public class SvEditarUsuario extends HttpServlet {

    // Create a new instance of the gestionarSistema class
    gestionarSistema gs = new gestionarSistema();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the user's information from the request parameters
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        String cedula = request.getParameter("cedula");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String contrasena = request.getParameter("contrasena");
        String correo = request.getParameter("correo");

        // Create a new instance of the gestionarSistema class
        gestionarSistema gs = new gestionarSistema();

        // Call the editarUsuario method to update the user's information in the database
        try {
            gs.editarUsuario(idUsuario, nombre, apellido, cedula, correo, contrasena);
        } catch (Exception e) {
            request.setAttribute("error", "Error al actualizar el usuario: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
            return;
        }

        // Get the current session
        HttpSession session = request.getSession();

        // Update the session attributes with the updated user information
        session.setAttribute("idUsuario", idUsuario);
        session.setAttribute("cedula", cedula);
        session.setAttribute("nombre", nombre);
        session.setAttribute("apellido", apellido);
        session.setAttribute("correo", correo);

        // Redirect the user back to the home page or another page of your choice
        response.sendRedirect("index.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
