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
            String sql = "INSERT INTO Solicitudes (IdUsuario, IdTipoSolicitud, Titulo, Mensaje, RutaArchivo, Estado, Respuesta) " +
                         "VALUES (?, ?, ?, ?, ?, 'Sin revisar', 'No hay respuestas todavia :(')";
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
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}


