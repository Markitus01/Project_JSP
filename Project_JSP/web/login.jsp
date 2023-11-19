<%-- 
    Document   : login
    Created on : 15 nov 2023, 13:16:12
    Author     : marks
--%>

<%@page import="mark.prac.Usuari"%>
<%@page import="mark.prac.Objecte"%>
<%@page import="mark.prac.Categoria"%>
<%@page import="mark.prac.Subcategoria"%>
<%@page import="mark.prac.mysql.DBManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/png" href="images/icons/internationalist.png">
        <title>Login</title>
        <style>
            html
            {
                background-color: #0a3d62;
            }
            
            body
            {
                color: white;
            }
            
            .error-text {
                color: red;
            }
            
            .button {
                background-color: #079992;
                color: white;
                padding: 10px;
                margin: 5px;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                width: 15vw;
                transition: background-color 0.3s ease;
            }

            .button:hover {
                background-color: #38ada9;
            }
            
            a
            {
                color: #b8e994;
            }
            
            a:visited {
                color: #e58e26;
            }

            a:hover {
                color: #60a3bc;
            }

            a:active {
                color: white;
            }
        </style>
    </head>
    <body>
        <h1>Login</h1>
        <form action="login.jsp" method="post">
            <% 
                if (session.getAttribute("registered") != null)
                { 
                    session.setAttribute("registered", null);   %>
                    <p>Usuari enregistrat correctament! Pots iniciar sessió:</p>
            <%  }  %>
            <p>Mail: <input type="text" name="mail" required /></p>
            <p>Pswd: <input type="password" name="pswd" required /></p>
            <% 
                if (request.getParameter("log") != null)
                {
                    DBManager db = new DBManager();
                    db.connect();
                    
                    String mail = request.getParameter("mail");
                    String password = request.getParameter("pswd");
                    Usuari usu_bd = db.getUsuari(mail);
                    
                    if (usu_bd != null)wadasda
                    {
                        if (usu_bd.getPswd().equals(password))
                        {
                            db.close();
                            session.setAttribute("usuari", usu_bd.getNick());
                            response.sendRedirect("index.jsp");
                        }
                        else
                        {
                            db.close(); %>
                            <p class="error-text">Contrasenya incorrecte!</p>
                    <%  }
                    }
                    else
                    { 
                        db.close(); %>
                        <p class="error-text">Aquest correu no es troba enregistrat!</p>
            <%      }
                }
            %>
            <input class="button" name="log" type="submit" value="Login"/>
            
            <hr>
            
            <a href="index.html">Torna enrere</a>
        </form>
    </body>
</html>
