<%-- 
    Document   : item
    Created on : 18 nov 2023, 19:55:43
    Author     : marks
--%>
<%@page import="java.math.BigDecimal"%>
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
            DBManager db = new DBManager();
            db.connect();
            String usu_actual = null;
            Usuari user = null;
            
            //Si vol tornar al perfil
            if (request.getParameter("enrere") != null)
            {
                response.sendRedirect("perfil.jsp");
                return;
            }
            
            if (session.getAttribute("usuari") != null)
            {
                usu_actual = (String) session.getAttribute("usuari");

                user = db.getUsuari(usu_actual);
                usu_actual = user.getNick(); 
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
                return;
            }
        %>
        <form action="item.jsp?id=<%=request.getParameter("id")%>" method="post">
        <h3>Usuari: <%= usu_actual %> · <input class="button" type="submit" name="enrere" value="Tornar al perfil"/></h3>
        <%
            //Comprovem que l'objecte existeix, si no fora
            if (request.getParameter("id") != null && request.getParameter("id") != "")
            {
                int id_obj = Integer.parseInt(request.getParameter("id"));

                Objecte item = db.getObjecte(id_obj);
                
                if (request.getParameter("update") != null) //Mostrar camps editables al update
                {
                    out.print(
                     "<div class='objecte'>"
                    +    "<h1>Nom: <input type='text' name='nom' value='" + item.getNom() + "'/></h1>"
                    +    "<img src='"+ request.getContextPath() + item.getImg() +"'/>"
                    +    "<p>Preu: <input type='text' name='preu' value='" + item.getPreu() + "'/></p>"
                    +    "<p>Cat: <input type='text' name='cat' value='" + item.getCategoria() + "'/> <br> "
                    +       "Subcat: <input type='text' name='subcat' value='" + item.getSubcategoria() + "'/></p>" 
                    +    "<hr>"
                    +    "<p>Desc: <textarea name='desc' rows='5' cols='50'>" + item.getDescripcio() + "</textarea></p>"
                    +    "<p> <input type='submit' name='guardar' value='Guardar'/></p>"
                    +"</div>");
                }
                else if (request.getParameter("guardar") != null) //Update objecte
                {
                    Objecte item_updt = item;
                    
                    item_updt.setNom(request.getParameter("nom"));
                    item_updt.setPreu(new BigDecimal(request.getParameter("preu")));
                    item_updt.setCategoria(Integer.parseInt(request.getParameter("cat")));
                    item_updt.setSubcategoria(Integer.parseInt(request.getParameter("subcat")));
                    item_updt.setDescripcio(request.getParameter("desc"));
                    
                    db.updateObjecte(item_updt);
                    item = db.getObjecte(item.getId());
                    response.sendRedirect("item.jsp?id=" + id_obj);
                    return;
                }
                else if (request.getParameter("delete") != null) //Eliminar objecte
                {
                    db.deleteObjecte(id_obj);
                    response.sendRedirect("perfil.jsp");
                    return;
                }
                else
                {
                    //Si el que veu l'item es el seu propietari:
                    if (user.getMail().equals(item.getUsuari()))
                    {
                        out.print(
                            "<div class='objecte'>"
                           +    "<h1>"+ item.getNom() +"</h1>"
                           +    "<img src='"+ request.getContextPath() + item.getImg() +"'/>"
                           +    "<h2>"+ item.getPreu() +"€</h2>"
                           +    "<h3> </h3>" 
                           +    "<hr>"
                           +    "<p>"+ user.getNick() +"</p>"
                           +    "<p>"+ item.getDescripcio() +"</p>"
                           +    "<p> <input type='submit' name='update' value='Update'/> <input type='submit' name='delete' value='Delete'/></p>"
                           +"</div>"
                        );
                    }
                    else
                    {
                        out.print(
                            "<div class='objecte'>"
                           +    "<h1>"+ item.getNom() +"</h1>"
                           +    "<img src='"+ request.getContextPath() + item.getImg() +"'/>"
                           +    "<h2>"+ item.getPreu() +"€</h2>"
                           +    "<h3> </h3>" 
                           +    "<hr>"
                           +    "<p>"+ user.getNick() +"</p>"
                           +    "<p>"+ item.getDescripcio() +"</p>"
                           +    "<p> <input type='submit' name='oferta' value='Oferta'/> <input type='submit' name='coment' value='Comentar'/></p>"
                           +"</div>"
                        );
                    }
                }
            }
            else
            {
                response.sendRedirect("index.jsp");
            }
            
            db.close();
        %>
        </form>
    </body>
</html>
