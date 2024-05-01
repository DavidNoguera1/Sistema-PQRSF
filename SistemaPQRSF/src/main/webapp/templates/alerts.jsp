<%
    String success = request.getParameter("success");
    if ("true".equals(success)) {
        %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            Usuario añadido con éxito.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%
            }
        %>
        
        
 <%
    String error = request.getParameter("error");
    if ("true".equals(error)) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    Hubo un error al crear el perfil. La cédula introducida ya está registrada.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
    }
%>

 <%
    String errorP = request.getParameter("errorP");
    if ("true".equals(errorP)) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    Hubo un error al iniciar sesion intentelo nuevamente.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
    }
%>