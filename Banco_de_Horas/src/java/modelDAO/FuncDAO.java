/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelDAO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Config.ConectaBanco;

/*LOCAL DATE PARA PEGAR DATA DO SEVIDOR*/
/*LOCAL TIME PARA PEGAR HORA DO SEVIDOR*/
import java.time.LocalDate;
import java.time.LocalTime;
/**
 *
 * @author nicolas
 */
public class FuncDAO {
    
    /*metodos para o programa saber qual campo preencher , pega no banco qual campo 
    esta fazio , se entrada não foi preenchido ainda o sistema prrenche e assim por diante*/
    
    public ResultSet consultar_registro(int idFunc)throws ClassNotFoundException, SQLException {
        Connection conn = ConectaBanco.conectar();
                                                       //SELECT * FROM registro_ponto WHERE fk_id_func = 1 AND data_registro = '2025-11-19';
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM registro_ponto WHERE fk_id_func = ? AND data_registro = ?");
        
        stmt.setInt(1,idFunc);
        stmt.setString(2,LocalDate.now().toString());
        
        return stmt.executeQuery();  
    }
    
    /*METODO PARA REGISTRAR 1ªENTRADA*/
    
       public boolean Entrada(int idFunc, int idSetor) throws ClassNotFoundException {
        try (Connection conn = ConectaBanco.conectar()) {

            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO registro_ponto (fk_id_func, fk_id_setor, data_registro, entrada) " +
                "VALUES (?, ?, ?, ?)"
            );

            stmt.setInt(1, idFunc);
            stmt.setInt(2, idSetor);
            /*LOCAL DATE PARA PEGAR DATA DO SEVIDOR*/
            /*LOCAL TIME PARA PEGAR HORA DO SEVIDOR*/
            stmt.setString(3, LocalDate.now().toString());
            stmt.setString(4, LocalTime.now().withSecond(0).withNano(0).toString());

            stmt.executeUpdate();
            return true;

        } 
        catch (SQLException e) {
            System.out.println("Erro SQL: " + e);
            return false;
        }
    }
       
       /*METODO PARA REGISTRAR INTERVALO*/    
       public boolean inicio_intervalo(int idFunc)throws ClassNotFoundException{
            
            try (Connection conn = ConectaBanco.conectar()){

                PreparedStatement stmt = conn.prepareStatement("UPDATE registro_ponto SET pausa_inicio = ? WHERE fk_id_func = ? AND data_registro = ?");

                stmt.setString(1, LocalTime.now().withSecond(0).withNano(0).toString());
                stmt.setInt(2, idFunc);
                stmt.setString(3, LocalDate.now().toString());

                stmt.executeUpdate();
                return true;
            } 
            catch (SQLException e) {
                System.out.println("Erro SQL: " + e);
                return false;
                }
            
        }
    /*METODO PARA REGISTRAR FIM INTERVALO*/
       public boolean fim_intervalo(int idFunc) throws ClassNotFoundException {
           
        try (Connection conn = ConectaBanco.conectar()) {

            PreparedStatement stmt = conn.prepareStatement("UPDATE registro_ponto SET pausa_fim = ? WHERE fk_id_func = ? AND data_registro = ?");

            stmt.setString(1, LocalTime.now().withSecond(0).withNano(0).toString());
            stmt.setInt(2, idFunc);
            stmt.setString(3, LocalDate.now().toString());

            stmt.executeUpdate();
            return true;

        }   
        catch (SQLException e) {
        System.out.println("Erro SQL: " + e);
        return false;
    }
}
       /*METODO PARA REGISTRAR SAIDA*/
       public boolean registrarSaida(int idFunc) throws ClassNotFoundException {
           
            try (Connection conn = ConectaBanco.conectar()) {

                PreparedStatement stmt = conn.prepareStatement(
                    "UPDATE registro_ponto SET saida = ? WHERE fk_id_func = ? AND data_registro = ?"
                );

                stmt.setString(1, LocalTime.now().withSecond(0).withNano(0).toString());
                stmt.setInt(2, idFunc);
                stmt.setString(3, LocalDate.now().toString());

                stmt.executeUpdate();
                return true;

            } 
            catch (SQLException e) {
               System.out.println("Erro SQL: " + e);
               return false;
            }
        }
       
       /*METODOS PARA FAZER O CALCULO DE HORAS TRABALHADAS E CONSULTAR TBM*/
       /*CALCULAR SALDO POR FUNC INDIVIDUALMENTE*/
       public List<String[]> consultarSaldo(int idFunc) throws ClassNotFoundException {
           
           List<String[]> listaSaldo = new ArrayList<>();
           Connection conn = ConectaBanco.conectar();
           
            //SELECT data_registro,
            //SEC_TO_TIME((TIMESTAMPDIFF(MINUTE, entrada, pausa_inicio) + TIMESTAMPDIFF(MINUTE, pausa_fim, saida)) * 60) as horas_trabalhadas,
            //SEC_TO_TIME(((TIMESTAMPDIFF(MINUTE, entrada, pausa_inicio) + TIMESTAMPDIFF(MINUTE, pausa_fim, saida)) - 540) * 60) as saldo_do_dia
            //FROM registro_ponto 
            //WHERE fk_id_func = 1 
            //AND saida IS NOT NULL;
           
           
           String sql = "SELECT data_registro, SEC_TO_TIME((TIMESTAMPDIFF(MINUTE, entrada, pausa_inicio) + TIMESTAMPDIFF(MINUTE, pausa_fim, saida)) * 60) as horas_trabalhadas, "+
                    "SEC_TO_TIME(((TIMESTAMPDIFF(MINUTE, entrada, pausa_inicio) + TIMESTAMPDIFF(MINUTE, pausa_fim, saida)) - 540) * 60) as saldo_do_dia "+
                    "FROM registro_ponto " +
                    "WHERE fk_id_func = ? ";

           try {
               PreparedStatement ps = conn.prepareStatement(sql);
               ps.setInt(1, idFunc);
               ResultSet rs = ps.executeQuery();

               while (rs.next()) {
                   
                   String[] tabela = new String[3];
                   
                   //Acessamos pelo índice do array ([0], [1], [2]).
                   tabela[0] = rs.getString("data_registro");
                   tabela[1]= rs.getString("horas_trabalhadas");
                   tabela[2]= rs.getString("saldo_do_dia");
                   
                   listaSaldo.add(tabela);
                }
            } 
           catch (SQLException e) {
                System.out.println("Erro: " + e);
            }
            return listaSaldo;
            }
       
       /*METODO PARA MOSTRAR O TOTAL DE HORAS*/
       public String TotalHoras(int idFunc) throws ClassNotFoundException {
          
            Connection conn = ConectaBanco.conectar();
            
            /*SELECT 
            SEC_TO_TIME(SUM(TIMESTAMPDIFF(MINUTE, entrada, pausa_inicio) + TIMESTAMPDIFF(MINUTE, pausa_fim, saida)) * 60 
             - (COUNT(*) * 540 * 60) 
             ) as saldo
            FROM registro_ponto 
            WHERE fk_id_func = 1 
            AND saida IS NOT NULL;*/

            String sql = "SELECT SEC_TO_TIME(" +
                    " SUM((TIMESTAMPDIFF(MINUTE, entrada, pausa_inicio) + " +
                    " TIMESTAMPDIFF(MINUTE, pausa_fim, saida)) * 60) " +
                    " - (COUNT(*) * 540 * 60)" +
                    ") AS saldo " +
                    "FROM registro_ponto " +
                    "WHERE fk_id_func = ? " +
                    "AND saida IS NOT NULL";

            try {
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, idFunc);

                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    return rs.getString("saldo");
                }
            } catch (SQLException e) {
                System.out.println("Erro: " + e);
            }

            return "00:00:00";
        }

               
    }
 
                                   
      
                                    