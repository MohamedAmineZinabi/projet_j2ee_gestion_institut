<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajout Boulangerie</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #000;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #696969;
            color: white;
            padding: 20px;
            margin-bottom: 20px;
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
            font-weight: bold;
        }
        input[type="text"], input[type="submit"] {
            width: calc(100% - 20px); /* 3 inputs par ligne */
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="text"]:nth-child(3n+1) {
            margin-right: 10px;
        }
        input[type="submit"] {
            width: 100%;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
  <div class="container">
                <div class="header">
            <h1 class="mb-0">Ajout Boulangerie</h1>
        </div></div>
        
<div class="container">
    <% String errorMessage = request.getParameter("errorMessage"); %>
    <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
        <div class="alert alert-danger" role="alert">
            <%= errorMessage %>
        </div>
    <% } %>
</div>
    
    <div class="container">
        <form action="AjoutBoulangerieServlet" method="post">
            <div class="form-group">
                <label for="ordre">Ordre:</label>
                <input type="text" id="ordre" name="ordre" class="form-control">
            </div>
            <div class="form-group">
                <label for="code">Code:</label>
                <input type="text" id="code" name="code" class="form-control">
            </div>
            <div class="form-group">
                <label for="nomComplet">Nom Complet:</label>
                <input type="text" id="nomComplet" name="nomComplet" class="form-control">
            </div>
            <div class="form-row">
                <div class="col">
                    <label for="dateInscription">Date d'Inscription:</label>
                    <input type="text" id="dateInscription" name="dateInscription" class="form-control datepicker">
                </div>
                <div class="col">
                    <label for="dateDebut">Date de Début:</label>
                    <input type="text" id="dateDebut" name="dateDebut" class="form-control datepicker">
                </div>
                <div class="col">
                    <label for="prix">Prix:</label>
                    <input type="text" id="prix" name="prix" class="form-control">
                </div>
            </div>
             
        <p style="text-align: center; color: red;font-weight: bold; font-size: larger;">Les numeros des recus pour chaque mois :</p>
    
            <div class="form-row">
                <div class="col">
                    <label for="septembre">Septembre:</label>
                    <input type="text" id="septembre" name="septembre" class="form-control">
                </div>
                <div class="col">
                    <label for="octobre">Octobre:</label>
                    <input type="text" id="octobre" name="octobre" class="form-control">
                </div>
                <div class="col">
                    <label for="novembre">Novembre:</label>
                    <input type="text" id="novembre" name="novembre" class="form-control">
                </div>
            </div>
            <div class="form-row">
                <div class="col">
                    <label for="decembre">Décembre:</label>
                    <input type="text" id="decembre" name="decembre" class="form-control">
                </div>
                <div class="col">
                    <label for="janvier">Janvier:</label>
                    <input type="text" id="janvier" name="janvier" class="form-control">
                </div>
                <div class="col">
                    <label for="fevrier">Février:</label>
                    <input type="text" id="fevrier" name="fevrier" class="form-control">
                </div>
            </div>
            <div class="form-row">
                <div class="col">
                    <label for="mars">Mars:</label>
                    <input type="text" id="mars" name="mars" class="form-control">
                </div>
                <div class="col">
                    <label for="avril">Avril:</label>
                    <input type="text" id="avril" name="avril" class="form-control">
                </div>
                <div class="col">
                    <label for="mai">Mai:</label>
                    <input type="text" id="mai" name="mai" class="form-control">
                </div>
            </div>
            <div class="form-row">
                <div class="col">
                    <label for="juin">Juin:</label>
                    <input type="text" id="juin" name="juin" class="form-control">
                </div>
                <div class="col">
                    <label for="juillet">Juillet:</label>
                    <input type="text" id="juillet" name="juillet" class="form-control">
                </div>
            </div>
            <input type="submit" value="Ajouter" class="btn btn-primary">
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    <script>
   
        $(document).ready(function(){
            $('.datepicker').datepicker({
                format: 'yyyy-mm-dd', // Format de date souhaité
                autoclose: true // Fermer automatiquement le sélecteur de date après la sélection
            });
        });
    </script>
</body>
</html>
