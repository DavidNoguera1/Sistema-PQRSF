<%@include file= "templates/header.jsp" %>

<!-- ======= Hero Section ======= -->
<section id="hero" class="hero d-flex align-items-center">
    <div class="container">
        <div class="row gy-4 d-flex justify-content-between">
            <%-- Mostrar el mensaje de bienvenida --%>
            <% String nombreUsuario = (String) session.getAttribute("nombre");
                if (nombreUsuario != null) {%>
            <h2 class="title text-center">Estos son tus datos actuales <%= nombreUsuario%> :)</h2>
            <% } else { %>
            <h2 class="title text-center">Aqui podrias editar tus datos :)</h2>
            <% }%>
            <h2 class="title text-center" data-aos="fade-up"> Editalos o puedes eliminar tu perfil si lo deseas</h2>
        </div>
    </div>
</section><!-- End Hero Section -->


<section>
    <div class="container" data-aos="fade-up">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card bg-dark text-white" style="background-color: #0C0E67;">
                    <div class="card-body">
                        <form action="SvEditarUsuario" method="post">
                            <div class="row">
                                <input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario")%>">

                                <!-- Nombre input -->
                                <div class="col-md-6 form-outline mb-4">
                                    <input type="text" id="nombreRegistro" name="nombre" class="form-control" value="${nombre}" required />
                                    <label class="form-label" for="nombreRegistro">Nombre</label>
                                </div>

                                <!-- Apellido input -->
                                <div class="col-md-6 form-outline mb-4">
                                    <input type="text" id="apellidoRegistro" name="apellido" class="form-control" value="${apellido}" required />
                                    <label class="form-label" for="apellidoRegistro">Apellido</label>
                                </div>

                                <!-- Contraseña input -->
                                <div class="col-md-6 form-outline mb-4">
                                    <input type="password" id="contrasenaRegistro" name="contrasena" class="form-control" value="${contrasena}" required />
                                    <label class="form-label" for="contrasenaRegistro">Contraseña</label>
                                </div>

                                <!-- Correo input -->
                                <div class="col-md-6 form-outline mb-4">
                                    <input type="email" id="correoRegistro" name="correo" class="form-control" value="${correo}" required />
                                    <label class="form-label" for="correoRegistro">Correo electrónico</label>
                                </div>

                                <!-- Submit button -->
                                <div class="col-md-6">
                                    <button type="submit" class="btn btn-primary btn-block mb-4">Guardar Cambios</button>
                                </div>
                                
                                <div class="col-md-6">
                                <button type="button" class="btn btn-danger btn-block mb-4" onclick="confirmarEliminarUsuario()">Eliminar Usuario</button>
                                </div>
                                
                                <!-- Cédula input -->
                                <div class="col-md-6 form-outline mb-4">
                                    <input type="hidden" id="cedulaRegistro" name="cedula" class="form-control" value="${cedula}" required />
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section><!-- End Hero Section -->

<script>
function confirmarEliminarUsuario() {
    var idUsuario = '<%= request.getSession().getAttribute("idUsuario") %>';
    if (confirm("Estás seguro de borrar tu usuario (Las PQRSF hechas también se borrarán)")) {
        $.ajax({
            url: 'SvRegistro',
            type: 'GET',
            data: {
                idUsuario: idUsuario
            },
            success: function(response) {
                alert(response);
                location.reload();
            }
        });
    }
}
</script>

<main id="main"><!-- Start #main -->

    <!-- ======= About Us Section ======= -->
    <section id="about" class="about pt-0">

    </section><!-- End About Us Section -->


</main><!-- End #main -->


<%@include file= "templates/footer.jsp" %>