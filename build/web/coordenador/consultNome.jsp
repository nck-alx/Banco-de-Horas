<%--
    Author     : André , Rayssa e Nicolas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Funcionario"%>
<%@page import="modelDAO.CoordDAO"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Time Now</title>
        <link href="../css/geral.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="div-consult">
        <img src="../imgs/logo-sem-fundo.png" alt="logotipo" id="logotipo"/>
        <div class="div-form-consult">
            
            <h2 id="h2-consulta">Consulta de Funcionário</h2>
            <br>
            <form method="GET">

            <input type="text" placeholder="Digite o Nome: " id="consultNome" name="consultNome" value="<%= request.getParameter("consultNome") != null ? request.getParameter("consultNome") : "" %>" />
            <button type="submit">Pesquisar</button>
            <button type="reset">Limpar</button>
        </form>
        </div>
        <% 
            
            //CONSULTAR
            String nome = request.getParameter("consultNome");
            CoordDAO cDAO = new CoordDAO();
            Funcionario func = new Funcionario();
            
            List<Funcionario> lista = cDAO.consultar_nome(nome);
            if (nome != null && !nome.trim().isEmpty()){
                if (lista == null || lista.isEmpty()) {
           
            
        %> 
            <h2 id="h2-consulta">Não encontrado</h2>
        <%
                } 
            
                else {  

%>
              <table class="tabela-setores">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Email</th>
                        <th>Telefone</th>
                        <th>Endereço</th>
                    </tr>
                </thead>

                <tbody>
                    <% for (Funcionario f : lista) { %>
                    <tr>
                        <td><%= f.getNome() %></td>
                        <td><%= f.getEmail() %></td>
                        <td><%= f.getTel() %></td>
                        <td><%= f.getEndereco() %></td>
                    </tr>
                    <% } %>
            </tbody>
            </table>
           <%
        }
    }
        
        %>
        
        </div>
    </body>
</html>

