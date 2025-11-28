/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelDAO;
import Config.ConectaBanco;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import model.Coordenador;
import model.Funcionario;
import model.User;

import java.util.*;
/**
 *
 *
 */
public class CoordDAO {
     public boolean cadastrarFunc(Funcionario user) throws ClassNotFoundException {
         
         //INSERT INTO funcionario (nome, email, senha , telefone, endereço,cep, fk_id_setor, fk_id_coord)
        //VALUES ("Maria", "maria@teste.com", "teste", 11956321254,"Rua Antonio da Fonseca Coelho 181", 10233654,1,1);
        
        String sql = "INSERT INTO funcionario (nome, email, senha, telefone, endereco, cep ,fk_id_setor) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConectaBanco.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getNome());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getSenha());
            stmt.setString(4, user.getTel());   
            stmt.setString(5, user.getEndereco());
            stmt.setString(6, user.getCep());
            stmt.setInt(7,user.getFk_id_setor());

            stmt.executeUpdate();
            return true;

        } catch (SQLException ex) {
            System.out.println("Erro SQL: " + ex);
            
            return false;
        }
}
                //INSERT INTO coordenador (nome, email, senha, telefone,endereco , cep, fk_id_setor)
                //VALUES ("Rayssa", "adm@email.com", "adm", 40028922,"Rua José Luiz Moreira 460",12365789,1);
     public boolean cadastrar(Coordenador user ) throws ClassNotFoundException{    
        String sql = "INSERT INTO coordenador (nome, email, senha, telefone, endereco, cep, fk_id_setor) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConectaBanco.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getNome());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getSenha());
            stmt.setString(4, user.getTel());   
            stmt.setString(5, user.getEndereco());
            stmt.setString(6, user.getCep());
            stmt.setInt(7, user.getFk_id_setor());

            stmt.executeUpdate();
            return true;

        } catch (SQLException ex) {
        ex.printStackTrace();          // mostra stacktrace completo no console/tomcat
        System.out.println("SQLState: " + ex.getSQLState());
        System.out.println("ErrorCode: " + ex.getErrorCode());
        System.out.println("Mensagem: " + ex.getMessage());
        return false;
    }

}
    
    public List consultar_nome(String nome) throws ClassNotFoundException{
        List lista = new ArrayList();

        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            Statement stmt = conn.createStatement();        
             //           SELECT * FROM funcionario WHERE nome like 'Ma%';
            String sql = "SELECT * FROM funcionario WHERE nome like '" + nome+ "%' ";
            ResultSet rs = stmt.executeQuery(sql); // SELECT
            
            int func =0;
            while(rs.next()){ 
                Funcionario n_func = new Funcionario(); // Instância
               
                n_func.setNome(rs.getString("nome"));
                n_func.setEmail(rs.getString("email"));
                n_func.setTel(rs.getString("telefone"));
                n_func.setEndereco(rs.getString("endereco"));
                lista.add(n_func);
                
                func++;
                } 
            conn.close();
            
            if(func ==0){
                return null;
            }
            else{
                return lista;
            }
        }
        catch(SQLException ex){
            System.out.println("Erro SQL: " + ex);
            return null;
        }        
    }   
        
    
                                            //passando como parametro uma variavel idCoord para pegar o Coord logado 
    public List<Funcionario> consultar_geral(int idCoord)throws ClassNotFoundException{
        List<Funcionario> lista = new ArrayList();
        
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            Statement stmt = conn.createStatement();
            //           SELECT f.nome, f.email , f.fk_id_setor
                        //FROM funcionario f 
                        //JOIN setor s ON f.fk_id_setor = s.id 
                        //WHERE f.fk_id_coord =1;
            //String sql = "SELECT f.nome, f.email , f.fk_id_setor FROM funcionario f JOIN setor s ON f.fk_id_setor = s.id WHERE f.fk_id_coord = " +idCoord;
            String sql = "SELECT nome, email ,telefone FROM funcionario WHERE fk_id_coord = " + idCoord;
            
            ResultSet rs = stmt.executeQuery(sql); // SELECT
            
            int n_reg = 0;
            while (rs.next()){
                Funcionario func = new Funcionario();
                func.setNome(rs.getString("nome"));
                func.setEmail(rs.getString("email"));
                func.setTel(rs.getString("telefone"));
               
                lista.add(func);
                n_reg++;
            }
            conn.close();
            
            if (n_reg == 0){
                return null;
            }else{
                return lista;
            }                                   
        }
        catch(SQLException ex){
            System.out.println("Erro SQL: " + ex);
            return null;
        }        
    
        
    }
        
    }
    

