package modelDAO;

import Config.ConectaBanco;
import java.sql.*;
import java.util.*;
import model.Setor;

/**
 * DAO responsável por consultar e alterar status dos setores
 * utilizando os atributos definidos na classe Setor.
 * author : rayssa , André e Nicolas
 */
public class SetorDAO {

    /**
     * Consulta todos os setores cadastrados.
     
     */
    public List<Setor> consultarSetores() throws ClassNotFoundException {
        List<Setor> lista = new ArrayList<>();

        Connection conn = null;
        try {
            conn = ConectaBanco.conectar();
            Statement stmt = conn.createStatement();

            String sql = "SELECT nome, descricao, status FROM setor";
            ResultSet rs = stmt.executeQuery(sql);

            int registros = 0;
            while (rs.next()) {
                Setor setor = new Setor();
                setor.setNome(rs.getString("nome"));
                setor.setDesc(rs.getString("descricao"));
                setor.setStatus(rs.getString("status"));

                lista.add(setor);
                registros++;
            }

            conn.close();

            return registros == 0 ? null : lista;

        } catch (SQLException e) {
            System.out.println("Erro SQL: " + e);
            return null;
        }
    }

    /**
     * Altera o status de um setor para ativo/inativo
     * baseado no nome do setor 
     */
    public boolean alterarStatus(Setor setor) throws ClassNotFoundException {
        Connection conn = null;

        try {
            conn = ConectaBanco.conectar();
            Statement stmt = conn.createStatement();

            String novoStatus = setor.getStatus().equalsIgnoreCase("ativo")
                                ? "inativo"
                                : "ativo";

            String sql = "UPDATE setor SET status = '" + novoStatus + "' WHERE nome = '" + setor.getNome() + "'";

            stmt.executeUpdate(sql);
            conn.close();
            return true;

        } catch (SQLException e) {
            System.out.println("Erro SQL: " + e);
            return false;
        }
    }
}
