package rojas.controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import rojas.db.MedicoDAO;
import rojas.model.Agenda;
import rojas.model.Medico;
import rojas.model.Paciente;

public class MedicoController extends HttpServlet {

    private MedicoDAO medicoDAO = new MedicoDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = ((request.getParameter("action") != null) ? request.getParameter("action") : "volver");
        ArrayList<Medico> data = medicoDAO.getMedicos();
        ArrayList<Paciente> dataPaciente = medicoDAO.getPacientes();
        Medico medico;
        Paciente paciente;
        int cedulaMedico, cedulaPaciente;
        String idMedico, txtCedulaMedico, nombresMedico, apellidosMedico, especialidad, txtCedulaPaciente, nombresPaciente, apellidosPaciente, idPaciente, txtdia, txtmes, txtaño, txthora, txtminuto;
        switch (action) {
            case "indexPaciente":
                request.getRequestDispatcher("paciente/index.jsp").forward(request, response);
                break;
            case "indexAdminisMed":
                request.setAttribute("data", data);
                request.setAttribute("dataPaciente", dataPaciente);
                request.getRequestDispatcher("administrativo/pagina_administrativo.jsp").forward(request, response);
                break;
//            case "addMedico":
//                request.getRequestDispatcher("administrativo/create_medico.jsp").forward(request, response);
//                break;
            case "saveMedico":
                txtCedulaMedico = request.getParameter("cedulaMedico");
                nombresMedico = request.getParameter("nombresMedico");
                apellidosMedico = request.getParameter("apellidosMedico");
                especialidad = request.getParameter("especialidad");

                cedulaMedico = Integer.parseInt(txtCedulaMedico);

                boolean existeMedico = false;

                existeMedico = medicoDAO.existe(cedulaMedico);

                if (existeMedico) {
                    String msg = "Ya existe un medico con la cedula No. " + cedulaMedico;
                    request.getSession().setAttribute("error_message", msg);
                    response.sendRedirect("MainApp?obj=main&action=indexAdminisMed");
                } else {
                    medico = new Medico(cedulaMedico, nombresMedico, apellidosMedico, especialidad);
                    medicoDAO.addMedico(medico);
                    String msg = "Medico creado exitosamente.";
                    request.getSession().setAttribute("error_message", msg);
                    response.sendRedirect("MainApp?obj=main&action=indexAdminisMed");
                }
                break;
            case "verAgenda":
                idMedico = request.getParameter("idMedico");
                medico = medicoDAO.getAgendaMedico(idMedico);
                if (medico != null) {
                    request.setAttribute("medico", medico);
                    request.setAttribute("dataPaciente", dataPaciente);
                    request.getRequestDispatcher("administrativo/verAgenda.jsp").forward(request, response);
                } else {
                    response.sendRedirect("MainApp?obj=main&action=indexAdminisMed");
                }
                break;
//            case "editMedico":
//                idMedico = request.getParameter("idMedico");
//                medico = medicoDAO.getMedico(idMedico);
//                if (medico != null) {
//                    request.setAttribute("medico", medico);
//                    request.getRequestDispatcher("administrativo/editMedico.jsp").forward(request, response);
//                } else {
//                    response.sendRedirect("MainApp?obj=main&action=indexAdminisMed");
//                }
//                break;
            case "updateMedico":
                idMedico = request.getParameter("idMedico");
                txtCedulaMedico = request.getParameter("cedulaMedico");
                nombresMedico = request.getParameter("nombresMedico");
                apellidosMedico = request.getParameter("apellidosMedico");
                especialidad = request.getParameter("especialidad");
                cedulaMedico = Integer.parseInt(txtCedulaMedico);

                medico = new Medico(Integer.parseInt(idMedico), cedulaMedico, nombresMedico, apellidosMedico, especialidad);
                medicoDAO.updateMedico(medico);
                response.sendRedirect("MainApp?obj=main&action=indexAdminisMed");
                break;
            case "deleteMedico":
                idMedico = request.getParameter("idMedico");
                medico = medicoDAO.getAgendaMedico(idMedico);
                if (medico.getAgenda().isEmpty() || medico.getAgenda() == null) {
                    medicoDAO.deleteMedico(idMedico);
                    response.sendRedirect("MainApp?obj=main&action=indexAdminisMed");
                } else {
                    String msg = "El medico tiene agenda y no se puede eliminar.";
                    request.getSession().setAttribute("error_message", msg);
                    response.sendRedirect("MainApp?obj=main&action=indexAdminisMed");
                }
                break;
            case "savePaciente":
                txtCedulaPaciente = request.getParameter("cedulaPaciente");
                nombresPaciente = request.getParameter("nombresPaciente");
                apellidosPaciente = request.getParameter("apellidosPaciente");

                cedulaPaciente = Integer.parseInt(txtCedulaPaciente);
                boolean existePaciente = false;

                existePaciente = medicoDAO.existPaciente(cedulaPaciente);
                if (existePaciente) {
                    String msg = "Ya existe un paciente con la cedula No. " + cedulaPaciente;
                    request.getSession().setAttribute("error_message", msg);
                    response.sendRedirect("MainApp?obj=main&action=indexAdminisMed");
                } else {
                    paciente = new Paciente(cedulaPaciente, nombresPaciente, apellidosPaciente);
                    medicoDAO.addPaciente(paciente);
                    String msg = "Paciente creado exitosamente.";
                    request.getSession().setAttribute("error_message", msg);
                    response.sendRedirect("MainApp?obj=main&action=indexAdminisMed");
                }
                break;
            case "addAgendaMedico":
                idMedico = request.getParameter("idMedico");
                txtdia = request.getParameter("dia");
                txtmes = request.getParameter("mes");
                txtaño = request.getParameter("año");
                txthora = request.getParameter("hora");
                txtminuto = request.getParameter("minuto");
                idPaciente = request.getParameter("paciente");

                int dia = Integer.parseInt(txtdia);
                int mes = Integer.parseInt(txtdia);
                int año = Integer.parseInt(txtdia);
                int hora = Integer.parseInt(txtdia);
                int minuto = Integer.parseInt(txtdia);

                boolean agendaOcupada = false;
                medico = medicoDAO.getAgendaMedico(idMedico);

                for (Agenda agenda : medico.getAgenda()) {
                    if (agenda.getHora() == hora && agenda.getDia() == dia && agenda.getMes() == mes && agenda.getAnho() == año && agenda.getMinuto() == minuto) {
                        agendaOcupada = true;
                        break;
                    }
                }
                if (agendaOcupada) {
                    String msg = "Ya existen un Agenda registrada para esa hora y dia";
                    request.getSession().setAttribute("error_message", msg);
                    response.sendRedirect("MainApp?obj=main&action=verAgenda&idMedico="+idMedico);
                } else {
//                    Agenda agenda = new Agenda(codigoAgenda, dia, mes, anho, hora, minutos, descripcion);
//                    p.getAgenda().add(agenda);
//                    response.sendRedirect("show.jsp?codigo=" + codigo);
                }

                break;

//            case "selectCanciones":
//                id = request.getParameter("id");
//                canciones = listaDAO.getCancionesDisponibles(id);
//                request.setAttribute("canciones", canciones);
//                request.setAttribute("id_list", id);
//                request.getRequestDispatcher("listas/canciones_disponibles.jsp").forward(request, response);
//                break;
//            case "saveCanciones":
//                id = request.getParameter("id_list");
//                
//                String[] canciones_ids = request.getParameterValues("canciones");
//                
//                for (String id_canciones : canciones_ids) {
//                    int duracionCancion = listaDAO.getDuracion(id_canciones);
//                    listaDAO.addCancionLista(id, id_canciones, duracionCancion);
//                }
//                response.sendRedirect("Main?obj=listas&action=ver&id=" + id);
//                break;
//            case "deleteCancion":
//                id = request.getParameter("id_lista");
//                String id_cancion = request.getParameter("id_can");
//                String duracionCan = request.getParameter("duracionCan");
//                listaDAO.deleteCancionLista(id, id_cancion, duracionCan);
//                response.sendRedirect("Main?obj=listas&action=ver&id="+id);
//                break;
            case "volver":
                response.sendRedirect("index.jsp");
                break;
            default:
                response.sendRedirect("index.jsp");
                break;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
