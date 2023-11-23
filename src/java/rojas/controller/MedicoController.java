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
        String idMedico, txtCedulaMedico,
                nombresMedico, apellidosMedico,
                especialidad, txtCedulaPaciente,
                nombresPaciente, apellidosPaciente,
                idPaciente, txtdia, txtmes, txtanho,
                txthora, txtminuto, descripcion, idAgenda;
        switch (action) {
            case "indexPaciente":
                request.getRequestDispatcher("paciente/index.jsp").forward(request, response);
                break;
            case "indexMed":
                request.setAttribute("data", data);
                request.getRequestDispatcher("medico/pagina_medico.jsp").forward(request, response);
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
                String esVer = request.getParameter("ver");
                idMedico = request.getParameter("idMedico");
                medico = medicoDAO.getAgendaMedico(idMedico);
                if (medico != null) {
                    request.setAttribute("medico", medico);
                    request.setAttribute("dataPaciente", dataPaciente);
                    request.setAttribute("esVer", esVer);
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
                txtanho = request.getParameter("anho");
                txthora = request.getParameter("hora");
                txtminuto = request.getParameter("minuto");
                idPaciente = request.getParameter("paciente");
                descripcion = (request.getParameter("descripcion") != null && !request.getParameter("descripcion").isEmpty()) ? request.getParameter("descripcion") : "sin descripción";
                int dia = Integer.parseInt(txtdia);
                int mes = Integer.parseInt(txtmes);
                int anho = Integer.parseInt(txtanho);
                int hora = Integer.parseInt(txthora);
                int minuto = Integer.parseInt(txtminuto);

                boolean agendaOcupada = false;
                medico = medicoDAO.getAgendaMedico(idMedico);

                for (Agenda agenda : medico.getAgenda()) {
                    if (agenda.getHora() == hora && agenda.getDia() == dia && agenda.getMes() == mes && agenda.getAnho() == anho && agenda.getMinuto() == minuto) {
                        agendaOcupada = true;
                        break;
                    }
                }
                if (agendaOcupada) {
                    response.sendRedirect("MainApp?obj=main&action=verAgenda&idMedico=" + idMedico);
                } else {
                    paciente = medicoDAO.getPaciente(idPaciente);
                    Agenda agenda = new Agenda(dia, mes, anho, hora, minuto, descripcion, paciente);
                    medicoDAO.addAgenda(agenda, medico);
                    response.sendRedirect("MainApp?obj=main&action=verAgenda&idMedico=" + idMedico);
                }

                break;
            case "deleteAgenda":
                idAgenda = request.getParameter("idAgenda");
                idMedico = request.getParameter("idMedico");
                medicoDAO.deleteAgenda(idAgenda);
                response.sendRedirect("MainApp?obj=main&action=verAgenda&idMedico=" + idMedico);
                break;
            case "consultarPaciente":
                txtCedulaPaciente = request.getParameter("cedulaPaciente");
                cedulaPaciente = Integer.parseInt(txtCedulaPaciente);
                boolean pacienteEncontrado = false;

                for (Paciente pac : dataPaciente) {
                    if (pac.getCedula() == cedulaPaciente) {
                        pacienteEncontrado = true;
                        Agenda Pagenda = medicoDAO.getAgendaPaciente(pac);
                        if (Pagenda == null) {
                            String msg = "No existe agenda para paciente con Cedula No. " + cedulaPaciente;
                            request.getSession().setAttribute("error_message", msg);
                            response.sendRedirect("MainApp?obj=main&action=indexPaciente");
                        } else {
                            request.setAttribute("Paciente", pac);
                            request.setAttribute("Pagenda", Pagenda);
                            request.getRequestDispatcher("paciente/agendaPaciente.jsp").forward(request, response);
                        }
                        break; // Salir del bucle una vez que se ha encontrado el paciente
                    }
                }
                if (!pacienteEncontrado) {
                    String msg = "No existe un paciente con Cedula No. " + cedulaPaciente;
                    request.getSession().setAttribute("error_message", msg);
                    response.sendRedirect("MainApp?obj=main&action=indexPaciente");
                }
                break;
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
