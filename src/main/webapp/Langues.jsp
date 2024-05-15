<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException, java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Langues</title>
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
        #languesTable {
            width: 100%;
            border-collapse: collapse;
        }
        #languesTable th, #languesTable td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        #languesTable th {
            background-color: #333;
            color: #fff;
        }
        .button {
            background-color: #007bff;
            color: #fff;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Langues</h1>
        <form action="Ajout_langues.jsp" method="POST">
            <button type="submit" class="button">Nouveau</button>
        </form>
        <form action="Langues.jsp" method="POST">
            <input style="margin-left: 800px;" type="text" id="searchField" name="searchField" placeholder="Rechercher...">
            <button type="submit" class="button">Rechercher</button>
            <br><br><br>
        </form>
        

        <table id="languesTable">
            <thead>
                <tr>
                    <th>Ordre</th>
                    <th>Code</th>
                    <th>Nom Complet</th>
                    <th>Date d'Inscription</th>
                    <th>Date de Début</th>
                    <th>Langue</th>
                    <th>Prix</th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody id="tableBody">
                <%  
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/sfe", "root", "");
                    String searchTerm = request.getParameter("searchField");
                    String sql = "SELECT ordre, CODE, Nom_Complet, Date_inscription, Date_debut, langue, Prix FROM langues ";
                    if (searchTerm != null && !searchTerm.isEmpty()) {
                        sql += "WHERE Nom_Complet LIKE ?";
                    }
                    
                    sql += " ORDER BY ordre";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    if (searchTerm != null && !searchTerm.isEmpty()) {
                        pstmt.setString(1, "%" + searchTerm + "%");
                    }
                    ResultSet rs = pstmt.executeQuery();
                    while (rs.next()) {
                    	int ordre = rs.getInt("ordre");
                        String CODE = rs.getString("CODE");
                        String Nom_Complet = rs.getString("Nom_Complet");
                        String Date_inscription = rs.getString("Date_inscription");
                        String Date_debut = rs.getString("Date_debut");
                        String langue = rs.getString("langue");
                        double Prix = rs.getDouble("Prix");
                %>
                        <tr>
                            <td><%= rs.getInt("ordre") %></td>
                            <td><%= rs.getString("CODE") %></td>
                            <td><%= rs.getString("Nom_Complet") %></td>
                            <td><%= rs.getString("Date_inscription") %></td>
                            <td><%= rs.getString("Date_debut") %></td>
                            <td><%= rs.getString("langue") %></td>
                            <td><%= rs.getDouble("Prix") %></td>
                            <td><button class="button" onclick="window.location.href='Fiche_langues.jsp?ordre=<%= ordre %>'">Fiche</button></td>
                            <td><button class="button">Modifier</button></td>
                            <td><button class="button" onclick="supprimer('<%= rs.getString("CODE") %>')">Supprimer</button></td>
                        </tr>
                <%  
                    }
                    rs.close();
                    pstmt.close();
                    conn.close();
                } catch (ClassNotFoundException | SQLException e) {
                    // Set error message attribute
                    request.setAttribute("errorMessage", "Erreur lors de la récupération des données : " + e.getMessage());
                    e.printStackTrace();
                }
                %>
            </tbody>
        </table>
    </div>
    <script>
        function supprimer(code) {
            const xhr = new XMLHttpRequest();
            const url = '/Gestion_de_cours_soutien/LanguesDeleteServlet'; // URL de votre servlet
            // Préparer les données à envoyer
            const params = new URLSearchParams();
            params.append('code', code);
            xhr.open('POST', url, true);
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            // Gérer la réponse de la requête
            xhr.onload = function() {
                if (xhr.status >= 200 && xhr.status < 400) {
                    const response = JSON.parse(xhr.responseText);
                    if (response.success) {
                        console.log('Suppression réussie');
                        // Rafraîchir la page actuelle après 2 secondes
                        setTimeout(function() {
                            window.location.reload(); // Recharger la page actuelle
                        }, 200); // 2 secondes de délai avant le rafraîchissement
                    } else {
                        console.error('Erreur lors de la suppression : ' + response.message);
                        // Afficher un message d'erreur à l'utilisateur
                    }
                } else {
                    console.error('Erreur lors de la requête : ' + xhr.status);
                    // Afficher un message d'erreur général en cas d'échec de la requête
                }
            };
            // Gérer les erreurs réseau
            xhr.onerror = function() {
                console.error('Erreur de réseau lors de la requête');
                // Afficher un message d'erreur en cas d'échec de la requête réseau
            };
            // Envoyer la requête avec les paramètres
            xhr.send(params);
        }
    </script>
</body>
</html>
