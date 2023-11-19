<%-- 
    Document   : item
    Created on : 18 nov 2023, 19:55:43
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
        <title>ª</title>
        <link rel="icon" type="image/png" href="images/icons/internationalist.png">
        <style>
            html
            {
                background-color: #0a3d62;
            }
            
            body {
                margin: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                height: 100vh;
                color: white;
            }
            
            h3
            {
                position: absolute;
                top: 1vh;
                left: 1vw;
            }
            
            .objecte
            {
                max-height: 70vh;
                max-width: 22vw;
                padding: 12px;
                border-radius: 5px;
                background-color: #4a69bd;
                overflow-y: auto;
                
                img
                {
                    display: block;
                    height: auto;
                    width: 100%;
                }
            }
            
            button {
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

            button:hover {
                background-color: #38ada9;
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
            
            // Comparem així per a que no salti el null pointer exception
            if ("true".equals(request.getParameter("logout")))
            {
                session.setAttribute("usuari", null);
                response.sendRedirect("index.html");
            }
        %>
        <h3>Usuari: <%= usu_actual %></h3>
        <%
            
            if (request.getParameter("id") != null && request.getParameter("id") != "")
            {
                int id_obj = Integer.parseInt(request.getParameter("id"));
                
                DBManager db = new DBManager();
                db.connect();
                Objecte item = db.getObjecte(id_obj);
                
                out.print(
                    "<div class='objecte'>"
                   +    "<h1>"+ item.getNom() +"</h1>"
                   +    "<img src='"+ request.getContextPath() + item.getImg() +"'/>"
                   +    "<h2>"+ item.getPreu() +"€</h2>"
                   +    "<hr>"
                   +    "<p>"+ item.getUsuari() +"</p>"
                   +    "<p>"+ item.getDescripcio() +"</p>"
                   +"</div>"
                );
            }
            else
            {
                response.sendRedirect("index.jsp");
            }
        %>
    </body>
</html>
