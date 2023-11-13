
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%    String msg = request.getParameter("msg");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

        <title>Consulta paciente por cedula</title>
    </head>
    <body>
        <div class="container justify-content-center">
            <div class="row">
                <div class="col-lg-6 col-md-8 col-sm-10 mx-auto">
                    <h1 style="text-align: center;  padding: 20px ;">Consultar por Cedula</h1>
                    <form method="post" action="MainApp.jsp?obj=paciente&action=consultarPaciente">
                        <input class="form-control mt-2 px-2" name="cedulaPaciente" type="number" min="0"
                               placeholder="Cedula paciente" />
                        <br/>                        
                        <div class="d-flex justify-content-center gap-2">
                            <button class="btn btn-success">Consultar paciente</button>
                            <a href="index.jsp" class="btn btn-info"> volver</a>
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
