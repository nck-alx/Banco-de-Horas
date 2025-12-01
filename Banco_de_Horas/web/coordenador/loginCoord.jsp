<%--
    Author     : André , Rayssa e Nicolas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Coordenador"%>
<%@page import="modelDAO.UserDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Time Bank - Login</title>
        <link href="../css/geral.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="../imgs/favicon.ico" type="image/x-icon">

    </head>
    <body>
        <img src="../imgs/logo-sem-fundo.png" alt="logotipo" id="logotipo"/>
       <%                     
            // Instância do Objeto 
            Coordenador c = new Coordenador();
            c.setEmail(request.getParameter("email_coord"));            
            c.setSenha(request.getParameter("senha_coord"));  
            
           
            //Consultar LOG
            UserDAO userDAO = new UserDAO();   
            
            Coordenador c_user = userDAO.LogarCoord(c);
            
            if (c_user == null){
                out.println("<script>alert('Registro Não Encontrado!');</script>");
                
                %>
                <h2 style="color: white;">Registro não encotrado!</h2>
                <%
            }
            else{
                session.setAttribute("idCoord", c_user.getId());
                session.setAttribute("idSetor", c_user.getFk_id_setor());


               %>
               <div class="div-menu-coord">   
                    <h2>Olá , <%= c_user.getNome() %>!</h2> 
                    <p>Selecione uma opção</p>
                    
                    <div class="bt-menu">
                    
                    <a href="consultGeral.jsp"><button>Listar Funcionários</button></a>
                    
                    <a href="consultNome.jsp"><button>Pesquisar Funcionário</button></a>
                  
                    <a href="cadastroCoord.html"><button>Cadastrar Coordenador</button></a>
                  
                    <a href="cadastroFunc.html"><button>Cadastrar Funcionário</button></a>
                    
                    <a href="consultarSetores.jsp"><button>Listar Setores</button></a>
                   
                    <a href="gerenciar_setor.jsp"><button>Alterar Setores</button></a>
                    
                   <a href="excluirFuncionario.jsp"><button>Excluir Funcionário</button></a>


                    </div>
                </div>
            <%
            }
            %>
       
        
    </body>
</html>
