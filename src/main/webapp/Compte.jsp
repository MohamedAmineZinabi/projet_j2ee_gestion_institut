<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compte</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #696969;
            color: #fff;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            margin: 0 auto;
            padding: 20px;
        }
        h1 {
            text-align: center;
        }
        label {
            color: #fff;
        }
        input[type="password"] {
            width: 100%;
            padding: 8px;
            margin: 5px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f8f8f8;
            color: #333;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
 
    <div class="container">
        <h1>Compte</h1>
        <form action="CompteServlet" method="POST">
            <label for="ancienMotDePasse">Ancien mot de passe:</label><br>
            <input type="password" id="ancienMotDePasse" name="ancienMotDePasse"><br>
            
            <label for="nouveauMotDePasse">Nouveau mot de passe:</label><br>
            <input type="password" id="nouveauMotDePasse" name="nouveauMotDePasse"><br>
            
            <label for="confirmationMotDePasse">Confirmation mot de passe:</label><br>
            <input type="password" id="confirmationMotDePasse" name="confirmationMotDePasse"><br>
            <%-- Check if errorMessage attribute is present --%>
        </form>
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div style="color: red;">
            <%= request.getAttribute("errorMessage") %>
        </div>
    <% } %>
            <input type="submit"  value="Modifier">
    </div>
</body>
</html>
