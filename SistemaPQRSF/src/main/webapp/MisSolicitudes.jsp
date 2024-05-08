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
                        <h2>Estas son sus solicitudes</h2>
                        <p>Observe su informaci�n</p>
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
                    <table id="solicitudesTable" class="table table-bordered table-dark " >
                        <thead>
                            <tr>
                                <th>T�tulo</th>
                                <th>Mensaje</th>
                                <th>Tipo de Solicitud</th>
                                <th>Fecha de Solicitud</th>
                                <th>Archivo</th>
                                <th>Respuesta</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                gestionarSistema gestionar = new gestionarSistema();
                                // Obtain the user ID from the session
                                String idUsuarioStr = (String) session.getAttribute("idUsuario");
                                int idUsuario = Integer.parseInt(idUsuarioStr);
                                // Import the necessary classes and establish the database connection
                                Connection conn = null;
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;

                                try {
                                    conn = gestionar.establecerConexion();

                                    // Update the SQL query to filter by idUsuario
                                    String sql = "SELECT IdSolicitud, Titulo, Mensaje, tipo, Fecha, RutaArchivo, Respuesta, Estado "
                                            + "FROM Solicitudes "
                                            + "INNER JOIN TipoSolicitud ON Solicitudes.IdTipoSolicitud = TipoSolicitud.IdTipoSolicitud "
                                            + "WHERE IdUsuario = ? ORDER BY Fecha DESC";

                                    pstmt = conn.prepareStatement(sql);
                                    pstmt.setInt(1, idUsuario);
                                    rs = pstmt.executeQuery();

                                    // Iterate through the result set and display each inquiry in the table
                                    while (rs.next()) {
                                        String IdSolicitud = rs.getString("IdSolicitud");
                                        String titulo = rs.getString("Titulo");
                                        String mensaje = rs.getString("Mensaje");
                                        String tipoSolicitud = rs.getString("tipo");
                                        String fechaSolicitud = rs.getString("Fecha");
                                        String archivo = rs.getString("RutaArchivo");
                                        String respuesta = rs.getString("Respuesta");
                                        String estado = rs.getString("Estado");
                            %>
                            <tr>
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
                                    <!-- Bot�n deshabilitado si archivo es null -->
                                    <button class="btn btn-primary" disabled>
                                        <i class="fas fa-file-download"></i> Abrir PDF
                                    </button>
                                    <% }%>
                                </td>

                                <td><%= respuesta%></td>
                                <td><%= estado%></td>
                                <td class="text-center">
                                    <!-- Acci�n con icono de bootstrap -->
                                    <div class="acciones">
                                        <a href="#" title="Editar" class="btn btn-success btn-sm">
                                            <i class="fas fa-edit"></i> 
                                        </a>
                                        <a href="#" title="Eliminar" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#confirmacionEliminarModal" onclick="setearIdSolicitud(<%= IdSolicitud %>);">
                                            <i class="fas fa-trash"></i> 
                                        </a>

                                    </div>
                                </td>
                            </tr>
                            <%
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } finally {
                                    // Close the connection and resources
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
        
        <div class="modal fade" id="confirmacionEliminarModal" tabindex="-1" aria-labelledby="confirmacionEliminarModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmacionEliminarModalLabel">Confirmaci�n de Eliminaci�n</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        �Est� seguro de que desea eliminar esta solicitud?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <form id="eliminarSolicitudForm" action="SvEliminarSolicitud" method="post">
                            <input type="hidden" id="idSolicitudEliminar" name="idSolicitud">
                            <button type="submit" class="btn btn-danger">Eliminar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </section><!-- End Contact Section -->

</main><!-- End #main -->

<script>
    function setearIdSolicitud(idSolicitud) {
        document.getElementById("idSolicitudEliminar").value = idSolicitud;
    }
</script>