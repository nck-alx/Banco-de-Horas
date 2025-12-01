
<%--
    Author     : André , Rayssa e Nicolas
--%>
<%@page import="modelDAO.UserDAO"%>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    UserDAO dao = new UserDAO();
    boolean resultado = dao.excluirFuncionario(id);

    if(resultado){
        out.println("<script>alert('Funcionário excluído com sucesso!'); window.location='excluirFuncionario.jsp';</script>");
    } else {
       System.out.println(resultado);
       out.println("<script>alert('Erro ao excluir funcionário!'); window.location='excluirFuncionario.jsp';</script>"); 
    }
%>

