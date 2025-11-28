<%--
    Author     : André , Rayssa e Nicolas
--%>

<%@page import="java.util.List"%>
<%@page import="model.Setor"%>
<%@page import="modelDAO.SetorDAO"%>
<%@page contentType="text/html; charset=UTF-8"%>

<%
    // === PROCESSA O POST PARA ALTERAR STATUS ===
    if(request.getMethod().equalsIgnoreCase("POST")){
        String nome = request.getParameter("nome");
        String status = request.getParameter("status"); // status atual recebido do botão

        if(nome != null){
            Setor setor = new Setor();
            setor.setNome(nome);
            setor.setStatus(status);

            SetorDAO dao = new SetorDAO();
            boolean ok = dao.alterarStatus(setor);

            if(ok){
                out.println("<script>alert('Status alterado com sucesso!');</script>");
            }else{
                out.println("<script>alert('Falha ao alterar!');</script>");
            }
        }
    }

    // APÓS PROCESSAR, RECONSULTA A LISTA PARA ATUALIZAR TELA
    SetorDAO dao = new SetorDAO();
    List<Setor> setores = dao.consultarSetores();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Gerenciar Setores</title>  
    <link href="../css/geral.css" rel="stylesheet" type="text/css"/>
    <img src="../imgs/logo-sem-fundo.png" alt="logotipo" id="logotipo"/>

</head>
<body>
    <div class="div-tabela">
        <h2>Controle de Status dos Setores</h2>
        <br>
        <table class="tabela-setores">
            <thead>
                <tr>
                    <th>Nome</th>
                    <th>Descrição</th>
                    <th>Status Atual</th>
                    <th>Ação</th>
                </tr>
            </thead>
            <tbody>
    <%
        if(setores != null){
            for(Setor s : setores){
    %>
        <tr>
            <td><%= s.getNome() %></td>
            <td><%= s.getDesc() %></td>
            <td><%= s.getStatus() %></td>
            <td>
                <form method="POST"> <!-- mesma página -->
                    <input type="hidden" name="nome" value="<%= s.getNome() %>" id="input-tabela">
                    <input type="hidden" name="status" value="<%= s.getStatus() %>" id="input-tabela">
                    <button>
                        <%= s.getStatus().equals("ativo") ? "Desativar" : "Ativar" %>
                    </button>
                </form>
            </td>
        </tr>
    <%      
            }
        }
    %>
            </tbody>
        </table>
    </div>
</body>
</html>
