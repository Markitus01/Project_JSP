<%-- 
    Document   : register
    Created on : 15 nov 2023, 13:16:44
    Author     : marks
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <style>
            .error-text {
                color: red;
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
                String mail = request.getParameter("mail");
                String nick = request.getParameter("nick");
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
                } %>
            <input name="reg" type="submit" value="Register"/>
        </form>
    </body>
</html>
