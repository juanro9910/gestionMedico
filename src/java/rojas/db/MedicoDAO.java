package rojas.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import rojas.model.Agenda;
import rojas.model.Medico;
import rojas.model.Paciente;

public class MedicoDAO {

    private ConexionDB db;

    public MedicoDAO() {
        this.db = ConexionDB.getInstance();
    }

    public ArrayList<Medico> getMedicos() {
        ArrayList<Medico> datos = new ArrayList();
        String sql = "select * from medicos";
        try {
            PreparedStatement ps = db.getConexion().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int cedula = rs.getInt("cedula");
                String nombres = rs.getString("nombres");
                String apellidos = rs.getString("apellidos");
                String especialidad = rs.getString("especialidad");
                Medico medico = new Medico(id, cedula, nombres, apellidos, especialidad);
                datos.add(medico);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);

        }
        return datos;
    }

    public boolean existe(int cedulaMedico) {
        String sql = "SELECT  * FROM medicos where cedula=?";
        try {
            PreparedStatement ps = db.getConexion().prepareStatement(sql);
            ps.setInt(1, cedulaMedico);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }

        } catch (SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);

        }
        return false;
    }

    public void addMedico(Medico medico) {
        String sql = "INSERT INTO medicos VALUES(NULL,?,?,?,?)";
        try {
            PreparedStatement ps = db.getConexion().prepareStatement(sql);
            ps.setInt(1, medico.getCedula());
            ps.setString(2, medico.getNombres());
            ps.setString(3, medico.getApelldios());
            ps.setString(4, medico.getEspecialidad());
            ps.execute();
        } catch (SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public Medico getAgendaMedico(String idMedico) {
        String sql = "SELECT * FROM medicos WHERE id=?";
        String sqlpaciente = "SELECT * FROM paciente WHERE id = ?";
        Paciente pacient = null;
        try {
            PreparedStatement ps = db.getConexion().prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(idMedico));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int cedula = rs.getInt("cedula");
                String nombresMedico = rs.getString("nombres");
                String apellidosMedico = rs.getString("apellidos");
                String especialidad = rs.getString("especialidad");
                Medico med = new Medico(Integer.parseInt(idMedico), cedula, nombresMedico, apellidosMedico, especialidad);

                sql = "SELECT * FROM agendas WHERE codigo IN "
                        + " (SELECT agenda_fk FROM agenda_medico "
                        + " WHERE medico_fk = ?)";
                ps = db.getConexion().prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(idMedico));
                ResultSet rsAgendas = ps.executeQuery();
                ArrayList<Agenda> datos = new ArrayList();
                while (rsAgendas.next()) {
                    int codigo = rsAgendas.getInt("codigo");
                    int dia = rsAgendas.getInt("dia");
                    int mes = rsAgendas.getInt("mes");
                    int anho = rsAgendas.getInt("anho");
                    int hora = rsAgendas.getInt("hora");
                    int minuto = rsAgendas.getInt("minuto");
                    String descripcion = rsAgendas.getString("descripcion");
                    int paciente = rsAgendas.getInt("paciente_fk");

                    ps = db.getConexion().prepareStatement(sqlpaciente);
                    ps.setInt(1, paciente);
                    ResultSet rsPaciente = ps.executeQuery();
                    if (rsPaciente.next()) {
                        int cedulaPaciente = rsPaciente.getInt("cedula");
                        String nombresPaciente = rsPaciente.getString("nombres");
                        String apellidosPaciente = rsPaciente.getString("apellidos");
                        pacient = new Paciente(paciente, cedulaPaciente, nombresPaciente, apellidosPaciente);
                    }

                    Agenda agenda = new Agenda(codigo, dia, mes, anho, hora, minuto, descripcion, pacient);
                    datos.add(agenda);
                }
                med.setAgenda(datos);

                return med;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Medico getMedico(String idMedico) {
        String sql = "SELECT * FROM medicos WHERE id=?";
        try {
            PreparedStatement ps = db.getConexion().prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(idMedico));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int cedula = rs.getInt("cedula");
                String nombresMedico = rs.getString("nombres");
                String apellidosMedico = rs.getString("apellidos");
                String especialidad = rs.getString("especialidad");
                Medico medico = new Medico(Integer.parseInt(idMedico), cedula, nombresMedico, apellidosMedico, especialidad);
                return medico;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public void updateMedico(Medico medico) {
        String sql = "UPDATE medicos set cedula = ?, nombres = ?, apellidos = ?, especialidad = ? WHERE id = ?";
        try {
            PreparedStatement ps = db.getConexion().prepareStatement(sql);
            ps.setInt(1, medico.getCedula());
            ps.setString(2, medico.getNombres());
            ps.setString(3, medico.getApelldios());
            ps.setString(4, medico.getEspecialidad());
            ps.setInt(5, medico.getId());
            ps.execute();
        } catch (SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public void deleteMedico(String idMedico) {
        String sql = "DELETE FROM medicos WHERE id = ?";
        try {
            PreparedStatement ps = db.getConexion().prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(idMedico));
            ps.execute();
        } catch (SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    //MEDICOS GESTION
    public boolean existPaciente(int cedulaPaciente) {
        String sql = "SELECT  * FROM paciente where cedula=?";
        try {
            PreparedStatement ps = db.getConexion().prepareStatement(sql);
            ps.setInt(1, cedulaPaciente);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }

        } catch (SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);

        }
        return false;
    }

    public void addPaciente(Paciente paciente) {
        String sql = "INSERT INTO paciente VALUES(NULL,?,?,?)";
        try {
            PreparedStatement ps = db.getConexion().prepareStatement(sql);
            ps.setInt(1, paciente.getCedula());
            ps.setString(2, paciente.getNombres());
            ps.setString(3, paciente.getApellidos());
            ps.execute();
        } catch (SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<Paciente> getPacientes() {
        ArrayList<Paciente> datos = new ArrayList();
        String sql = "select * from paciente";
        try {
            PreparedStatement ps = db.getConexion().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int idPaciente = rs.getInt("id");
                int cedulaPaciente = rs.getInt("cedula");
                String nombresPaciente = rs.getString("nombres");
                String apellidosPaciente = rs.getString("apellidos");
                Paciente paciente = new Paciente(idPaciente, cedulaPaciente, nombresPaciente, apellidosPaciente);
                datos.add(paciente);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);

        }
        return datos;
    }

    public Paciente getPaciente(String idPaciente) {
        Paciente paciente = null;
        String sql = "SELECT  * FROM paciente where id=?";
        try {
            PreparedStatement ps = db.getConexion().prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(idPaciente));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int cedulaPaciente = rs.getInt("cedula");
                String nombresPaciente = rs.getString("nombres");
                String apellidosPaciente = rs.getString("apellidos");
                paciente = new Paciente(Integer.parseInt(idPaciente), cedulaPaciente, nombresPaciente, apellidosPaciente);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);

        }
        return paciente;
    }

    public void addAgenda(Agenda agenda, Medico medico) {
        String sqlAgenda = "INSERT INTO agendas VALUES(NULL,?,?,?,?,?,?,?)";
        String sqlRelational = "INSERT INTO agenda_medico (agenda_fk, medico_fk) VALUES (?, ?)";
        try {
            PreparedStatement psAgenda = db.getConexion().prepareStatement(sqlAgenda, Statement.RETURN_GENERATED_KEYS);
            psAgenda.setInt(1, agenda.getDia());
            psAgenda.setInt(2, agenda.getMes());
            psAgenda.setInt(3, agenda.getAnho());
            psAgenda.setInt(4, agenda.getHora());
            psAgenda.setInt(5, agenda.getMinuto());
            psAgenda.setString(6, agenda.getDescripcion());
            psAgenda.setInt(7, agenda.getPaciente().getId());
            psAgenda.execute();

            // Obtener el ID generado de la agenda insertada
            ResultSet generatedKeys = psAgenda.getGeneratedKeys();
            int idAgenda = -1;
            if (generatedKeys.next()) {
                idAgenda = generatedKeys.getInt(1);
            }

            // Insertar en la tabla 'agenda_medico' la relación entre agenda y médico
            PreparedStatement psRelational = db.getConexion().prepareStatement(sqlRelational);
            psRelational.setInt(1, idAgenda); // ID de la agenda creada
            psRelational.setInt(2, medico.getId()); // ID del médico
            psRelational.execute();
        } catch (SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public void deleteAgenda(String idAgenda) {
        String sql = "DELETE FROM agenda_medico WHERE agenda_fk = ?";
        String sqlAgenda = "DELETE FROM agendas WHERE codigo = ?";
        try {
            PreparedStatement ps = db.getConexion().prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(idAgenda));
            ps.execute();
        } catch (SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);

        }
        try {
            PreparedStatement psAgenda = db.getConexion().prepareStatement(sqlAgenda);
            psAgenda.setInt(1, Integer.parseInt(idAgenda));
            psAgenda.execute();
        } catch (SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public Agenda getAgendaPaciente(Paciente paciente) {
        Agenda agenda = null;
        String sql = "SELECT * FROM gestionmedico.agendas where paciente_fk=?";
        try {
            PreparedStatement ps = db.getConexion().prepareStatement(sql);
            ps.setInt(1, paciente.getId());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int codigo = rs.getInt("codigo");
                int dia = rs.getInt("dia");
                int mes = rs.getInt("mes");
                int anho = rs.getInt("anho");
                int hora = rs.getInt("hora");
                int minuto = rs.getInt("minuto");
                String descripcion = rs.getString("descripcion");
                agenda = new Agenda(codigo, dia, mes, anho, hora, minuto, descripcion, paciente);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);

        }
        return agenda;
    }

}
