<%
    String success = request.getParameter("success");
    if ("true".equals(success)) {
        %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            Usuario a�adido con �xito.
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
    Hubo un error al crear el perfil. La c�dula introducida ya est� registrada.
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