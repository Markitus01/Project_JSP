<%-- 
    Document   : index
    Created on : 16 nov 2023, 15:45:54
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
            
            header
            {
                display: flex;
                justify-content: space-around;
            }
            
            select
            {
                cursor: pointer;
            }
            
            .objectes
            {
                height: 79vh;
                margin-top: 1vh;
                padding: 5px;
                border: 3px solid #60a3bc;
                border-radius: 15px;
                display: flex;
                justify-content: space-around;
                flex-wrap: wrap;
                align-content: space-between;
                overflow-y: auto;
                
                a
                {
                    text-decoration: none;
                    color: inherit;
                }
                
                .objecte
                {
                    /*Fem que el ratoli assenyali cada objecte*/
                    cursor: pointer;
                    height: 40vh;
                    width: 14vw;
                    padding: 12px;
                    margin-top: 1vh;
                    overflow-y: auto;
                    border: 1px solid black;
                    border-radius: 5px;
                    background-color: #4a69bd;
                    transition: background-color 0.3s ease;
                    
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
            
            .perfil
            {
                background-color: #78e08f;
                text-decoration: none;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                width: 15vw;
                transition: background-color 0.3s ease;
            }
            
            .perfil:hover
            {
                background-color: #b8e994;
            }
        </style>
    </head>
    <body>
        <% 
            DBManager db = new DBManager();
            String usu_actual = null;
            
            //Si prem el botó de perfil
            if (request.getParameter("perfil") != null)
            {
                response.sendRedirect("perfil.jsp");
                return;
            }
            
            //Si prem el botó de logout
            if (request.getParameter("logout") != null)
            {
                //Eliminem la sessió i redirigim
                session.invalidate();
                response.sendRedirect("index.html");
                return;
            }
            
            //Si ha entrat via login
            if (session.getAttribute("usuari") != null)
            {
                usu_actual = (String) session.getAttribute("usuari");
                db.connect();
                
                Usuari user = db.getUsuari(usu_actual);
                usu_actual = user.getNick();     
            }
            else if ("true".equals(request.getParameter("invitat"))) //Si ha entrat com invitat 
            {
                usu_actual = "Invitat";
                session.setAttribute("usuari", usu_actual);
            }
            else //Si intenten colar-se per url reenviem a la zona inicial
            {
                response.sendRedirect("index.html");
                return;
            }
        %>    
        <form action="index.jsp" method="post">
            <header>
                <h3>Usuari: <%= usu_actual %></h3>
                <%  if (!usu_actual.equals("Invitat"))
                    {%>
                    <input class="perfil" type="submit" name="perfil" value="Perfil" />
                <%  }%>
            </header>
            
            <br>
            Categoria: 
            <select class="categoria" name="categoria" onchange="this.form.submit()">
                <option value="totes">*</option>
                <%
                    db.connect();
                    //Obtenim la categoría seleccionada
                    String catSelec = request.getParameter("categoria");

                    for (Categoria cat : db.getCategories())
                    {
                        String selected = "";
                        //Afegim selected a la categoria seleccionada per a que es mantingui seleccionada després del onchange
                        if (catSelec != null && catSelec.equals(String.valueOf(cat.getId())))
                        {
                            selected = "selected";
                        }
                        out.print("<option value='"+ cat.getId() +"' "+ selected +">"+ cat.getNom() +"</option>");
                    }
                    
                %>
            </select>
            
            <%  //Només mostrem categoría si hi ha escollida una concreta
                if (request.getParameter("categoria") != null && !("totes").equals(request.getParameter("categoria")))
                {%>
                    Subcategoria:
                    <select class="subcategoria" name="subcategoria" onchange="this.form.submit()">
                        <option value="totes">*</option>
                        <%
                            if (request.getParameter("categoria") != null && !("totes").equals(request.getParameter("categoria")))
                            {
                                int categoria = Integer.parseInt(request.getParameter("categoria"));
                                //Obtenim la subcategoría seleccionada
                                String subSelec = request.getParameter("subcategoria");

                                for (Subcategoria sub : db.getSubcategories(categoria))
                                {
                                    String selected = "";
                                    //Afegim selected a la subcategoria seleccionada per a que es mantingui seleccionada després del onchange
                                    if (subSelec != null && subSelec.equals(String.valueOf(sub.getId())))
                                    {
                                        selected = "selected";
                                    }
                                    out.print("<option value='"+ sub.getId() +"' "+ selected +">"+ sub.getNom() +"</option>");
                                }
                            }
                        %>
                    </select>
            <%  }%>
            
            <div class="objectes">
                <%
                    String cat = request.getParameter("categoria");
                    String subcat = request.getParameter("subcategoria");
                    List<Objecte> objectes = null;
                    
                    if (cat == null || cat.equals("totes"))
                    {
                        objectes = db.getObjectes();
                    }
                    else if (subcat == null || subcat.equals("totes"))
                    {
                        objectes = db.getObjectes(Integer.parseInt(cat));
                    }
                    else
                    {
                        objectes = db.getObjectes(Integer.parseInt(cat), Integer.parseInt(subcat));
                    }
                    
                    for (Objecte o : objectes)
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
                    
                    db.close();
                %>
            </div>
            <hr>
            <input type="submit" name="logout" value="Logout" class="button" />
        </form>
    </body>
</html>
