/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.sistemapqrsf;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
public class gestionarSistema {

    public static Connection establecerConexion() {
        String url = "jdbc:mysql://localhost:3306/dbsistema?serverTimeZone=utc";
        String user = "root"; // Nombre de usuario correcto
        String password = "123456"; // Contraseña de tu base de datos, si la tienes
        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            if (conn != null) {
                System.out.println("Conexion exitosa");
            }
        } catch (Exception e) {
            System.out.println("Error de conexion" + e.getMessage());
        }
        return conn;
    }

    public void crearUsuario(String nombre, String apellido, String cedula, String correo, String contrasena, String rol) {
        Connection conn = establecerConexion();
        CallableStatement cs = null;

        try {
            cs = conn.prepareCall("{ call crearUsuarios(?, ?, ?, ?, ?, ?) }");
            cs.setString(1, nombre);
            cs.setString(2, apellido);
            cs.setString(3, cedula);
            cs.setString(4, correo);
            cs.setString(5, contrasena);
            cs.setString(6, rol);
            cs.execute();
        } catch (SQLException e) {
            System.out.println("Error al crear el usuario: " + e.getMessage());
        } finally {
            try {
                if (cs != null) {
                    cs.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error al cerrar la conexión: " + ex.getMessage());
            }
        }
    }

    public boolean cedulaDuplicada(String cedula) {
        // Consulta SQL para verificar si la cédula ya existe en la base de datos
        String sql = "SELECT COUNT(*) AS count FROM usuarios WHERE Cedula = ?";

        try (Connection conn = establecerConexion(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, cedula);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                return count > 0; // Si count es mayor que 0, significa que la cédula ya está registrada
            }
        } catch (SQLException e) {
            System.out.println("Error al verificar la cédula duplicada: " + e.getMessage());
        }

        return false; // Si hay algún error o no se encuentra la cédula, se devuelve false por defecto
    }

    public String[] iniciarSesion(String cedula, String contrasena) {
        Connection conn = establecerConexion();
        String[] datosUsuario = null;

        try {
            String sql = "SELECT IdUsuario, Rol, Nombre, Apellido, Cedula, Correo, Contrasena FROM usuarios WHERE Cedula = ? AND Contrasena = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, cedula);
            pstmt.setString(2, contrasena);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // Si las credenciales son válidas, obtener el id, rol, nombre, apellido, cedula, correo y contrasena del usuario
                int idUsuario = rs.getInt("IdUsuario");
                String rol = rs.getString("Rol");
                String nombre = rs.getString("Nombre");
                String apellido = rs.getString("Apellido");
                String cedulaUsuario = rs.getString("Cedula");
                String correo = rs.getString("Correo");
                String contrasenaUsuario = rs.getString("Contrasena");
                datosUsuario = new String[]{String.valueOf(idUsuario), rol, nombre, apellido, cedulaUsuario, correo, contrasenaUsuario};
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error al iniciar sesión: " + e.getMessage());
            datosUsuario = new String[]{"-1", "ERROR", "ERROR", "ERROR", "ERROR", "ERROR", "ERROR"};
        }

        return datosUsuario;
    }

    public void borrarUsuario(int idUsuario) {
        Connection conn = establecerConexion();
        CallableStatement cs = null;

        try {
            cs = conn.prepareCall("{ call borrarUsuarios(?) }");
            cs.setInt(1, idUsuario);
            cs.execute();
        } catch (SQLException e) {
            System.out.println("Error al borrar el usuario: " + e.getMessage());
        } finally {
            try {
                if (cs != null) {
                    cs.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error al cerrar la conexión: " + ex.getMessage());
            }
        }
    }

    public void editarUsuario(int idUsuario, String nombre, String apellido, String cedula, String correo, String contrasena) {
        Connection conn = establecerConexion();
        CallableStatement cs = null;

        try {
            cs = conn.prepareCall("{ call editarUsuarios(?, ?, ?, ?, ?, ?) }");
            cs.setInt(1, idUsuario);
            cs.setString(2, nombre);
            cs.setString(3, apellido);
            cs.setString(4, cedula);
            cs.setString(5, correo);
            cs.setString(6, contrasena);
            cs.execute();
        } catch (SQLException e) {
            System.out.println("Error al editar el usuario: " + e.getMessage());
        } finally {
            try {
                if (cs != null) {
                    cs.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error al cerrar la conexión: " + ex.getMessage());
            }
        }
    }

}
