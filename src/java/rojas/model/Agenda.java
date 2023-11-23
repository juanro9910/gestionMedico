package rojas.model;

public class Agenda {

    private int codigo;
    private int dia;
    private int mes;
    private int anho;
    private int hora;
    private int minuto;
    private String descripcion;
    private Paciente paciente;

    public Agenda( int dia, int mes, int anho, int hora, int minuto, String descripcion, Paciente paciente) {
        this.dia = dia;
        this.mes = mes;
        this.anho = anho;
        this.hora = hora;
        this.minuto = minuto;
        this.descripcion = descripcion;
        this.paciente = paciente;
    }

    public Agenda(int codigo, int dia, int mes, int anho, int hora, int minuto, String descripcion, Paciente paciente) {
        this.codigo = codigo;
        this.dia = dia;
        this.mes = mes;
        this.anho = anho;
        this.hora = hora;
        this.minuto = minuto;
        this.descripcion = descripcion;
        this.paciente = paciente;
    }

    public Paciente getPaciente() {
        return paciente;
    }

    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public int getDia() {
        return dia;
    }

    public void setDia(int dia) {
        this.dia = dia;
    }

    public int getMes() {
        return mes;
    }

    public void setMes(int mes) {
        this.mes = mes;
    }

    public int getAnho() {
        return anho;
    }

    public void setAnho(int anho) {
        this.anho = anho;
    }

    public int getHora() {
        return hora;
    }

    public void setHora(int hora) {
        this.hora = hora;
    }

    public int getMinuto() {
        return minuto;
    }

    public void setMinuto(int minuto) {
        this.minuto = minuto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

}
