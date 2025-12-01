<%--
    Author     : André , Rayssa e Nicolas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Funcionario"%>
<%@page import="modelDAO.FuncDAO"%>
<%@page import="java.time.*"%>
<%@page import="java.sql.*"%>
    
<%@page import="Config.ConectaBanco"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/geral.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="imgs/favicon.png" type="image/x-icon">
        <title>Time Now - REGISTRO</title>
       
    </head>
    <body>
        <div class="div-registros-ponto"

<%
    //*PEGANDO OS CAMPOS ID FUNC. E ID SETOR DO FUNC.*//

    int idFunc = (int) session.getAttribute("idFunc");
    int idSetor = (int) session.getAttribute("idSetor");

    FuncDAO fdao = new FuncDAO();
    
    //*CONDIÇÃO PARA SABER QUAL CAMPO PREENCHER*//
    /*metodos para o programa saber qual campo preencher , pega no banco qual campo 
    esta fazio , se entrada não foi preenchido ainda o sistema prrenche e assim por diante*/

    ResultSet rs = fdao.consultar_registro(idFunc);

    if (!rs.next()) {
        
        // nenhum registro hoje então registrar em  entrada
        fdao.Entrada(idFunc, idSetor);
        %>
        
        <h2 id="h2-ponto">Ponto registrado: ENTRADA !</h2>
        
        <%
        } 

    else {
        // se existe registro hoje , ver qual campo está vazio
        // GET IGUAL AO BANCO
        Time entrada = rs.getTime("entrada");
        Time intervalo = rs.getTime("pausa_inicio");
        Time fim_intervalo = rs.getTime("pausa_fim");
        Time saida = rs.getTime("saida");

        if (intervalo == null) {
            fdao.inicio_intervalo(idFunc);
%>

            <h2 id="h2-ponto">Ponto registrado: Intervalo !</h2>
            
<%
        } else if (fim_intervalo == null) {
            fdao.fim_intervalo(idFunc);
%>
            <h2 id="h2-ponto">Ponto registrado: FIM DO INTEVALO ! </h2>
<%
        } else if (saida == null) {
            fdao.registrarSaida(idFunc);
%>
            <h2 id="h2-ponto">Ponto registrado: SAÍDA !</h2>
<%
        } else {
%>
            <h2 id="h2-ponto">Todos os registros já foram feitos hoje !</h2>
<%            
        }
    }
%>

        </div>

    </body>
</html>
