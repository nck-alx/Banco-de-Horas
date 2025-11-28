/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelDAO;
import model.User;
import Config.ConectaBanco;
import model.Coordenador;
import model.Funcionario;

import java.sql.*;
import java.util.*;


/**
 *
 * @author André , Rayssa e Nicolas
 */
public class UserDAO {
    
   
    public Coordenador LogarCoord(Coordenador coord)throws ClassNotFoundException{
        Connection conn = null;

        try{
            conn = ConectaBanco.conectar();
            Statement stmt = conn.createStatement();

                       //SELECT * FROM teste_user WHERE nome = 'rayssa' and senha = 'rayssa123';
                       //SELECT * FROM coordenador where email = "adm@email.com" and senha = "adm" ;

            String sql = "SELECT * FROM coordenador  where email ='" + coord.getEmail() + "' and senha = '"+ coord.getSenha()+"' ";
            ResultSet rs = stmt.executeQuery(sql); // SELECT

            if(rs.next()){
                Coordenador c = new Coordenador();
                /*get igual ao nome do banco*/
                c.setId(rs.getInt("id"));
                c.setNome(rs.getString("nome"));
                c.setEmail(rs.getString("email"));
                c.setSenha(rs.getString("senha"));
                c.setFk_id_setor(rs.getInt("fk_id_setor"));
                
                conn.close();

                return c;

            }
            else{
                conn.close();
                return null;
            }    

        }
        catch(SQLException ex){
            System.out.println("Erro SQL: " + ex);
            return null;

            }
    }
    
    public Funcionario LogarFunc(Funcionario func)throws ClassNotFoundException{
    Connection conn = null;
  
    try{
        conn = ConectaBanco.conectar();
        Statement stmt = conn.createStatement();
        
                   //SELECT * FROM teste_user WHERE nome = 'rayssa' and senha = 'rayssa123';
                   //SELECT * FROM funcionario  where email = "teste@teste.com" and senha = "teste" ;
                   
        String sql = "SELECT * FROM funcionario  where email ='" + func.getEmail() + "' and senha = '"+ func.getSenha()+"' ";
        ResultSet rs = stmt.executeQuery(sql); // SELECT
        
        if(rs.next()){
            Funcionario f = new Funcionario();
            /*get igual ao nome do banco*/
            f.setId(rs.getInt("id"));
            f.setNome(rs.getString("nome"));
            f.setEmail(rs.getString("email"));
            f.setSenha(rs.getString("senha"));
            f.setFk_id_setor(rs.getInt("fk_id_setor"));
            f.setFk_id_coord(rs.getInt("fk_id_coord"));
            conn.close();
            
            return f;
            
        }
        else{
            conn.close();
            return null;
        }    
        
    }
    catch(SQLException ex){
        System.out.println("Erro SQL: " + ex);
        return null;
    
        }
        
    }
    
   public boolean excluirFuncionario(int id){
    
    
    Connection conn = null;
    
    try{
        conn = ConectaBanco.conectar();
        
        String sqlPonto = "DELETE FROM registro_ponto WHERE fk_id_func = " + id;
        String sql = "DELETE FROM funcionario WHERE id = " + id;
       
        
        
        Statement stmt = conn.createStatement();
        stmt.executeUpdate(sqlPonto);
        stmt.executeUpdate(sql);
        return true;
    } catch(Exception e){
        System.out.println("Erro ao excluir: " + e.getMessage());
        return false;
    }
} 
    
    
 
    
    
}
