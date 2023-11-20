<%-- 
    Document   : perfil
    Created on : 20 nov 2023, 10:08:28
    Author     : marks
--%>

<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.io.*, java.util.*, org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>

<%@page import="java.math.BigDecimal"%>
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
            
            .nou_obj
            {
                height: 30vh;
                margin-top: 1vh;
                padding: 5px;
                border: 3px solid #60a3bc;
                border-radius: 15px;
            }
            
            .objectes
            {
                height: 80vh;
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
            //Si vol tornar al menu
            if (request.getParameter("enrere") != null)
            {
                response.sendRedirect("index.jsp");
                return;
            }
            
            DBManager db = new DBManager();
            String usu_actual = (String) session.getAttribute("usuari");
            db.connect();
            
            //Quan guardi nom
            Usuari user_updt = db.getUsuari(usu_actual);
            if (request.getParameter("guardar") != null && !request.getParameter("update_nick").equals(""))
            {
                String nou_nick = request.getParameter("update_nick");
                
                user_updt.setNick(nou_nick);
                db.updateUsuari(user_updt);
            }
            
            Usuari user = db.getUsuari(usu_actual);
            usu_actual = user.getNick();
            
            //Quan inserti nou item
            if (request.getParameter("insertar") != null)
            {
                Objecte ins_obj = new Objecte();
                FileItem imatge = null;
                
                // Obtenim l'imatge
                Part imgPart = request.getPart("img");

                // Treiem el nom de l'arxiu
                String fileName = Paths.get(imgPart.getSubmittedFileName()).getFileName().toString();

                // Guardar el l'arxiu a images
                String uploadPath = "/images/" + fileName;
                imgPart.write(uploadPath);
                
                ins_obj.setUsuari(user.getMail());
                ins_obj.setImg(uploadPath);
                ins_obj.setNom(request.getParameter("nom"));
                ins_obj.setDescripcio(request.getParameter("desc"));
                ins_obj.setCategoria(Integer.parseInt(request.getParameter("categoria")));
                ins_obj.setSubcategoria(Integer.parseInt(request.getParameter("subcategoria")));
                ins_obj.setPreu(new BigDecimal(request.getParameter("preu")));
                
                db.insertObjecte(ins_obj);
            }
        %>
        
        <form action="perfil.jsp" method="post" enctype="multipart/form-data">
            <header>
                <%  if (request.getParameter("canvi_nick") != null)
                    { %>
                        <h3>Usuari: <input type="text" name="update_nick" /></h3>
                        <input class="edit" type="submit" name="guardar" value="Guardar canvi"/>
                <%  }
                    else
                    {%>
                        <h3>Usuari: <%= usu_actual %></h3>
                        <input class="edit" type="submit" name="canvi_nick" value="Editar nom" />
                <%  }%>
            </header>

            <hr>
            <h2>Afegir Objecte</h2>
            <div class="cat_obj">
                <p>Categoria · Subcategoria: 
                <select class="categoria" name="categoria" onchange="this.form.submit()">
                    <option value="totes" <% if ("totes".equals(selcat)) out.print("selected"); %>>*</option>
                    <%
                        db.connect();

                        for (Categoria cat : db.getCategories())
                        {
                            if (selcat.equals(String.valueOf(cat.getId()))) {
                                out.print("<option value='" + cat.getId() + "' selected>" + cat.getNom() + "</option>");
                            } else {
                                out.print("<option value='" + cat.getId() + "'>" + cat.getNom() + "</option>");
                            }
                        }
                    %>
                </select> ·
                
                <%  //Només mostrem categoría si hi ha escollida una concreta
                    if (request.getParameter("categoria") != null && !("totes").equals(request.getParameter("categoria")))
                    {%>
                        <select class="subcategoria" name="subcategoria" onchange="this.form.submit()">
                            <option value="totes" <% if ("totes".equals(selsubcat)) out.print("selected"); %>>*</option>
                            <%
                                if (request.getParameter("categoria") != null && !("totes").equals(request.getParameter("categoria")))
                                {
                                    int categoria = Integer.parseInt(request.getParameter("categoria"));

                                    for (Subcategoria sub : db.getSubcategories(categoria))
                                    {
                                        if (selsubcat.equals(String.valueOf(sub.getId()))) {
                                            out.print("<option value='" + sub.getId() + "' selected>" + sub.getNom() + "</option>");
                                        } else {
                                            out.print("<option value='" + sub.getId() + "'>" + sub.getNom() + "</option>");
                                        }
                                    }
                                }
                            %>
                        </select>
                <%  }
                %>
                </p>
            </div>
            
            <div class="nou_obj">
                <p>Imatge: <input type="file" name="img"/></p> 
                <p>Nom <input type="text" name="nom"/></p>
                <p>Descripcio: <input type="text" name="desc"/></p>
                <p>Preu: <input type="text" name="preu"/></p>
                <input type="submit" name="insertar" value="Guardar"/>
            </div>
            
            <hr>
            <h2>Inventari:</h2>
            <div class="objectes">
                <%
                    //Carreguem els objectes de l'usuari
                    for (Objecte o : db.getObjectesUsuari(user.getMail()))
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
            <input class="button" type="submit" name="enrere" value="Tornar al menu"/>
        </form>
    </body>
</html>
