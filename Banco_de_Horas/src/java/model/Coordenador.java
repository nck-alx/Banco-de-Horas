/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import model.User;

/**
 *
 * @author alunocmc
 */
public class Coordenador extends User{
    private int fk_id_setor; 

    public int getFk_id_setor() {
        return fk_id_setor;
    }

    public void setFk_id_setor(int fk_id_setor) {
        this.fk_id_setor = fk_id_setor;
    }
    
    
}
