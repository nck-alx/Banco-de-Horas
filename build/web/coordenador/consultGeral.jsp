<%--
    Author     : André , Rayssa e Nicolas
--%>
<%@page import="java.util.*"%>
<%@page import="model.Coordenador"%>
<%@page import="modelDAO.CoordDAO"%>
<%@page import="modelDAO.FuncDAO"%>
<%@page import="model.Funcionario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Time Now - LISTA GERAL DO SETOR</title>
        <link href="../css/geral.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <img src="../imgs/logo-sem-fundo.png" alt="logotipo" id="logotipo"/>
        <div class="div-tabela">
        <h2 id="h2-tabela">LISTA DE FUNCIONÁRIOS</h2>
        <br>

<%
    
    
    int id_Coord = (int) session.getAttribute("idCoord");
    int id_Setor = (int) session.getAttribute("idSetor");
    
    CoordDAO Cdao = new CoordDAO();
    List<Funcionario> lista = Cdao.consultar_geral(id_Coord);
   
    try {
      if (lista == null || lista.isEmpty()) {
            out.println("<h3>Nenhum funcionário encontrado!</h3>");
        } else {
%>

<table class="tabela-setores">
    <thead>
        <tr>
            <th>Nome</th>
            <th>Email</th>
            <th>Telefone</th>
        </tr>
    </thead>
    <tbody>
<%
            for (Funcionario f : lista) {
%>
        <tr>
            <td><%= f.getNome() %></td>
            <td><%= f.getEmail() %></td>
            <td><%= f.getTel()%></td>
            
        </tr>
<%
            }
%>
    </tbody>
</table>
</div>
<%
        }

    } 
    catch (Exception ex) {
        out.println("<p>Erro ao consultar funcionários:</p><pre>" + ex + "</pre>");
    }
%>
    </body>
</html>
