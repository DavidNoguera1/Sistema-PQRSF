<%@include file= "templates/header.jsp" %>




<!-- ======= Hero Section ======= -->
<section id="hero" class="hero d-flex align-items-center">
    <div class="container">
        <div class="row gy-4 d-flex justify-content-between">
            <%-- Mostrar el mensaje de bienvenida --%>
            <% String nombreUsuario = (String) session.getAttribute("nombre");
            if (nombreUsuario != null) { %>
            <h2 class="title">Bienvenido <%= nombreUsuario %> :)</h2>
            <% } else { %>
            <h2 class="title">Bienvenido Usuario :)</h2>
            <% } %>

            <div class="col-lg-6 order-2 order-lg-1 d-flex flex-column justify-content-center">
                <h2 data-aos="fade-up">Tus solicitudes nos ayudan a mejorar</h2>
                <p data-aos="fade-up" data-aos-delay="100">No dudes en dejar una o varias PQRSF (Preguntas Quejas Reclamos Sugerencias Felicitaciones) uno de nuestros administradores le dara respuestas tan pronto como sea posible ;)</p>

                <a class="btn btn-primary mb-3" data-aos="fade-up" data-aos-delay="200" href="formularioS.jsp">Enviar solicitud</a>



                <div class="row gy-4" data-aos="fade-up" data-aos-delay="400">


                    <div class="col-lg-3 col-6">
                        <div class="stats-item text-center w-100 h-100">
                            <span data-purecounter-start="0" data-purecounter-end="1453" data-purecounter-duration="1" class="purecounter"></span>
                            <p>Usuarios</p>
                        </div>
                    </div><!-- End Stats Item -->

                    <div class="col-lg-3 col-6">
                        <div class="stats-item text-center w-100 h-100">
                            <span data-purecounter-start="0" data-purecounter-end="32" data-purecounter-duration="1" class="purecounter"></span>
                            <p>Solicitudes atendidas</p>
                        </div>
                    </div><!-- End Stats Item -->

                </div>
            </div>

            <div class="col-lg-5 order-1 order-lg-2 hero-img" data-aos="zoom-out">
                <img src="assets/img/hero-img.svg" class="img-fluid mb-3 mb-lg-0" alt="">
            </div>

        </div>
    </div>
</section><!-- End Hero Section -->


<main id="main"><!-- Start #main -->


    <section>
        <%@include file= "templates/alerts.jsp" %>   
    </section>

    <!-- ======= About Us Section ======= -->
    <section id="about" class="about pt-0">
        <div class="container" data-aos="fade-up">

            <div class="row gy-4">
                <div class="col-lg-6 position-relative align-self-start order-lg-last order-first">
                    <img src="assets/img/imagen.jpg" class="img-fluid" alt="">
                    <a href="https://www.youtube.com/watch?v=VdBU-D7dDXg&pp=ygUpYXRlbmNpb24gYWwgY2xpZW50ZSBlbiBsaW5lYSBwcmVzZW50YWNpb24%3D" class="glightbox play-btn"></a>
                </div>
                <div class="col-lg-6 content order-last  order-lg-first">
                    <h3>¿Como funcionan las solicitudes?</h3>
                    <p>
                        A continuacion te mencionamos en manera resumida como funcionan las solicitudes:
                    </p>
                    <ul>
                        <li data-aos="fade-up" data-aos-delay="100">
                            <i class="bi bi-box2-fill"></i>
                            <div>
                                <h5>Rellena los campos del formulario</h5>
                                <p>El Archivo es opcional y tus datos como nombre y correo se enviaran automaticamente con tu login</p>
                            </div>
                        </li>
                        <li data-aos="fade-up" data-aos-delay="200">
                            <i class="bi bi-fullscreen-exit"></i>
                            <div>
                                <h5>Ten algo de paciencia</h5>
                                <p>Un administrador te dara una respuesta a tu solicitud tampronto como sea posible en un rango de 1-3 dias</p>
                            </div>
                        </li>
                        <li data-aos="fade-up" data-aos-delay="300">
                            <i class="bi bi-broadcast"></i>
                            <div>
                                <h5>Visualiza la respuesta</h5>
                                <p>Una vez tu solicitud fue atentida su estado sera "Revisado" y en la seccion "Respuesta" tendras un mensaje enviado por el administrador</p>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>

        </div>
    </section><!-- End About Us Section -->


</main><!-- End #main -->

<%@include file= "templates/footer.jsp" %>      