/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.sistemapqrsf;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.mycompany.sistemapqrsf.gestionarSistema;
import java.time.LocalDateTime;

public class gestionarSolicitud {

    gestionarSistema gestionar = new gestionarSistema();

    public static void crearSolicitud(int p_IdUsuario, int p_IdTipoSolicitud, String p_Titulo, String p_Mensaje, String p_RutaArchivo, LocalDateTime p_FechaSolicitud) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Obtener conexión a la base de datos

            conn = gestionarSistema.establecerConexion();

            // Preparar la consulta SQL
            String sql = "INSERT INTO Solicitudes (IdUsuario, IdTipoSolicitud, Titulo, Mensaje, RutaArchivo, Estado, Respuesta) "
                    + "VALUES (?, ?, ?, ?, ?, 'Sin revisar', 'No hay respuestas todavia :(')";
            pstmt = conn.prepareStatement(sql);

            // Establecer los parámetros de la consulta
            pstmt.setInt(1, p_IdUsuario);
            pstmt.setInt(2, p_IdTipoSolicitud);
            pstmt.setString(3, p_Titulo);
            pstmt.setString(4, p_Mensaje);
            pstmt.setString(5, p_RutaArchivo);

            // Ejecutar la consulta
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Cerrar la conexión y liberar los recursos
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void borrarSolicitud(int idSolicitud) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Obtener conexión a la base de datos desde la clase gestionarSistema
            conn = gestionarSistema.establecerConexion();

            // Definir la consulta SQL con el procedimiento almacenado
            String sql = "CALL borrarSolicitud(?)";

            // Crear una declaración preparada con la consulta
            pstmt = conn.prepareStatement(sql);

            // Establecer el parámetro ID de la solicitud
            pstmt.setInt(1, idSolicitud);

            // Ejecutar el procedimiento almacenado
            pstmt.executeUpdate();

            // La solicitud ha sido borrada exitosamente
            System.out.println("La solicitud ha sido borrada exitosamente.");
        } catch (SQLException e) {
            // Manejar cualquier excepción SQL
            e.printStackTrace();
        } finally {
            // Cerrar la conexión y liberar los recursos
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static void editarSolicitud(int p_IdSolicitud, String p_Titulo, String p_Mensaje, String p_RutaArchivo, int p_IdTipoSolicitud) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            // Obtener conexión a la base de datos
            conn = gestionarSistema.establecerConexion();
            // Preparar la consulta SQL
            String sql = "UPDATE Solicitudes SET Titulo =?, Mensaje =?, RutaArchivo =?, IdTipoSolicitud =? WHERE IdSolicitud =?";
            pstmt = conn.prepareStatement(sql);
            // Establecer los parámetros de la consulta
            pstmt.setString(1, p_Titulo);
            pstmt.setString(2, p_Mensaje);
            pstmt.setString(3, p_RutaArchivo);
            pstmt.setInt(4, p_IdTipoSolicitud);
            pstmt.setInt(5, p_IdSolicitud);
            // Ejecutar la consulta
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Cerrar la conexión y liberar los recursos
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void atenderSolicitud(int p_IdSolicitud, String p_Respuesta) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Obtener conexión a la base de datos
            conn = gestionarSistema.establecerConexion();

            // Preparar la consulta SQL
            String sql = "UPDATE Solicitudes SET Respuesta = ?, Estado = 'Revisado' WHERE IdSolicitud = ?";
            pstmt = conn.prepareStatement(sql);

            // Establecer los parámetros de la consulta
            pstmt.setString(1, p_Respuesta);
            pstmt.setInt(2, p_IdSolicitud);

            // Ejecutar la consulta
            pstmt.executeUpdate();

            // La solicitud ha sido atendida y marcada como revisada
            System.out.println("La solicitud ha sido atendida y marcada como revisada.");
        } catch (SQLException e) {
            // Manejar cualquier excepción SQL
            e.printStackTrace();
        } finally {
            // Cerrar la conexión y liberar los recursos
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
