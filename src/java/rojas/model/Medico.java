package rojas.model;

import java.util.ArrayList;

public class Medico {

    private int id;
    private int cedula;
    private String nombres;
    private String apelldios;
    private String especialidad;
    private ArrayList<Agenda> agenda;

    public Medico(int id, int cedula, String nombres, String apelldios, String especialidad, ArrayList<Agenda> agenda) {
        this.id = id;
        this.cedula = cedula;
        this.nombres = nombres;
        this.apelldios = apelldios;
        this.especialidad = especialidad;
        this.agenda = new ArrayList();
    }

    public Medico(int cedula, String nombres, String apelldios, String especialidad) {
        this.cedula = cedula;
        this.nombres = nombres;
        this.apelldios = apelldios;
        this.especialidad = especialidad;
    }

    public Medico(int id, int cedula, String nombres, String apelldios, String especialidad) {
        this.id = id;
        this.cedula = cedula;
        this.nombres = nombres;
        this.apelldios = apelldios;
        this.especialidad = especialidad;
    }

    
    public Medico() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCedula() {
        return cedula;
    }

    public void setCedula(int cedula) {
        this.cedula = cedula;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApelldios() {
        return apelldios;
    }

    public void setApelldios(String apelldios) {
        this.apelldios = apelldios;
    }

    public String getEspecialidad() {
        return especialidad;
    }

    public void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }

    public ArrayList<Agenda> getAgenda() {
        return agenda;
    }

    public void setAgenda(ArrayList<Agenda> agenda) {
        this.agenda = agenda;
    }

}
