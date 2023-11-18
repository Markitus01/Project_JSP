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
                /*Totes les fonts de color blanc*/
                color: white;
            }
            
            .objectes
            {
                display: flex;
                
                a
                {
                    text-decoration: none;
                    color: inherit;
                }
                
                .objecte
                {
                    /*Fem que el ratoli assenyali cada objecte*/
                    cursor: pointer;
                    height: 70vh;
                    max-width: 20vw;
                    padding: 12px;
                    overflow-y: auto;
                    border-radius: 5px;
                    background-color: #4a69bd;
                    transition: background-color 0.3s ease;
                    margin: 1vw;
                    
                    img
                    {
                        display: block;
                        height: auto;
                        width: 100%;
                    }
                    
                    .desc
                    {
                        margin: 0;
                    }
                }
                
                .objecte:hover
                {
                    background-color: #6a89cc;
                }
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
        <div class="objectes">
            <%
                DBManager db = new DBManager();
                db.connect();
                
                for (Objecte o : db.getObjectes())
                {
                    out.print(
                      "<a href='item.jsp?id="+ o.getId() +"'>"
                    +   "<div class='objecte'>"
                    +       "<img src='"+ request.getContextPath() + o.getImg() +"'/>"
                    +       "<p>"+ o.getPreu() +"€ · "+ o.getNom() +"</p>"
                    +       "<hr>"
                    +       "<p>"+ o.getUsuari() +"</p>"
                    +       "<p class='desc'>"+ o.getDescripcio() +"</p>"
                    +   "</div>"
                    + "</a>");
                }
            %>
        </div>
        <hr>
        <a class="button" href="<%= request.getRequestURI() %>?logout=true">Logout</a>
    </body>
</html>
