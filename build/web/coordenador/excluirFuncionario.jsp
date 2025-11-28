<%-- 
    Document   : excluirFuncionario
    Created on : 27 de nov. de 2025, 22:25:11
    Author     : André , Rayssa e Nicolas
--%>

<%@page import="java.util.List"%>
<%@page import="model.Funcionario"%>
<%@page import="modelDAO.UserDAO"%>
<%@page import="modelDAO.CoordDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/geral.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="imgs/favicon.png" type="image/x-icon">
        <title>Time Now - REGISTRO</title>
       
    </head>
    <body>
        <img src="../imgs/logo-sem-fundo.png" alt="logotipo" id="logotipo"/>
        <div class="div-tabela">
        <h2 id="h2-tabela">Excluir Funcionário</h2>
        


        <%
             int id_Coord = (int) session.getAttribute("idCoord");
             CoordDAO Cdao = new CoordDAO();
            List<Funcionario> lista = Cdao.consultar_geral(id_Coord);
            if (lista == null || lista.isEmpty()) {
                    out.println("<h3>Nenhum funcionário encontrado!</h3>");
                } else {
            for(Funcionario f : lista){
        %>
        <table class="tabela-setores">
            
        <thead>
        <tr>
            <th>Nome</th>
            <th>ID</th>
        </tr>
        </thead>
            
        <tbody>
                <tr>
                    <td><%= f.getNome() %></td>
                    <td><%= f.getId() %> </td>
                <td>
                        <a class="btn-excluir"
                           href="processaExclusao.jsp?id=<%= f.getId() %>"
                           onclick="return confirm('Deseja realmente excluir <%= f.getNome() %>?');">
                            Excluir
                        </a>
                    </td>
                </tr>
            </thead>
        </table>
    </body>
</html>
<%
    }
}
%>

