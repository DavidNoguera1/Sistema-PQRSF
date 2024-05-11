<%-- 
    Document   : index
    Created on : 30 abr 2024, 18:36:57
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">


<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <title>Sistema PQRSF - Index</title>
        <meta content="" name="description">
        <meta content="" name="keywords">

        <!-- Favicons -->
        <link href="assets/img/favicon.png" rel="icon">
        <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

        <!-- Google Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,600;1,700&family=Poppins:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Inter:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet">

        <!-- Vendor CSS Files -->
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
        <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
        <link href="assets/vendor/aos/aos.css" rel="stylesheet">

        <!-- Template Main CSS File -->
        <link href="assets/css/main.css" rel="stylesheet">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="templates/styles.css">

        <!-- Bootstrap JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

        <!-- jQuery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>

        <!-- =======================================================
        * Template Name: Logis
        * Template URL: https://bootstrapmade.com/logis-bootstrap-logistics-website-template/
        * Updated: Mar 17 2024 with Bootstrap v5.3.3
        * Author: BootstrapMade.com
        * License: https://bootstrapmade.com/license/
        ======================================================== -->
    </head>



    <body>

        <!-- ======= Header ======= -->
        <header>
            <nav class="navbar navbar-dark bg-dark navbar-expand-lg">

                <a class="navbar-brand logo" href="index.jsp">
                    <h1>Atencion PQRSF</h1>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="bi bi-list mobile-nav-toggle mobile-nav-show"></i>
                    <i class="bi bi-x mobile-nav-toggle mobile-nav-hide d-none"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="index.jsp">Inicio</a>
                        </li>
                        
                        <li class="nav-item">
                            <a class="nav-link" href="formularioS.jsp">Formulario de Atencion</a>
                        </li>
                        <%-- Mostrar "Mis Solicitudes" solo si la sesi?n es de tipo "Usuario" --%>
                        <%
                            String rol = (String) session.getAttribute("rol");
                            if (rol != null && rol.equals("Usuario")) {
                        %>
                        <li class="nav-item">
                            <a class="nav-link" href="MisSolicitudes.jsp">Mis Solicitudes</a>
                        </li>
                        <% } %>
                        <%-- Mostrar "Todas las solicitudes" solo si la sesi?n es de tipo "Administrador" --%>
                        <%
                            if (rol != null && rol.equals("Admin")) {
                        %>
                        <li class="nav-item">
                            <a class="nav-link" href="Solicitudes.jsp">Todas las solicitudes</a>
                        </li>
                        <% } %>
                        <%-- Mostrar "Cerrar Sesion" solo si hay una sesi?n activa --%>
                        
                        <% if (session.getAttribute("rol") != null) { %>
                        
                        <li class="nav-item">
                            <a class="nav-link" href="perfil.jsp">Perfil</a>
                        </li>
                        
                        <li class="nav-item">
                            <a class="nav-link get-a-quote" href="SvLogin">Cerrar Sesion</a>
                        </li>
                        
                        <% } else { %>
                        <%-- Mostrar "Iniciar Sesion" y "Crear Usuario" solo si no hay una sesi?n activa --%>
                        <li class="nav-item">
                            <a class="nav-link get-a-quote" href="#" data-bs-toggle="modal" data-bs-target="#loginModal">Iniciar Sesion</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link get-a-quote" href="#" data-bs-toggle="modal" data-bs-target="#registerModal">Crear Usuario</a>
                        </li>
                        <% }%>

                    </ul>
                </div>

            </nav>


        </header>
        <!-- End Header -->

        <!-- Modal de Iniciar Sesion -->
        <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="loginModalLabel">Iniciar Sesion</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="SvLogin" method="post">
                            <!-- Cedula input -->
                            <div data-ds-input-init class="form-outline mb-4" required>
                                <input type="text" id="cedula" name="cedula" class="form-control" />
                                <label class="form-label" for="cedula">Cedula</label>
                            </div>

                            <!-- Contraseña input -->
                            <div data-ds-input-init class="form-outline mb-4" required>
                                <input type="password" id="contrasena" name="contrasena" class="form-control" />
                                <label class="form-label" for="contrasena">Contrasena</label>
                            </div>

                            <!-- Submit button -->
                            <button type="submit" class="btn btn-primary btn-block mb-4">Iniciar Sesion</button>

                            <!-- No registrado -->
                            <p class="text-center"> No estas registrado? <a href="#" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#registerModal">Crea tu usuario aqui</a></p>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <!-- Modal de Crear Usuario -->
        <div class="modal fade" id="registerModal" tabindex="-1" aria-labelledby="registerModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="registerModalLabel">Crear Usuario</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="SvRegistro" method="post">
                            <!-- Nombre input -->
                            <div class="form-outline mb-4">
                                <input type="text" id="nombreRegistro" name="nombre" class="form-control" required />
                                <label class="form-label" for="nombreRegistro">Nombre</label>
                            </div>

                            <!-- Apellido input -->
                            <div class="form-outline mb-4">
                                <input type="text" id="apellidoRegistro" name="apellido" class="form-control" required />
                                <label class="form-label" for="apellidoRegistro">Apellido</label>
                            </div>

                            <!-- Cedula input -->
                            <div class="form-outline mb-4">
                                <input type="text" id="cedulaRegistro" name="cedula" class="form-control" required />
                                <label class="form-label" for="cedulaRegistro">Cedula</label>
                            </div>

                            <!-- Correo input -->
                            <div class="form-outline mb-4">
                                <input type="email" id="correoRegistro" name="correo" class="form-control" required />
                                <label class="form-label" for="correoRegistro">Correo electronico</label>
                            </div>

                            <!-- Contrase?a input -->
                            <div class="form-outline mb-4">
                                <input type="password" id="contrasenaRegistro" name="contrasena" class="form-control" required />
                                <label class="form-label" for="contrasenaRegistro">Contrasena</label>
                            </div>

                            <!-- Rol select -->
                            <div class="form-outline mb-4">
                                <select class="form-select" id="rolRegistro" name="rol" required>
                                    <option value="" disabled selected>Seleccionar Rol</option>
                                    <option value="Admin">Administrador</option>
                                    <option value="Usuario">Usuario</option>
                                </select>
                                <label class="form-label" for="rolRegistro">Rol</label>
                            </div>

                            <!-- Submit button -->
                            <button type="submit" class="btn btn-primary btn-block mb-4">Registrarse</button>
                        </form>

                    </div>
                </div>
            </div>
        </div>
