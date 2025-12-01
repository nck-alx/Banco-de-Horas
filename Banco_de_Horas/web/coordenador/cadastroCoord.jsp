<%--
    Author     : André , Rayssa e Nicolas
--%>
<%@page import="modelDAO.CoordDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Coordenador"%>
<%@page import="modelDAO.FuncDAO"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Coordenador</title>
    <link href="../css/geral.css" rel="stylesheet" type="text/css"/>

</head>
<body>

    <img src="../imgs/logo-sem-fundo.png" alt="logotipo" id="logotipo"/>
    <div class="div-tabela">
<%
    Integer idCoord = (Integer) session.getAttribute("idCoord"); 
    if (idCoord == null) {
    response.sendRedirect("loginCoord.jsp");
    return;
}
    // Criar objeto Funcionario
    Coordenador c = new Coordenador();

    c.setNome(request.getParameter("cadnome"));
    
    c.setTel(request.getParameter("cadtel"));
    c.setEndereco(request.getParameter("cad_end"));
    c.setCep(request.getParameter("cadcep"));
    c.setEmail(request.getParameter("cademail"));  

    c.setSenha(request.getParameter("cadsenha"));

    String depart = request.getParameter("depart"); 
    /*O setor no banco usamos int , para mostrar o nome para o 
    user mas salvar pelo ID do departamento precisamos convertelo*/
    
    if (depart.equals("adm"))c.setFk_id_setor(1);
    else if (depart.equals("fin"))c.setFk_id_setor(2);
    else if (depart.equals("ti"))c.setFk_id_setor(3);
    else if (depart.equals("mkt"))c.setFk_id_setor(4);
    
    // DAO
    
    
    c.setId(idCoord);/*pegando o fk do coord. pela sessão logada*/
    
    /*mandando para o banco*/
    CoordDAO cdao = new CoordDAO();

    if (cdao.cadastrar(c)) {
        %>

        <h3>Coordenador cadastrado com sucesso!</h3>

<table class="tabela-setores">
    <thead>
        <tr>
            <th>Campo</th>
            <th>Registro</th>
        </tr>
    </thead>

    <tbody>
        <tr>
            <td>Nome</td>
            <td><%= c.getNome() %></td>
        </tr>

        <tr>
            <td>Email</td>
            <td><%= c.getEmail() %></td>
        </tr>

        <tr>
            <td>Senha</td>
            <td><%= c.getSenha() %></td>
        </tr>

        <tr>
            <td>Telefone</td>
            <td><%= c.getTel() %></td>
        </tr>

        <tr>
            <td>Endereço</td>
            <td><%= c.getEndereco() %></td>
        </tr>

        <tr>
            <td>CEP</td>
            <td><%= c.getCep() %></td>
        </tr>

        <tr>
            <td>Setor (ID)</td>
            <td><%= c.getFk_id_setor() %></td>
        </tr>
    </tbody>
</table>

<%
    } else {

        out.println("<h3>Erro ao cadastrar funcionário!</h3>");
    }
%>

</body>
</html>