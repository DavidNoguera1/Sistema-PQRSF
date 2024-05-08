
<!-- Esto es para eliminar solicitudes -->

<div class="modal fade" id="confirmacionEliminarModal" tabindex="-1" aria-labelledby="confirmacionEliminarModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmacionEliminarModalLabel">Confirmación de Eliminación</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                ¿Está seguro de que desea eliminar esta solicitud?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <form id="eliminarSolicitudForm" action="SvSolicitud" method="Get">
                    <input type="hidden" id="idSolicitudEliminar" name="idSolicitud">
                    <button type="submit" class="btn btn-danger">Eliminar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function setearIdSolicitud(idSolicitud) {
        document.getElementById("idSolicitudEliminar").value = idSolicitud;
    }
</script>


<!-- Esto es para editar solicitudes -->

<div class="modal fade modal-dark" id="editModal" tabindex="-1" aria-labelledby="editModal" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content bg-dark text-light">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Edición de Solicitud</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="SvEditar" method="POST" id="editForm" enctype="multipart/form-data">
                            <div class="mb-3" hidden>
                                <label for="idSolicitud" class="col-form-label">ID Solicitud:</label>
                                <input type="text" class="form-control" id="idSolicitud" name="idSolicitud" placeholder="ID de la solicitud" readonly required>
                            </div>
                            <div class="mb-3">
                                <label for="titulo" class="col-form-label">Título:</label>
                                <input type="text" class="form-control" id="titulo" name="titulo" placeholder="Título de la solicitud" required>
                            </div>
                            <div class="mb-3">
                                <label for="tipoSolicitud" class="col-form-label">Tipo de Solicitud:</label>
                                <select class="form-control" name="tipoSolicitud" id="tipoSolicitud" required>
                                    <option value="" selected disabled>Seleccionar Tipo de Solicitud</option>
                                    <%
                                       
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
                                                if (rs!= null) rs.close();
                                                if (pstmt!= null) pstmt.close();
                                                if (conn!= null) conn.close();
                                            } catch (SQLException e) {
                                                e.printStackTrace();
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="mensaje" class="col-form-label">Mensaje:</label>
                                <textarea class="form-control" id="mensaje" name="mensaje" rows="3" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="archivo" class="col-form-label">Archivo:</label>
                                <input type="text" class="form-control" id="archivo_nombre" readonly>
                                <input type="file" class="form-control" id="archivo" name="archivo">
                                <small class="text-muted">Si desea cambiar el archivo, seleccione uno nuevo.</small>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>


            <script>
                $('#editModal').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget);
                    var idSolicitud = button.data('idsolicitud');
                    var titulo = button.data('titulo');
                    var tipoSolicitud = button.data('idtiposolicitud');
                    var mensaje = button.data('mensaje');
                    var archivo = button.data('rutaarchivo');

                    // Establecer valores en los campos del formulario
                    var modal = $(this);
                    modal.find('#idSolicitud').val(idSolicitud);
                    modal.find('#titulo').val(titulo);
                    modal.find('#mensaje').val(mensaje);
                    modal.find('#archivo_nombre').val(archivo);
                    modal.find('#idSolicitud').val(idSolicitud);

                    // Establecer el tipo de solicitud actual como seleccionado
                    modal.find('#tipoSolicitud option').each(function () {
                        if ($(this).text() === tipoSolicitud) {
                            $(this).prop('selected', true);
                        }
                    });

                });
            </script>
    
<!-- Esto es para responder solicitudes -->