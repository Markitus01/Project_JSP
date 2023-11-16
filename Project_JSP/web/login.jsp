<%-- 
    Document   : login
    Created on : 15 nov 2023, 13:16:12
    Author     : marks
--%>

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
        <% 
            if (session.getAttribute("registered") != null)
            { 
                session.setAttribute("registered", null);   %>
                <p>Usuari enregistrat correctament! Pots iniciar sessió:</p>
        <%  }
        %>
        <hr>
        <a href="index.html">Torna enrere</a>
    </body>
</html>
