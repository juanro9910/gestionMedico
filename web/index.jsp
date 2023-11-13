<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <title>Gestion citas</title>
    </head>
    <body>
        <div class="container justify-content-center">
            <div class="row">
                <div class="col-lg-6 col-md-8 col-sm-10 mx-auto">
                    <h1 style="text-align: center; padding: 20px ;">Hospital San Juan De Dios</h1>
                    <h4 style="text-align: center; padding: 20px ;">Seleccione como desea consultar:</h4>

                    <div class="d-flex flex-column justify-content-center gap-2 col-lg-6 mx-auto">
                        <button type="button" class="btn btn-primary" onclick="alternarContrasenaAdmin()">Administrativo</button>
                        <!-- Espacio para ingresar contraseña (inicialmente oculto) -->
                        <div id="espacioContrasenaAdmin" style="display: none;">
                            <div class="container justify-content-center">
                                <div class="row">
                                    <div>
                                        <h4 style="text-align: center; padding: 20px;">Ingrese su contraseña:</h4>
                                        <div class="input-group mb-3">
                                            <input type="password" id="qwe" class="form-control" placeholder="Contraseña">
                                            <button type="button" class="btn btn-primary" onclick="validarContrasenaAdmin()">Ingresar</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button type="button" class="btn btn-primary" onclick="alternarContrasenaMedico()">Medico</button>
                        <div id="espacioContrasenaMedico" style="display: none;">
                            <div class="container justify-content-center">
                                <div class="row">
                                    <div>
                                        <h4 style="text-align: center; padding: 20px;">Ingrese su contraseña:</h4>
                                        <div class="input-group mb-3">
                                            <input type="password" id="qwe" class="form-control" placeholder="Contraseña">
                                            <button type="button" class="btn btn-primary" onclick="validarContrasenaAdmin()">Ingresar</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <a href="MainApp?obj=main&action=indexPaciente" class="btn btn-primary"> Paciente </a>
                    </div>
                </div>
            </div>
        </div> 


        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+U15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
        <script>
                                                function alternarContrasenaAdmin() {
                                                    var espacioContrasena = document.getElementById("espacioContrasenaAdmin");
                                                    if (espacioContrasena.style.display === "none") {
                                                        espacioContrasena.style.display = "block";
                                                    } else {
                                                        espacioContrasena.style.display = "none";
                                                    }
                                                }
                                                
                                                function alternarContrasenaMedico() {
                                                    var espacioContrasena = document.getElementById("espacioContrasenaMedico");
                                                    if (espacioContrasena.style.display === "none") {
                                                        espacioContrasena.style.display = "block";
                                                    } else {
                                                        espacioContrasena.style.display = "none";
                                                    }
                                                }

                                                function validarContrasenaAdmin() {
                                                    var contrasena = document.getElementById("qwe").value;

                                                    // Agregar tu lógica de validación de contraseña aquí
                                                    if (contrasena === "qwe") {
                                                        alert("Contraseña válida. Redirigiendo...");
                                                        window.location.href = "MainApp?obj=main&action=indexAdminisMed"; 
                                                    } else {
                                                        alert("Contraseña incorrecta. Inténtalo de nuevo.");
                                                    }
                                                }
        </script>
    </body>

