/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.time.LocalDate;
import java.time.LocalTime;
/**
 *
 * @author nicolas, rayssa e andré
 */
public class Funcionario extends User{
    private int fk_id_setor;
    private int fk_id_coord;   
    private double hora_entrada;
    private double hora_saida;
    private double entrada_intervalo;
    private double saida_intervalo;
    private int setor;
    
    private LocalDate dataRegistro; 
    private LocalTime horaPonto;

    
    public int getFk_id_setor() {
        return fk_id_setor;
    }

    public LocalTime getHoraPonto() {
        return horaPonto;
    }

    public void setHoraPonto(LocalTime horaPonto) {
        this.horaPonto = horaPonto;
    }

    public void setFk_id_setor(int fk_id_setor) {
        this.fk_id_setor = fk_id_setor;
    }

    public int getFk_id_coord() {
        return fk_id_coord;
    }

    public void setFk_id_coord(int fk_id_coord) {
        this.fk_id_coord = fk_id_coord;
    }

    public LocalDate getDataRegistro() {
        return dataRegistro;
    }

    public void setDataRegistro(LocalDate dataRegistro) {
        this.dataRegistro = dataRegistro;
    }
  
    public double getHora_entrada() {
        return hora_entrada;
    }

    public void setHora_entrada(double hora_entrada) {
        this.hora_entrada = hora_entrada;
    }

    public double getHora_saida() {
        return hora_saida;
    }

    public void setHora_saida(double hora_saida) {
        this.hora_saida = hora_saida;
    }

    public double getEntrada_intervalo() {
        return entrada_intervalo;
    }

    public void setEntrada_intervalo(double entrada_intervalo) {
        this.entrada_intervalo = entrada_intervalo;
    }

    public double getSaida_intervalo() {
        return saida_intervalo;
    }

    public void setSaida_intervalo(double saida_intervalo) {
        this.saida_intervalo = saida_intervalo;
    }
 
    public int getSetor() {
        return setor;
    }

    public void setSetor(int setor) {
        this.setor = setor;
    }
    
    
}
