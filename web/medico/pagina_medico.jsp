
<%@page import="java.util.ArrayList"%>
<%@page import="rojas.model.Medico"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%    String msg = request.getParameter("msg");
%>
<%
    ArrayList<Medico> data = (ArrayList<Medico>) request.getAttribute("data");

    if (data == null) {
        data = new ArrayList();
    }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

        <title>Consulta Agenda del medico por cedula</title>
    </head>
    <body>
        <div class="container justify-content-center">
            <div class="row">
                <div class="col-lg-6 col-md-8 col-sm-10 mx-auto">
                    <h1 style="text-align: center;  padding: 20px ;">Consultar Agenda por Medico</h1>
                    <form method="post" action="MainApp?obj=main&action=verAgenda&ver=SI">
                        <label for="paciente">Seleccionar Medico:</label>
                        <select name="idMedico" id="idMedico" class="form-control">
                            <% for (Medico medicos : data) {%>
                            <option value="<%= medicos.getId()%>"><%=medicos.getCedula()%> - <%=medicos.getNombres()%> <%=medicos.getApelldios() %> </option>
                            <% } %>
                        </select>
                        <br/>                        
                        <div class="d-flex justify-content-center gap-2">
                            <button class="btn btn-success">Consultar Agenda</button>
                            <a href="index.jsp" class="btn btn-info">Volver</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%            if (msg != null && !msg.isEmpty()) {
        %>
        <script>
            alert("<%= msg%>");
        </script>
        <%
            }
        %>

    </body>
</html>
