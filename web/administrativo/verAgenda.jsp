<%@page import="rojas.model.Paciente"%>
<%@page import="rojas.model.Agenda"%>
<%@page import="rojas.model.Medico"%>
<%@page import="java.util.ArrayList"%>
<%

    Medico medico = (Medico) request.getAttribute("medico");
    ArrayList<Paciente> pacientes = (ArrayList<Paciente>) request.getAttribute("dataPaciente");
    if (pacientes == null) {
        pacientes = new ArrayList();
    }

    if (medico == null) {
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
        <title>Ver Agenda Medico</title>
    </head>
    <body>        


        <div class="container mt-2 col-md-4">
            <h1 style="text-align: center">Gestion del Medico </h1>
            <h2 style="text-align: center"> <%=medico.getNombres()%> </h2>
            <div class="row" style ="padding: 10px">            
                <table class="table table-striped " border="1">
                    <tbody>
                        <tr>
                            <td>Id</td>
                            <td>
                                <%=medico.getId()%>
                            </td>
                        </tr>
                        <tr>
                            <td>Cedula</td>
                            <td>
                                <%=medico.getCedula()%>
                            </td>
                        </tr>
                        <tr>
                            <td>Nombres </td>
                            <td>
                                <%=medico.getNombres()%>
                            </td>
                        </tr>
                        <tr>
                            <td>Apellidos </td>
                            <td>
                                <%=medico.getApelldios()%>
                            </td>
                        </tr>
                        <tr>
                            <td> Especialidad </td>
                            <td>
                                <%=medico.getEspecialidad()%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                    <center>
                        <form action="index.jsp">
                            <a title="Volver" class="btn btn-primary" href="MainApp?obj=main&action=indexAdminisMed">
                                <i class="fa-solid fa-arrow-left"></i>
                            </a>                           
                            <a title="Agregar Agenda" class="btn btn-success" data-toggle="modal" data-target="#agregarAgendaModal" >
                                <i class="fa-solid fa-calendar fa-flip"></i>
                            </a>
                        </form>
                    </center>
                    </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
                    <!-- Modal para agregar agenda href="MainApp?obj=main&action=aggAgenda&idMedico=<%=medico.getId()%>"-->
        <div class="modal fade" id="agregarAgendaModal" tabindex="-1" role="dialog" aria-labelledby="agregarAgendaModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="agregarAgendaModalLabel">Agregar Agenda</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="MainApp?obj=main&action=addAgendaMedico&idMedico=<%=medico.getId()%>" method="post">
                            <div class="row">
                                <div class="col-2">
                                    <label for="dia">Día:</label>
                                    <select name="dia" id="dia" class="form-control">
                                        <% for (int i = 1; i <= 31; i++) {%>
                                        <option value="<%= i%>"><%= i%></option>
                                        <% } %>
                                    </select>
                                </div>

                                <div class="col-2">
                                    <label for="mes">Mes:</label>
                                    <select name="mes" id="mes" class="form-control">
                                        <% for (int i = 1; i <= 12; i++) {%>
                                        <option value="<%= i%>"><%= i%></option>
                                        <% } %>
                                    </select>
                                </div>

                                <div class="col-3">
                                    <label for="año">Año:</label>
                                    <select name="año" id="año" class="form-control">
                                        <% for (int i = 2023; i <= 2030; i++) {%>
                                        <option value="<%= i%>"><%= i%></option>
                                        <% } %>
                                    </select>
                                </div>

                                <div class="col-2">
                                    <label for="hora">Hora:</label>
                                    <select name="hora" id="hora" class="form-control">
                                        <% for (int i = 6; i <= 18; i++) {%>
                                        <option value="<%= i%>"><%= i%></option>
                                        <% } %>
                                    </select>
                                </div>

                                <div class="col-2">
                                    <label for="minuto">Minuto:</label>
                                    <select name="minuto" id="minuto" class="form-control">
                                        <option value="00">00</option>
                                        <option value="30">30</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="descripcion">Descripción corta:</label>
                                <input type="text" name="descripcion" id="descripcion" class="form-control">
                            </div>

                            <div class="form-group">
                                <label for="paciente">Seleccionar Paciente:</label>
                                <select name="paciente" id="paciente" class="form-control">
                                    <% for (Paciente paciente : pacientes) {%>
                                    <option value="<%= paciente.getId()%>"><%=paciente.getCedula()%> - <%=paciente.getNombres()%> <%=paciente.getApellidos()%> </option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="row mt-3">
                                <div class="col-12 text-center">
                                    <button class="btn btn-success mx-2">
                                        <i class="fa-solid fa-check"></i> Agregar
                                    </button>
                                    <a class="btn btn-danger mx-2" data-dismiss="modal">
                                        <i class="fa-solid fa-xmark"></i> Cancelar
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>                      

        <!-- AQUI VA A IR LA PARTE DE AGREGAR AGENDA -->
        <div class="container">
            <%
                if (medico.getAgenda().size() == 0) {
                    out.print("<h2 style=\"text-align: center\">No tiene Agenda</h2>");
                } else {
            %>
            <h1 style="text-align: center">Agendas del Medico</h1>
            <div class="row">
                <table class="table table-striped mt-2 table-bordered">
                    <thead>
                        <tr>
                            <th class="col-md-1" style="text-align: center;">Codigo</th>
                            <th class="col-md-2" style="text-align: center;">Fecha</th>
                            <th class="col-md-1" style="text-align: center;">Hora</th>
                            <th class="col-md-3" style="text-align: center;">Descripción</th>
                            <th class="col-md-3" style="text-align: center;">Paciente</th>
                            <th class="col-md-1" style="text-align: center;"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Agenda agenda : medico.getAgenda()) {
                        %>
                        <tr>
                            <td style="text-align: center;">
                                <%=agenda.getCodigo()%>
                            </td>
                            <td style="text-align: center;">
                                <%=agenda.getDia()%> / <%=agenda.getMes()%> /  <%=agenda.getAnho()%>
                            </td>                        
                            <td style="text-align: center;">
                                <%=agenda.getHora()%>:<%=agenda.getMinuto()%>
                            </td>
                            <td style="text-align: center;">
                                <%=agenda.getDescripcion()%>
                            </td>
                            <td style="text-align: center;">
                                <%=agenda.getPaciente().getCedula()%> - <%=agenda.getPaciente().getNombres()%> <%=agenda.getPaciente().getApellidos()%>
                            </td>
                            <td style="text-align: center;">
                                <a title="Borrar" class="btn btn-danger" href="saveAgenda.jsp?codigoAgenda=<%=agenda.getCodigo()%>&codigo=<%=medico.getId()%>&action=del">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>

                        <%
                            }
                        %>

                    </tbody>
                </table> 
            </div>
            <%
                    }
                }
            %>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>