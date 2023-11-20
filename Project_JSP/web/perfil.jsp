<%-- 
    Document   : perfil
    Created on : 20 nov 2023, 10:08:28
    Author     : marks
--%>

<%@page import="java.util.List"%>
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
        <title>JSP Page</title>
        <style>
            html
            {
                background-color: #0a3d62;
            }
            
            body
            {
                /*Totes les fonts de color blanc*/
                color: white;
            }
            
            header
            {
                display: flex;
                align-items: center;
            }
            
            .button {
                background-color: #e58e26;
                text-decoration: none;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                width: 15vw;
                transition: background-color 0.3s ease;
            }

            .button:hover {
                background-color: #b71540;
            }
            
            .edit
            {
                background-color: #f8c291;
                text-decoration: none;
                color: white;
                margin-left: 1vw;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                height: 3vh;
                width: 5vw;
                transition: background-color 0.3s ease;
            }
            
            .edit:hover 
            {
                background-color: #fad390;
            }
        </style>
    </head>
    <body>
        <%
            DBManager db = new DBManager();
            String usu_actual = (String) session.getAttribute("usuari");
            db.connect();

            Usuari user = db.getUsuari(usu_actual);
            usu_actual = user.getNick();     
        %>
        
        <form action="perfil.jsp">
            <header>
                <%  if (request.getParameter("canvi_nick") != null)
                    { %>
                        <h3>Usuari: <input type="text" name="update_nick"/></h3>
                        <input class="edit" type="submit" name="guardar" value="Guardar canvi"/>
                <%  }
                    else
                    {%>
                        <h3>Usuari: <%= usu_actual %></h3>
                        <input class="edit" type="submit" name="canvi_nick" value="Editar nom" />
                <%  }%>
            </header>

            <hr>
        
            <hr>
            
            <hr>
            <input class="button" type="submit" name="enrere" value="Tornar al menu"/>
        </form>
    </body>
</html>
