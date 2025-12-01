<%--
    Author     : André , Rayssa e Nicolas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Funcionario"%>
<%@page import="modelDAO.UserDAO"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/geral.css" rel="stylesheet" type="text/css"/>
     
        <title>Time Bank - Login</title>
    </head>
    <body>
        <img src="../imgs/logo-sem-fundo.png" alt="logotipo" id="logotipo"/>
          <%                     
            // Instância do Objeto 
            Funcionario func = new Funcionario();
            func.setEmail(request.getParameter("email_func"));            
            func.setSenha(request.getParameter("senha_func"));  
            
           
            //Consultar LOG
            UserDAO userDAO = new UserDAO();   
            
            Funcionario func_user = userDAO.LogarFunc(func);
            
            if (func_user == null){
                
            %>
            
            
            <h1>Registro Não encontrado</h1>
            
            <%
            }
            
            else{
                session.setAttribute("idFunc", func_user.getId());
                session.setAttribute("idSetor", func_user.getFk_id_setor());


               %>
               <div class="div-menu-func">
                    <h2>Bem-vindo, <%= func_user.getNome() %>!</h2>
                    <p>Escolha uma opção</p>

                    <div class="div-menu-func-bt">
                    <a href="consultar_horas.jsp"><button>Saldo de Horas</button></a>
                    <br>
                    <br>
                    <a href="index_ponto.html"><button>Bater Ponto</button></a>
                    </div>
                </div>
            
       
            <%
            }
            %>
       
    </body>
</html>
