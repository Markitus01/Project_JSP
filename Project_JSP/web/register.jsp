<%-- 
    Document   : register
    Created on : 15 nov 2023, 13:16:44
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
        <title>Register</title>
        <style>
            html
            {
                background-color: #0a3d62;
            }
            
            body
            {
                color: white;
                margin: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
            }
            
            form
            {
                /*flex: 1;*/
                display: flex;
                flex-direction: column;
                align-items: center;
                height: 50vh;
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
        <h1>Register</h1>
        
        <!--Per declarar funcions a jsp hem de començar amb un simbol '!'-->
        <%!
            boolean pswdMatch(String password, String confirmPassword) {
                return password.equals(confirmPassword);
            }
        %>

        <%
            boolean sonIguals = false;
            
            if (request.getParameter("reg") != null)
            {
                String password = request.getParameter("pswd");
                String confirmPswd = request.getParameter("confirm_pswd");
                
                sonIguals = pswdMatch(password, confirmPswd);
            }    
        %>
        
        <form action="register.jsp" method="post">
            <p>Mail: <input name="mail" type="text" required/></p>
            <p>Nick: <input name="nick" type="text" required/></p>
            <p>Password: <input name="pswd" type="password" required/></p>
            <p>Confirm Pswd: <input name="confirm_pswd" type="password" required/></p>
            <%  if (request.getParameter("reg") != null){ 
                    if (!(sonIguals)){ %>
                        <p class="error-text">La contrasenya ha de coincidir!</p>
            <%      }
                    else{
                        DBManager db = new DBManager();

                        String mail = request.getParameter("mail");
                        String nick = request.getParameter("nick");
                        String password = request.getParameter("pswd");
                        
                        Usuari u = new Usuari();
                        u.setMail(mail);
                        u.setNick(nick);
                        u.setPswd(password);
                        db.connect();
                        if (db.insertUsuari(u))
                        {
                            session.setAttribute("registered", "registrat");
                            db.close();
                            response.sendRedirect("login.jsp");
                        }
                        else
                        { 
                            db.close(); %>
                            <p class="error-text">Aquest correu/nick ja es troba enregistrat!</p>
            <%          }
                    }
                } %>
            <input class="button" name="reg" type="submit" value="Register"/>
            
            <hr>
            <a href="index.html">Torna enrere</a>
        </form>
    </body>
</html>
