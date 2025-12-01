<%--
    Author     : André , Rayssa e Nicolas
--%>
<%@page import="modelDAO.CoordDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Funcionario"%>
<%@page import="modelDAO.FuncDAO"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Funcionário</title>
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
    Funcionario func = new Funcionario();

    func.setNome(request.getParameter("funcnome"));
    func.setEmail(request.getParameter("funcmail"));
    func.setSenha(request.getParameter("funcsenha"));
    func.setTel(request.getParameter("functel"));
    func.setEndereco(request.getParameter("func_end"));
    func.setCep(request.getParameter("func_cep"));
    
    String func_dep = request.getParameter("func_dep"); 
    /*O setor no banco usamos int , para mostrar o nome para o 
    user mas salvar pelo ID do departamento precisamos convertelo*/
    
    if(func_dep.equals("adm")) func.setFk_id_setor(1);
    else if(func_dep.equals("fin")) func.setFk_id_setor(2);
    else if(func_dep.equals("ti")) func.setFk_id_setor(3);
    else if(func_dep.equals("mkt")) func.setFk_id_setor(4);
    
    // DAO
    
    
    func.setFk_id_coord(idCoord);/*pegando o fk do coord. pela sessão logada*/
    
    /*mandando para o banco*/
    CoordDAO cdao = new CoordDAO();

    if (cdao.cadastrarFunc(func)) {
        
%>
        <h3>Funcionário cadastrado com sucesso!</h3>

        <table class="tabela-setores">
            <thead>
            <tr><th>Campo</th><th>Registro</th></tr>
            </thead>
            
            <tbody>
            <tr><td><b>Nome</b></td>
                <td><%=func.getNome()%></td>
            </tr>
            
            <tr><td><b>Email</b></td>
                <td><%=func.getEmail()%></td>
            </tr>
  
            <tr><td><b>Senha</b></td>
                <td><%=func.getSenha()%></td>
            </tr>
            <tr><td><b>Telefone</b>
                </td><td><%=func.getTel()%></td>
            </tr>
            <tr><td><b>Endereço</b>
                </td><td><%=func.getEndereco()%></td>
            </tr>
            <tr><td><b>CEP</b></td>
                <td><%=func.getCep()%></td>
            </tr>
            <tr><td><b>Setor (ID)</b>
                </td><td><%=func.getFk_id_setor()%></td>
            </tr>
            </tbody>
        </table>
    </div>
      
<%
    } else {

        out.println("<h3>Erro ao cadastrar funcionário!</h3>");
    }
%>

</body>
</html>