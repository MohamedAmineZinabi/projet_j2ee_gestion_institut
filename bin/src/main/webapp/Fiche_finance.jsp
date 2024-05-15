<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.PreparedStatement, java.sql.SQLException , java.sql.ResultSet, java.sql.Connection, java.sql.DriverManager" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fiche d'inscription</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        .header {
            background-color: #696969;
            color: white;
            padding: 20px;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .button-group {
            margin-top: 20px;
        }
    </style>
</head>
<body>
  <div class="container">
                <div class="header">
            <h1 class="mb-0">Fiche d'inscription</h1>
        </div>
        <div class="row">
    
    <% 
        // Récupérer l'ordre depuis les paramètres d'URL
        String ordreParam = request.getParameter("ordre");
        int ordre = Integer.parseInt(ordreParam);
        
        // Déclaration des variables JDBC
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Connexion à la base de données et requête pour récupérer les données associées à l'ordre
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/sfe", "root", "");

            String sql = "SELECT * FROM finance WHERE ordre = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ordre);
            rs = pstmt.executeQuery();

            // Initialisation des variables pour stocker les données du ResultSet
            String code = "";
            String nomComplet = "";
            String dateInscription = "";
            String dateDebut = "";
            double prix = 0.0;
            String september = "";
            String october = "";
            String novembre = "";
            String decembre = "";
            String janvier = "";
            String fevrier = "";
            String mars = "";
            String avril = "";
            String mai = "";
            String juin = "";
            String juillet = "";

            if (rs.next()) {
                // Récupérer les données du ResultSet
                code = rs.getString("CODE");
                nomComplet = rs.getString("Nom_Complet");
                dateInscription = rs.getString("Date_inscription");
                dateDebut = rs.getString("Date_debut");
                prix = rs.getDouble("Prix");
                september = rs.getString("septembre");
                october = rs.getString("octobre");
                novembre = rs.getString("novembre");
                decembre = rs.getString("decembre");
                janvier = rs.getString("janvier");
                fevrier = rs.getString("fevrier");
                mars = rs.getString("mars");
                avril = rs.getString("avril");
                mai = rs.getString("mai");
                juin = rs.getString("juin");
                juillet = rs.getString("juillet");
                
                String updateSql = "UPDATE finance SET septembre=?, octobre=?, novembre=?, decembre=?, " +
                        "janvier=?, fevrier=?, mars=?, avril=?, mai=?, juin=?, juillet=? " +
                        "WHERE CODE=?";
     PreparedStatement updateStatement = conn.prepareStatement(updateSql);
     updateStatement.setString(1, september);
     updateStatement.setString(2, october);
     updateStatement.setString(3, novembre);
     updateStatement.setString(4, decembre);
     updateStatement.setString(5, janvier);
     updateStatement.setString(6, fevrier);
     updateStatement.setString(7, mars);
     updateStatement.setString(8, avril);
     updateStatement.setString(9, mai);
     updateStatement.setString(10, juin);
     updateStatement.setString(11, juillet);
     updateStatement.setString(12, code);
                %>
              
        
            <div class="col-md-4">
                <div class="form-group">
                    <label for="code">Code</label>
                    <input type="text" class="form-control" id="code" value="<%= code %>" readonly>
                </div>
                <div class="form-group">
                    <label for="name">Nom et Prénom</label>
                    <input type="text" class="form-control" id="name" value="<%= nomComplet %>" readonly>
                </div>
                <div class="form-group">
                    <label for="year">Année Scolaire</label>
                    <input type="text" class="form-control" id="year" >
                </div>
                <div class="form-group">
                    <label for="cin">CIN</label>
                    <input type="text" class="form-control" id="cin" >
                </div>
                 <div class="form-group">
                    <label for="october">Octobre</label>
                    <input type="text" class="form-control" id="october" value="<%= october %>">
                </div>
                 <div class="form-group">
                    <label for="janvier">Janvier</label>
                    <input type="text" class="form-control" id="janvier" value="<%= janvier %>">
                </div>
                 <div class="form-group">
                    <label for="avril">Avril</label>
                    <input type="text" class="form-control" id="avril" value="<%= avril %>">
                </div>
                 <div class="form-group">
                    <label for="juillet">Juillet</label>
                    <input type="text" class="form-control" id="juillet" value="<%= juillet %>">
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <label for="birthdate">Date de Naissance</label>
                    <input type="text" class="form-control" id="birthdate">
                </div>
                <div class="form-group">
                    <label for="tel">N° Tél</label>
                    <input type="text" class="form-control" id="tel">
                </div>
                <div class="form-group">
                    <label for="address">Adresse</label>
                    <input type="text" class="form-control" id="address">
                </div>
                <div class="form-group">
                    <label for="branch">Filière</label>
                    <input type="text" class="form-control" id="branch" value="Technicien spécialisé en finance et comptabilité" readonly>
                </div>
                 <div class="form-group">
                    <label for="novembre">November</label>
                    <input type="text" class="form-control" id="novembre" value="<%= novembre %>">
                </div>
                <div class="form-group">
                    <label for="fevrier">Février</label>
                    <input type="text" class="form-control" id="fevrier" value="<%= fevrier %>">
                </div>
                <div class="form-group">
                    <label for="mai">Mai</label>
                    <input type="text" class="form-control" id="mai" value="<%= mai %>">
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <label for="start-date">Date de Début</label>
                    <input type="text" class="form-control" id="start-date" value="<%= dateDebut %>" readonly>
                </div>
                <div class="form-group">
                    <label for="birthplace">Lieu de naissance</label>
                    <input type="text" class="form-control" id="birthplace" >
                </div>
                <div class="form-group">
                    <label for="inscription-date">Date d'inscription</label>
                    <input type="text" class="form-control" id="inscription-date" value="<%= dateInscription %>" readonly>
                </div>
                <div class="form-group">
                    <label for="september">Septembre</label>
                    <input type="text" class="form-control" id="september" value="<%= september %>">
                </div>
                 <div class="form-group">
                    <label for="decembre">Décembre</label>
                    <input type="text" class="form-control" id="decembre" value="<%= decembre %>">
                </div>
                 <div class="form-group">
                    <label for="mars">Mars</label>
                    <input type="text" class="form-control" id="mars" value="<%= mars %>">
                </div>
                 <div class="form-group">
                    <label for="juin">Juin</label>
                    <input type="text" class="form-control" id="juin" value="<%= juin %>">
                </div>
                
            </div>
            </div>
              
            <% 
                
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace(); // Gestion de la classe de pilote JDBC non trouvée
        } catch (SQLException e) {
            e.printStackTrace(); // Gestion des erreurs SQL lors de l'exécution de la requête
        } finally {
            // Fermeture des ressources JDBC dans le bloc finally
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace(); // Gestion des erreurs lors de la fermeture des ressources
            }
        }
    %>
      
