

<%@page import="rojas.model.Agenda"%>
<%@page import="rojas.model.Paciente"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Mensaje de error -->
<% String errorMessage = (String) request.getSession().getAttribute("error_message"); %>
<% if (errorMessage != null) {%>
<script>
    alert("<%= errorMessage%>");
</script>
<% request.getSession().removeAttribute("error_message"); // Limpiar el mensaje de error después de mostrarlo %>
<% } %>
<!-- Fin Mensaje de error -->
<%

    Paciente paciente = (Paciente) request.getAttribute("Paciente");
    Agenda agendapaciente = (Agenda) request.getAttribute("Pagenda");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <title>Agenda paciente</title>
    </head>
    <body>
        <div class="container mt-2 col-md-4">
            <h1 style="text-align: center">Información del paciente </h1>
            <div class="row" style ="padding: 10px">            
                <table class="table table-striped " border="1">
                    <tbody>
                        <tr>
                            <td>Cedula</td>
                            <td>
                                <%=paciente.getCedula()%>
                            </td>
                        </tr>
                        <tr>
                            <td>Nombres </td>
                            <td>
                                <%=paciente.getNombres()%>
                            </td>
                        </tr>
                        <tr>
                            <td>Apellidos </td>
                            <td>
                                <%=paciente.getApellidos()%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                    <center>
                        <a title="Volver" class="btn btn-primary" href="MainApp?obj=main&action=indexPaciente">
                            <i class="fa-solid fa-arrow-left"></i> Volver
                        </a>
                    </center>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
                            
                            
         <div class="container">
            <h1 style="text-align: center">Agendas del Paciente</h1>
            <div class="row">
                <table class="table table-striped mt-2 table-bordered">
                    <thead>
                        <tr>
                            <th class="col-md-1" style="text-align: center;">Codigo</th>
                            <th class="col-md-2" style="text-align: center;">Fecha</th>
                            <th class="col-md-1" style="text-align: center;">Hora</th>
                            <th class="col-md-3" style="text-align: center;">Descripción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="text-align: center;">
                                <%=agendapaciente.getCodigo()%>
                            </td>
                            <td style="text-align: center;">
                                <%=agendapaciente.getDia()%> / <%=agendapaciente.getMes()%> /  <%=agendapaciente.getAnho()%>
                            </td>                        
                            <td style="text-align: center;">
                                <%=agendapaciente.getHora()%>:<%= (agendapaciente.getMinuto() == 0) ? "00" : agendapaciente.getMinuto() %>
                            </td>
                            <td style="text-align: center;">
                                <%=agendapaciente.getDescripcion()%>
                            </td>
                        </tr>

                    </tbody>
                </table> 
            </div>
            </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
