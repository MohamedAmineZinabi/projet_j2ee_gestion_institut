<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modify Language</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #413B3B; /* Dark gray background */
            color: #fff; /* White text */
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 20px auto;
            padding: 20px;
            background-color: #696969; /* Dark gray form background */
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
        }
        label {
            font-weight: bold;
        }
        input[type="text"], select {
            width: 100%;
            padding: 8px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            background-color: #696969; /* Dark gray input background */
            color: #fff; /* White text */
        }
        button {
            background-color: #007bff; /* Blue button */
            color: #fff;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            margin-right: 10px;
        }
        button:hover {
            background-color: #0056b3; /* Dark blue on hover */
        }
        #message {
            margin-top: 10px;
            padding: 10px;
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Modify Language</h1>
        <div id="message"></div> <!-- Div to display success message -->
        <%
            // Database connection details
            String url = "jdbc:mysql://localhost/sfe";
            String username = "root";
            String password = "";
            Connection connection = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // Load the MySQL driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                // Establish the connection
                connection = DriverManager.getConnection(url, username, password);
                
                // Query to fetch data based on id
                String sql = "SELECT CODE, Nom_Complet, Date_inscription, Date_debut, langue, Prix FROM langues WHERE ordre = ?";
                pstmt = connection.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(request.getParameter("ordre")));
                rs = pstmt.executeQuery();
                
                // If data is found, display it in the fields
                if (rs.next()) {
                    String code = rs.getString("CODE");
                    String nomComplet = rs.getString("Nom_Complet");
                    String dateInscription = rs.getString("Date_inscription");
                    String dateDebut = rs.getString("Date_debut");
                    String langue = rs.getString("langue");
                    double prix = rs.getDouble("Prix");
        %>
                    <form action="ModifierLanguesServlet" method="post" onsubmit="displaySuccessMessage()">
                        <input type="hidden" name="ordre" value="<%= request.getParameter("ordre") %>">
                        <div>
                            <label for="code">Code:</label>
                            <input type="text" id="code" name="code" value="<%= code %>" readonly>
                        </div>
                        <div>
                            <label for="nomComplet">Nom Complet:</label>
                            <input type="text" id="nomComplet" name="nomComplet" value="<%= nomComplet %>">
                        </div>
                        <div>
                            <label for="dateInscription">Date d'Inscription:</label>
                            <input type="text" id="dateInscription" name="dateInscription" value="<%= dateInscription %>">
                        </div>
                        <div>
                            <label for="dateDebut">Date de Début:</label>
                            <input type="text" id="dateDebut" name="dateDebut" value="<%= dateDebut %>">
                        </div>
                        <div>
                            <label for="langue">Langue:</label>
                            <select id="langue" name="langue">
                                <option value="français" <%= "français".equals(langue) ? "selected" : "" %>>Français</option>
                                <option value="anglais" <%= "anglais".equals(langue) ? "selected" : "" %>>Anglais</option>
                                <option value="espagnol" <%= "espagnol".equals(langue) ? "selected" : "" %>>Espagnol</option>
                                <option value="italien" <%= "italien".equals(langue) ? "selected" : "" %>>Italien</option>
                                <option value="allemand" <%= "allemand".equals(langue) ? "selected" : "" %>>Allemand</option>
                            </select>
                        </div>
                        <div>
                            <label for="prix">Prix:</label>
                            <input type="text" id="prix" name="prix" value="<%= prix %>">
                        </div>
                        <button type="submit">Modify</button>
                        <button type="button" onclick="window.location.href='Langues.jsp'">Back</button>
                    </form>
        <%
                } else {
                    // If no data found for the specified id
                    out.println("No data found for the specified ordre.");
                }
            } catch (ClassNotFoundException | SQLException e) {
                // Handle exceptions
                out.println("Error: " + e.getMessage());
            } finally {
                // Close resources
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (connection != null) connection.close();
                } catch (SQLException e) {
                    out.println("Error closing database resources: " + e.getMessage());
                }
            }
        %>
    </div>
    <script>
        // Function to handle form submission
        function submitForm(event) {
            // Prevent the default form submission behavior
            event.preventDefault();
            
            // Display success message
            displaySuccessMessage();
        }

        // Function to display success message
        function displaySuccessMessage() {
            var messageDiv = document.getElementById("message");
            messageDiv.innerHTML = "Language data modified successfully.";
        }
    </script>
</body>
</html>