<div class="button-group">
            <button class="btn btn-primary" onclick="modifierInformations()">Modifier</button>
            <button class="btn btn-warning" onclick="imprimerDocument()">Imprimer</button>
        </div>
    </div>
    
    <!-- JavaScript for DatePicker (if needed) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-datepicker@1.9.0/dist/js/bootstrap-datepicker.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#birthdate, #start-date, #inscription-date').datepicker({
                format: 'yyyy/mm/dd',
                autoclose: true,
                todayHighlight: true
            });
        });

        function imprimerDocument() {
            try {
                // Initialize jsPDF explicitly from window object
                const doc = new window.jspdf.jsPDF();

                // Define document content
                const branch = document.getElementById('branch').value;
                const year = document.getElementById('year').value;
                const inscriptionDate = document.getElementById('inscription-date').value;
                const startDate = document.getElementById('start-date').value;
                const fullName = document.getElementById('name').value;
                const birthdate = document.getElementById('birthdate').value;
                const birthplace = document.getElementById('birthplace').value;
                const cin = document.getElementById('cin').value;
                const address = document.getElementById('address').value;
                const tel = document.getElementById('tel').value;
                const september = document.getElementById('september').value;
                const october = document.getElementById('october').value;
                const novembre = document.getElementById('novembre').value;
                const december = document.getElementById('decembre').value;
                const janvier = document.getElementById('janvier').value;
                const fevrier = document.getElementById('fevrier').value;
                const mars = document.getElementById('mars').value;
                const avril = document.getElementById('avril').value;
                const mai = document.getElementById('mai').value;
                const juin = document.getElementById('juin').value;
                const juillet = document.getElementById('juillet').value;

                // Set font size and style
                doc.setFontSize(13);

                doc.text("BULLETIN D’INSCRIPTION", 70, 10);

                doc.text("Intitulé de formation : " + branch, 20, 30);
                doc.text("Année scolaire : " + year, 20, 40);
                doc.text("Date d’inscription : " + inscriptionDate, 20, 50);
                doc.text("Date début : " + startDate, 20, 60);

                doc.text("Renseignements concernant le participant :", 10, 80);
                doc.text("Nom complet : " + fullName, 20, 100);
                doc.text("Né(e) le : " + birthdate + " à : " + birthplace, 20, 110);
                doc.text("CIN : " + cin, 20, 120);
                doc.text(" Adresse : " + address, 20, 130);
                doc.text("N° Tél : " + tel, 20, 140);

                const currentDate = new Date().toLocaleDateString('fr-FR');
                doc.text("Fait à Agadir le " + currentDate, 20, 160);

                
                doc.text("Règlement :", 10, 180);
                doc.text("Septembre : " + september + " , octobre : " + october + " , novembre : " + novembre, 20, 200);
                doc.text("Décembre : " + december + " , janvier : " + janvier + " , février : " + fevrier, 20, 210);
                doc.text("Mars : " + mars + " , avril : " + avril + ", mai : " + mai, 20, 220);
                doc.text("Juin : " + juin + ", juillet : " + juillet, 20, 230);

                const fileName = 'fiche_inscription_' + fullName + '.pdf';
                doc.save(fileName);
            } catch (error) {
                console.error("Error:", error);
                alert("Error: " + error.message);
            }
        }
        function modifierInformations() {
            // Récupérer les valeurs des champs à mettre à jour
            const code = document.getElementById('code').value;
            const septembre = document.getElementById('september').value;
            const octobre = document.getElementById('october').value;
            const novembre = document.getElementById('novembre').value;
            const decembre = document.getElementById('decembre').value;
            const janvier = document.getElementById('janvier').value;
            const fevrier = document.getElementById('fevrier').value;
            const mars = document.getElementById('mars').value;
            const avril = document.getElementById('avril').value;
            const mai = document.getElementById('mai').value;
            const juin = document.getElementById('juin').value;
            const juillet = document.getElementById('juillet').value;

            // Effectuer une requête AJAX pour mettre à jour les informations
            const xhr = new XMLHttpRequest();
            const url = '/Gestion_de_cours_soutien/FinanceDataServlet'; // URL de votre servlet de mise à jour

            // Préparer les données à envoyer
            const params = new URLSearchParams();
            params.append('code', code);
            params.append('september', septembre);
            params.append('october', octobre);
            params.append('novembre', novembre);
            params.append('decembre', decembre);
            params.append('janvier', janvier);
            params.append('fevrier', fevrier);
            params.append('mars', mars);
            params.append('avril', avril);
            params.append('mai', mai);
            params.append('juin', juin);
            params.append('juillet', juillet);

            xhr.open('POST', url, true);
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

            // Gérer la réponse de la requête
            xhr.onload = function() {
                if (xhr.status >= 200 && xhr.status < 400) {
                    // Succès : afficher le message
                    const response = JSON.parse(xhr.responseText);
                    console.log(response.message); // Affiche le message de succès ou d'échec
                    if (response.success) {
                        alert('Mise à jour réussie !');
                        // Actualiser la page ou effectuer d'autres actions après la mise à jour
                    } else {
                        alert('Échec de la mise à jour : ' + response.message);
                    }
                } else {
                    // Erreur : afficher un message d'erreur
                    console.error('Erreur lors de la requête : ' + xhr.status);
                    alert('Erreur lors de la requête : ' + xhr.status);
                }
            };

            // Gérer les erreurs réseau
            xhr.onerror = function() {
                console.error('Erreur réseau lors de la requête.');
                alert('Erreur réseau lors de la requête.');
            };

            // Envoyer la requête avec les paramètres
            xhr.send(params);
        }

    </script>
</body>
</html>
