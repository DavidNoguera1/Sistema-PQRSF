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

                                    String sql = "SELECT s.IdSolicitud, s.Titulo, s.Mensaje, u.Nombre AS NombreUsuario, u.Correo AS CorreoUsuario, ts.tipo, s.Fecha, s.RutaArchivo, s.Respuesta, s.Estado "
                                            + "FROM Solicitudes s "
                                            + "INNER JOIN Usuarios u ON s.IdUsuario = u.IdUsuario "
                                            + "INNER JOIN TipoSolicitud ts ON s.IdTipoSolicitud = ts.IdTipoSolicitud";

                                    pstmt = conn.prepareStatement(sql);
                                    rs = pstmt.executeQuery();

                                    while (rs.next()) {
                                        String idSolicitud = rs.getString("IdSolicitud");
                                        String titulo = rs.getString("Titulo");
                                        String mensaje = rs.getString("Mensaje");
                                        String nombreUsuario = rs.getString("NombreUsuario");
                                        String tipoSolicitud = rs.getString("tipo");
                                        String fechaSolicitud = rs.getString("Fecha");
                                        String archivo = rs.getString("RutaArchivo");
                                        String respuesta = rs.getString("Respuesta");
                                        String estado = rs.getString("Estado");

                                        String correoUsuario = rs.getString("CorreoUsuario");
                            %>
                            <tr>
                                <td><%= nombreUsuario%></td>
                                <td><%= titulo%></td>
                                <td><%= mensaje%></td>
                                <td><%= tipoSolicitud%></td>
                                <td><%= fechaSolicitud%></td>
                                <td>
                                    <% if (archivo != null) {%>
                                    <a href="archivos/<%= archivo%>" target="_blank" class="btn btn-primary">
                                        <i class="fas fa-file-download"></i> Abrir PDF
                                    </a>
                                    <% } else { %>
                                    <!-- Botón deshabilitado si archivo es null -->
                                    <button class="btn btn-primary" disabled>
                                        <i class="fas fa-file-download"></i> Abrir PDF
                                    </button>
                                    <% }%>
                                </td>
                                <td><%= respuesta%></td>
                                <td><%= estado%></td>
                                <td class="text-center">
                                    <div class="acciones">
                                        <% if ("Sin revisar".equals(estado)) {%>
                                        <a href="#" title="Dar respuesta" class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#respuestaModal" data-idsolicitud="<%= idSolicitud%>" data-correousuario="<%= correoUsuario%>">
                                            <i class="bi bi-chat-right-text"></i> Dar respuesta
                                        </a>
                                        <% } else { %>
                                        <button class="btn btn-success btn-sm" disabled>
                                            <i class="bi bi-chat-right-text"></i> Dar respuesta
                                        </button>
                                        <% } %>
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
        <!-- Modal para dar respuesta -->
        <div class="modal fade" id="respuestaModal" tabindex="-1" aria-labelledby="respuestaModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="respuestaModalLabel">Responder Solicitud</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="SvRespuesta" method="POST" id="respuestaForm">
                            <div class="mb-3">
                                <label for="respuesta" class="form-label">Respuesta:</label>
                                <textarea class="form-control" id="respuesta" name="respuesta" rows="3" required></textarea>
                            </div>
                            <!-- Campo oculto para enviar el ID de la solicitud -->
                            <input type="hidden" id="idSolicitudInput" name="idSolicitud">
                            <!-- Campo oculto para enviar el correo del usuario -->
                            <input type="hidden" id="correoUsuarioInput" name="correoUsuario">
                            <!-- Campo oculto para cambiar el estado de la solicitud a "Revisado" -->
                            <input type="hidden" id="estadoInput" name="estado" value="Revisado">
                            <button type="submit" class="btn btn-primary">Enviar respuesta</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Capturar el evento de clic en el botón de respuesta
            $('.btn-success').click(function () {
                // Obtener los datos de la solicitud seleccionada
                var idSolicitud = $(this).data('idsolicitud');
                var correoUsuario = $(this).data('correousuario');

                // Poner el ID de la solicitud y el correo del usuario en los campos ocultos del formulario
                $('#idSolicitudInput').val(idSolicitud);
                $('#correoUsuarioInput').val(correoUsuario);
                
                // Mostrar el modal de respuesta
                $('#respuestaModal').modal('show');
            });
        </script>


    </section><!-- End Contact Section -->

</main><!-- End #main -->