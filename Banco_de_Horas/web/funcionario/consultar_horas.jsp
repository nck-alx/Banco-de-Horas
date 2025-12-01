<%--
    Author     : André , Rayssa e Nicolas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelDAO.FuncDAO"%>
<%@page import="model.Funcionario"%>
<%@page import="java.util.List"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/geral.css" rel="stylesheet" type="text/css"/>
        <title>Time Bank - SALDO DE HORAS</title>
    </head>
    <body>
        <img src="../imgs/logo-sem-fundo.png" alt="logotipo" id="logotipo"/>
        <div class="div-tabela">
            <h2 id="h2-tabela">Saldo de Horas</h2>
        <%
            //*PEGANDO OS CAMPOS ID FUNC. E ID SETOR DO FUNC.*//
            
            int idFunc = (int) session.getAttribute("idFunc");
            int idSetor = (int) session.getAttribute("idSetor");

            FuncDAO f = new FuncDAO();
            //chamar metodo consultar saldo
            List<String[]> listaSaldo = f.consultarSaldo(idFunc);
            //chamar metodo total horas 
            String total = f.TotalHoras(idFunc);

  

        %>

        <table class="div-tab-horas">
        <thead>
            <tr>
                <th>Data</th>
                <th>Horas Trabalhadas</th>
                <th>Saldo</th>
            </tr>
        </thead>
        
            <%
                for (String[] i : listaSaldo){  
             %>  
        <tbody>
                 
          
                <tr>
                    <td><%=i[0]%></td> 

                    <td><%= i[1] %></td> 

                    <td><%=i[2] %></td> 
                </tr>
        </tbody>        
                <%
                   }

               %>
        
    </table>
               <br>
               <h2>Saldo de Horas: <%= total %></h2>

       
    </div>
    </body>
</html>
