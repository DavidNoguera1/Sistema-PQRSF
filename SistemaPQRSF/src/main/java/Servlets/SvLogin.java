package Servlets;

import com.mycompany.sistemapqrsf.gestionarSistema;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SvLogin", urlPatterns = {"/SvLogin"})
public class SvLogin extends HttpServlet {

    gestionarSistema gestionar = new gestionarSistema();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Obtener la sesión actual sin crear una nueva si no existe

        if (session != null) {
            session.invalidate(); // Invalidar la sesión actual
        }

        // Redirigir a la página de inicio
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los datos del formulario de inicio de sesión
        String cedula = request.getParameter("cedula");
        String contrasena = request.getParameter("contrasena");

        // Verificar las credenciales del usuario y obtener el id, rol, nombre, apellido, cedula, correo y contrasena
        String[] datosUsuario = gestionar.iniciarSesion(cedula, contrasena);

        if (datosUsuario != null) {
            // Si las credenciales son válidas, almacenar el id, rol, nombre, apellido, cedula, correo y contrasena en la sesión
            HttpSession session = request.getSession();
            session.setAttribute("idUsuario", datosUsuario[0]); // El id está en la posición 0
            session.setAttribute("rol", datosUsuario[1]); // El rol está en la posición 1
            session.setAttribute("nombre", datosUsuario[2]); // El nombre está en la posición 2
            session.setAttribute("apellido", datosUsuario[3]); // El apellido está en la posición 3
            session.setAttribute("cedula", datosUsuario[4]); // La cedula está en la posición 4
            session.setAttribute("correo", datosUsuario[5]); // El correo está en la posición 5
            session.setAttribute("contrasena", datosUsuario[6]); // La contrasena está en la posición 6
            // Redirigir a la página de inicio
            response.sendRedirect("index.jsp");
        } else {
            // Si las credenciales no son válidas, redirigir de vuelta al formulario de inicio de sesión con un mensaje de error
            response.sendRedirect("index.jsp?errorP=true");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
