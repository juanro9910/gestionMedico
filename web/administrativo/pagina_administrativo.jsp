<%@page import="rojas.model.Paciente"%>
<%@page import="rojas.model.Medico"%>
<%@page import="java.util.ArrayList"%>
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

    ArrayList<Medico> data = (ArrayList<Medico>) request.getAttribute("data");
    ArrayList<Paciente> dataPaciente = (ArrayList<Paciente>) request.getAttribute("dataPaciente");

    if (data == null || dataPaciente == null) {
        data = new ArrayList();
        dataPaciente = new ArrayList();
    }

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <title>Gestión Medicos</title>
    </head>
    <body>        
        <div class="container">
            <div class="">
                <h1 style="text-align: center; padding-top: 20px">Gestión de Medicos</h1>
                <a title="Volver" class="btn btn-primary" href="index.jsp">
                    <i class="fa-solid fa-arrow-left"></i> Volver
                </a>
                <a title="Agregar Medico" class="btn btn-success" data-toggle="modal" data-target="#agregarMedicoModal">
                    <i class="fa-solid fa-address-card"></i> Agregar medico
                </a>
                <a title="Agregar Paciente" class="btn btn-success"  data-toggle="modal" data-target="#agregarPacienteModal">
                    <i class="fa-solid fa-hospital-user"></i> Agregar Paciente
                </a>
                <a title="Lista de Paciente" class="btn btn-success"  data-toggle="modal" data-target="#listaPacientesModal">
                    <i class="fa-solid fa-list"></i> Lista de pacientes
                </a>
                <br/>                
            </div>
            <%                if (data.size() == 0) {
            %>
            <div class="row mt-2">
                <h3>No existen Medicos</h3>
            </div>
            <%
            } else {
            %>

            <table class="table table-striped mt-2 table-bordered">
                <thead>
                    <tr>
                        <th class="col-md-1" style="text-align: center;">Id</th>
                        <th class="col-md-1" style="text-align: center;">Cedula</th>
                        <th class="col-md-3" style="text-align: center;">Nombres</th>
                        <th class="col-md-3" style="text-align: center;">Apellidos</th>
                        <th class="col-md-2" style="text-align: center;">Especialidad</th>
                        <th class="col-md-2" style="text-align: center;"> Acciones </th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Medico medico : data) {
                    %>
                    <tr>
                        <td style="text-align: center;"><%=medico.getId()%></td>
                        <td style="text-align: center;"><%=medico.getCedula()%></td>
                        <td style="text-align: center;"><%=medico.getNombres()%></td>
                        <td style="text-align: center;"><%=medico.getApelldios()%></td>
                        <td style="text-align: center;"><%=medico.getEspecialidad()%></td>
                        <td style="text-align: center;">                           
                            <a title="Ver Agenda" class="btn btn-primary" href="MainApp?obj=main&action=verAgenda&idMedico=<%= medico.getId()%>">
                                <i class="fa-solid fa-calendar-days"></i>
                            </a>
                            <a title="Editar Medico" class="btn btn-warning" data-toggle="modal" data-target="#editMedicoModal<%= medico.getId()%>">
                                <i class="fa-solid fa-pencil"></i>
                            </a>
                            <a class="btn btn-danger" data-toggle="modal" data-target="#confirmDeleteModal<%= medico.getId()%>"
                               title="Eliminar Medico">
                                <i class="fa-solid fa-trash"></i>
                            </a>
                        </td>
                    </tr> 
                    <!-- MOodal para editar el medico -->
                <div class="modal fade" id="editMedicoModal<%= medico.getId()%>" tabindex="-1" role="dialog" aria-labelledby="editMedicoModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editMedicoModalLabel">Editar medico <%=medico.getNombres()%> </h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form action="MainApp?obj=main&action=updateMedico&idMedico=<%=medico.getId()%>" method="post" >
                                    <input class="form-control mt-2" name="cedulaMedico" type="number" 
                                           placeholder="Cedula Medico" readonly="readonly"  required
                                           value="<%= medico.getCedula()%>"/>
                                    <br/>
                                    <input class="form-control" name="nombresMedico" type="text" required
                                           placeholder="Nombres del Medico" 
                                           value="<%= medico.getNombres()%>"  />
                                    <br/>
                                    <input class="form-control" name="apellidosMedico" type="text" required
                                           placeholder="Apellidos del Medico"
                                           value="<%= medico.getApelldios()%>" />
                                    <br/>
                                    <label style="padding-bottom: 10px">Especialidad: </label>
                                    <select class="form-select" aria-label="Default select example" name="especialidad" id="especialidad">
                                        <option value="<%= medico.getEspecialidad()%>" selected  hidden> <%= medico.getEspecialidad()%></option>
                                        <option value="GENERAL">GENERAL</option>
                                        <option value="PEDIATRA">PEDIATRA</option>
                                        <option value="ONCOLOGO">ONCOLOGO</option>
                                        <option value="ODONTOLOGIA">ODONTOLOGIA</option>
                                    </select>
                                    <br/>

                                    <div class="d-flex justify-content-center gap-2">
                                        <button class="btn btn-success">
                                            <i class="fa-solid fa-check"></i> Actualizar
                                        </button>
                                        <a class="btn btn-danger" data-dismiss="modal">
                                            <i class="fa-solid fa-xmark"></i> Cancelar
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal confirmar el Delete-->
                <div class="modal fade" id="confirmDeleteModal<%= medico.getId()%>" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmDeleteModalLabel">Confirmación de Borrado</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                ¿Está seguro de que desea borrar este registro?
                            </div>
                            <div class="modal-footer">
                                <a  class="btn btn-danger" href="MainApp?obj=main&action=deleteMedico&idMedico=<%= medico.getId()%>">Borrar</a>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
                </tbody>
            </table>
            <%
                }
            %>

            <!-- Modal para agregar medico -->
            <div class="modal fade" id="agregarMedicoModal" tabindex="-1" role="dialog" aria-labelledby="agregarMedicoModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="agregarMedicoModalLabel">Agregar Medico</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form method="post" action="MainApp?obj=main&action=saveMedico">
                                <input class="form-control mt-2" name="cedulaMedico" type="number" required placeholder="Cedula Medico" />
                                <br />
                                <input class="form-control" name="nombresMedico" type="text" required placeholder="Nombres del Medico" />
                                <br />
                                <input class="form-control" name="apellidosMedico" type="text" required placeholder="Apellidos del Medico" />
                                <br />
                                <label style="padding-bottom: 10px">Especialidad: </label>
                                <select class="form-select" aria-label="Default select example" name="especialidad" id="especialidad">
                                    <option value="GENERAL">GENERAL</option>
                                    <option value="PEDIATRA">PEDIATRA</option>
                                    <option value="ONCOLOGO">ONCOLOGO</option>
                                    <option value="ODONTOLOGIA">ODONTOLOGIA</option>
                                </select>
                                <br />
                                <div class="d-flex justify-content-center gap-2">
                                    <button class="btn btn-success">
                                        <i class="fa-solid fa-check"></i> Agregar
                                    </button>
                                    <a class="btn btn-danger" data-dismiss="modal">
                                        <i class="fa-solid fa-xmark"></i> Cancelar
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal para agregar paciente -->
            <div class="modal fade" id="agregarPacienteModal" tabindex="-1" role="dialog" aria-labelledby="agregarPacienteModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="agregarPacienteModalLabel">Agregar Paciente</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form method="post" action="MainApp?obj=main&action=savePaciente">
                                <input class="form-control mt-2" name="cedulaPaciente" type="number" required placeholder="Cedula Paciente" />
                                <br />
                                <input class="form-control" name="nombresPaciente" type="text" required placeholder="Nombres del Paciente" />
                                <br />
                                <input class="form-control" name="apellidosPaciente" type="text" required placeholder="Apellidos del Paciente" />
                                <br />                                
                                <div class="d-flex justify-content-center gap-2">
                                    <button class="btn btn-success">
                                        <i class="fa-solid fa-check"></i> Agregar
                                    </button>
                                    <a class="btn btn-danger" data-dismiss="modal">
                                        <i class="fa-solid fa-xmark"></i> Cancelar
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal de Lista de Pacientes -->
            <div class="modal fade" id="listaPacientesModal" tabindex="-1" role="dialog" aria-labelledby="listaPacientesModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="listaPacientesModalLabel">Lista de Pacientes</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <!-- Tabla de Pacientes -->
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th style="text-align: center;">ID</th>
                                        <th style="text-align: center;">Cédula</th>
                                        <th style="text-align: center;">Nombres</th>
                                        <th style="text-align: center;">Apellidos</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (Paciente pac : dataPaciente) {
                                    %>
                                    <tr>
                                        <td style="text-align: center;"><%=pac.getId()%></td>
                                        <td style="text-align: center;"><%=pac.getCedula()%></td>
                                        <td style="text-align: center;"><%=pac.getNombres()%></td>
                                        <td style="text-align: center;"><%=pac.getApellidos()%></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
