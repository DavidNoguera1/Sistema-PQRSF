<%@ page import="com.mycompany.sistemapqrsf.gestionarSistema" %> <!-- Corregido el nombre de la clase -->

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
                        <h2>Formulario de atencion</h2>
                        <p>Rellene los campos del formulario a continuacion y espere pacientemente la respuesta de los administradores. Recuerde iniciar sesion para enviar</p>
                    </div>
                </div>
            </div>
        </div>
    </div><!-- End Breadcrumbs -->

    <!-- ======= Contact Section ======= -->
    <section id="contact" class="contact">
        <div class="container" data-aos="fade-up">
            <div class="row gy-4 mt-4">
                <div class="col-lg-8 offset-lg-2"> <!-- Añadido el offset para centrar el formulario -->

                    <form action="SvSolicitud" method="post" role="form" enctype="multipart/form-data">

                        <!-- Campo de título de la solicitud -->
                        <div class="form-group mt-3">
                            <input type="text" class="form-control" name="titulo" id="titulo" placeholder="Título de la Solicitud" required>
                        </div>

                        <!-- Campo de mensaje de la solicitud -->
                        <div class="form-group mt-3">
                            <textarea class="form-control" name="mensaje" rows="5" placeholder="Mensaje de la Solicitud" required></textarea>
                        </div>

                        <!-- Campo de tipo de solicitud -->
                        <div class="form-group mt-3">
                            <select class="form-control" name="tipoSolicitud" id="tipoSolicitud" required>
                                <option value="" selected disabled>Seleccionar Tipo de Solicitud</option>
                                <% 
                                    // Crear una instancia de la clase gestionarSistema
                                    gestionarSistema gestionar = new gestionarSistema();
                                    // Importa las clases necesarias y realiza la conexión a la base de datos
                                    Connection conn = null;
                                    PreparedStatement pstmt = null;
                                    ResultSet rs = null;
        
                                    try {
                                        conn = gestionar.establecerConexion();
                                        String sql = "SELECT IdTipoSolicitud, tipo FROM TipoSolicitud";
                                        pstmt = conn.prepareStatement(sql);
                                        rs = pstmt.executeQuery();

                                        while (rs.next()) {
                                            int idTipoSolicitud = rs.getInt("IdTipoSolicitud");
                                            String nombre = rs.getString("tipo");
                                %>
                                <option value="<%= idTipoSolicitud %>"><%= nombre %></option>
                                <% 
                                        }
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    } finally {
                                        // Cierra la conexión y los recursos
                                        try {
                                            if (rs != null) rs.close();
                                            if (pstmt != null) pstmt.close();
                                            if (conn != null) conn.close();
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        }
                                    }
                                %>
                            </select>

                        </div>

                        <!-- Campo oculto para el ID del usuario obtenido de la sesión -->
                        <input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario") %>">
                        
                        <!-- Campo oculto para la fecha de la solicitud -->
                        <input type="hidden" name="fechaSolicitud" value="<%= java.time.LocalDateTime.now() %>">


                        <!-- Campo para subir archivo adjunto -->
                        <div class="form-group mt-3">
                            <label for="archivoAdjunto"></label>
                            <input type="file" class="form-control" name="archivoAdjunto" id="archivoAdjunto">
                        </div>

                        <div class="my-3"></div>
                        <!-- Botón para enviar la solicitud -->
                        <div class="text-center"><button type="submit">Enviar Solicitud</button></div>
                    </form>
                    <!-- Fin del Formulario de solicitud -->
                </div>
            </div>
        </div>


    </section><!-- End Contact Section -->

</main><!-- End #main -->

<%@include file= "templates/footer.jsp" %>