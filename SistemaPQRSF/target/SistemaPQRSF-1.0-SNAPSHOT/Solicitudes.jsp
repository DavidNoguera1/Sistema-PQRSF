<%@ page import="com.mycompany.sistemapqrsf.gestionarSistema" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%@include file= "templates/header.jsp" %>
<main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <div class="breadcrumbs">
        <div class="page-header d-flex align-items-center" style="background-image: url(https://www.datocms-assets.com/34299/1619745249-customer-support-2x.png);">
            <div class="container position-relative">
                <div class="row d-flex justify-content-center">
                    <div class="col-lg-6 text-center">
                        <h2>Estas son todas solicitudes</h2>
                        <p>Por favor deles una respuesta administrador :)</p>
                    </div>
                </div>
            </div>
        </div>
    </div><!-- End Breadcrumbs -->

    <!-- ======= Contact Section ======= -->
    <section id="contact" class="contact">
        <div class="container" >
            <div class="row">
                <div class="col-lg-12">
                    <table id="solicitudesTable" class="table table-bordered table-dark">
                        <thead>
                            <tr>
                                <th>Usuario</th>
                                <th>Título</th>
                                <th>Mensaje</th>
                                <th>Tipo de Solicitud</th>
                                <th>Fecha de Solicitud</th>
                                <th>Archivo</th>
                                <th>Respuesta</th>
                                <th>Estado</th>
                                <th>Acciones</th> <!-- Nuevo campo de acciones -->
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                gestionarSistema gestionar = new gestionarSistema();
                                Connection conn = null;
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;

                                try {
                                    conn = gestionar.establecerConexion();

                                    String sql = "SELECT s.Titulo, s.Mensaje, u.Nombre AS NombreUsuario, ts.tipo, s.Fecha, s.RutaArchivo, s.Respuesta, s.Estado "
                                            + "FROM Solicitudes s "
                                            + "INNER JOIN Usuarios u ON s.IdUsuario = u.IdUsuario "
                                            + "INNER JOIN TipoSolicitud ts ON s.IdTipoSolicitud = ts.IdTipoSolicitud";

                                    pstmt = conn.prepareStatement(sql);
                                    rs = pstmt.executeQuery();

                                    while (rs.next()) {
                                        String titulo = rs.getString("Titulo");
                                        String mensaje = rs.getString("Mensaje");
                                        String nombreUsuario = rs.getString("NombreUsuario");
                                        String tipoSolicitud = rs.getString("tipo");
                                        String fechaSolicitud = rs.getString("Fecha");
                                        String archivo = rs.getString("RutaArchivo");
                                        String respuesta = rs.getString("Respuesta");
                                        String estado = rs.getString("Estado");
                            %>
                            <tr>
                                <td><%= nombreUsuario%></td>
                                <td><%= titulo%></td>
                                <td><%= mensaje%></td>
                                <td><%= tipoSolicitud%></td>
                                <td><%= fechaSolicitud%></td>
                                <td><%= archivo%></td>
                                <td><%= respuesta%></td>
                                <td><%= estado%></td>
                                <td class="text-center">
                                    <!-- Acción con icono de bootstrap -->
                                    <div class="acciones">
                                        <a href="#" title="Dar respuesta" class="btn btn-success btn-sm">
                                            <i class="bi bi-chat-right-text"></i> 
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <%
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } finally {
                                    try {
                                        if (rs != null) {
                                            rs.close();
                                        }
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
                            %>
                        </tbody>
                    </table>


                </div>
            </div>
        </div>
    </section><!-- End Contact Section -->

</main><!-- End #main -->