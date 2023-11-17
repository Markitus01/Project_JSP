<%-- 
    Document   : index
    Created on : 16 nov 2023, 15:45:54
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
        <title>Menú</title>
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
        <% 
            String usu_actual = null;
            
            if (session.getAttribute("usuari") != null)
            {
                usu_actual = (String) session.getAttribute("usuari");
            }
            else
            {
                usu_actual = "Invitat";
                session.setAttribute("usuari", usu_actual);
            }
            
            if ("true".equals(request.getParameter("logout")))
            {
                session.setAttribute("usuari", null);
                response.sendRedirect("index.html");
            }
        %>     
        <h3>Usuari: <%= usu_actual %></h3>
        <div class="objectes">
            <%
                DBManager db = new DBManager();
                db.connect();
                
                for (Objecte o : db.getObjectes())
                {
                    out.print(
                      "<div class='objecte'>"
                    +   "<img src='"+ o.getImg() +"'/>"
                    +   "<p>"+ o.getPreu() +"€ · "+ o.getNom() +"</p>"
                    + "</div>");
                }
            %>
        </div>
        <hr>
        <a href="<%= request.getRequestURI() %>?logout=true">Torna enrere</a>
    </body>
</html>
