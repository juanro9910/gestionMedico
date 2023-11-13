<%@page import="rojas.model.Medico"%>
<% String errorMessage = (String) request.getSession().getAttribute("error_message"); %>
<% if (errorMessage != null) {%>
<script>
    alert("<%= errorMessage%>");
</script>
<% request.getSession().removeAttribute("error_message"); // Limpiar el mensaje de error después de mostrarlo %>
<% } %>
<%
    Medico med = (Medico) request.getAttribute("medico");

    if (med == null) {
        response.sendRedirect("index.jsp");
    } else {
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <title>Editar Medico</title>
    </head>
    <body>
        <div class="container justify-content-center">
            <div class="row">
                <div class="col-lg-4 col-md-8 col-sm-10 mx-auto">

                    <h1 style="text-align: center">Editar Medico</h1>
                    <h2 style="text-align: center"> <%=med.getNombres()%> </h2>
                    <form method="post" action="MainApp?obj=main&action=updateMedico&idMedico=<%=med.getId()%>">
                        <input class="form-control mt-2" name="cedulaMedico" type="number" 
                               placeholder="Cedula Medico" readonly="readonly"  required
                               value="<%= med.getCedula()%>"/>
                        <br/>
                        <input class="form-control" name="nombresMedico" type="text" required
                               placeholder="Nombres del Medico" 
                               value="<%= med.getNombres()%>"  />
                        <br/>
                        <input class="form-control" name="apellidosMedico" type="text" required
                               placeholder="Apellidos del Medico"
                               value="<%= med.getApelldios() %>" />
                        <br/>
                        <label style="padding-bottom: 10px">Especialidad: </label>
                        <select class="form-select" aria-label="Default select example" name="especialidad" id="especialidad">
                            <option value="<%= med.getEspecialidad() %>" selected  hidden> <%= med.getEspecialidad() %></option>
                            <option value="GENERAL">GENERAL</option>
                            <option value="PEDIATRA">PEDIATRA</option>
                            <option value="ONCOLOGO">ONCOLOGO</option>
                            <option value="ODONTOLOGIA">ODONTOLOGIA</option>
                        </select>
                        <br/>
                        <div class="d-flex justify-content-center gap-2">
                            <button title="ACTUALIZAR" class="btn btn-success">
                               <i class="fa-solid fa-user-pen"></i>
                            </button>
                            <a title="VOLVER" class="btn btn-primary" href="MainApp?obj=main&action=indexAdminisMed">
                                <i class="fa-solid fa-arrow-left"></i>
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
<%
    }
%>
