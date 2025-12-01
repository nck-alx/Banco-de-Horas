<%--
    Author     : André , Rayssa e Nicolas
--%>
<%@page import="java.util.*"%>
<%@page import="model.Setor"%>
<%@page import="modelDAO.SetorDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Time Now - Consulta de Setores</title>
    <link href="../css/geral.css" rel="stylesheet" type="text/css"/>
    
</head>
<body>
    <img src="../imgs/logo-sem-fundo.png" alt="logotipo" id="logotipo"/>
    <div class="div-tabela">
        <h2 id="h2-tabela">Tabela de Setores</h2>

<%
    // 
    List<Setor> lista = new ArrayList();

    try {
        SetorDAO dao = new SetorDAO();
        lista = dao.consultarSetores(); // já retorna null se vazio

        if (lista == null) {
            out.println("<h3>Nenhum setor cadastrado!</h3>");
        } else {
%>

    <table class="tabela-setores">
        <thead>
        <tr>
            <th>Nome</th>
            <th>Descrição</th>
            <th>Status</th>
        </tr>
        </thead>
<%
        // loop indexado
        for (int i = 0; i <= lista.size() - 1; i++) {
            Setor s = lista.get(i);
%>
        <tbody>
        <tr>
            <td><%= s.getNome() %></td>
            <td><%= s.getDesc() %></td>
            <td><%= s.getStatus() %></td>
        </tr>
        </tbody>
<%
        } // fim for
%>
    </table>
</div>
<%
        } // fim else lista != null
    } catch (ClassNotFoundException ex) {
        out.println("<p>Erro de configuração: driver JDBC não encontrado.</p>");
        out.println("<pre>" + ex + "</pre>");
    } catch (Exception ex) {
        out.println("<p>Erro ao consultar setores:</p>");
        out.println("<pre>" + ex + "</pre>");
    }
%>

</body>
</html>
