package gestion_de_cours_soutien;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AjoutInformatiqueServlet")
public class AjoutInformatiqueServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found.");
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String connectionStr = "jdbc:mysql://localhost:3306/sfe";
        String username = "root";
        String password = "";

        Connection connection = null;

        try {
            connection = DriverManager.getConnection(connectionStr, username, password);

            String ordre = request.getParameter("ordre");
            String code = request.getParameter("code");
            String nomComplet = request.getParameter("nomComplet");
            String dateInscription = request.getParameter("dateInscription");
            String dateDebut = request.getParameter("dateDebut");
            String prix = request.getParameter("prix");
            String septembre = request.getParameter("septembre");
            String octobre = request.getParameter("octobre");
            String novembre = request.getParameter("novembre");
            String decembre = request.getParameter("decembre");
            String janvier = request.getParameter("janvier");
            String fevrier = request.getParameter("fevrier");
            String mars = request.getParameter("mars");
            String avril = request.getParameter("avril");
            String mai = request.getParameter("mai");
            String juin = request.getParameter("juin");
            String juillet = request.getParameter("juillet");

            if (ordre.isEmpty() || code.isEmpty() || nomComplet.isEmpty() || prix.isEmpty()
                    || dateInscription.isEmpty() || dateDebut.isEmpty()) {
                // Rediriger vers Finance.jsp avec un message d'erreur
                response.sendRedirect("Ajout_informatique.jsp?errorMessage=Veuillez%20remplir%20tous%20les%20champs.");
                return;
            }
            if (recordExists(connection, ordre, code)) {
                // Rediriger vers Finance.jsp avec un message d'erreur si l'enregistrement existe déjà
                response.sendRedirect("Ajout_informatique.jsp?errorMessage=Code%20ou%20ordre%20d%C3%A9j%C3%A0%20existant.");
                return;
            }

            String query = "INSERT INTO informatique (ordre, code, nom_complet, date_inscription, date_debut, prix, septembre, octobre, novembre, decembre, janvier, fevrier, mars, avril, mai, juin, juillet) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, ordre);
                preparedStatement.setString(2, code);
                preparedStatement.setString(3, nomComplet);
                preparedStatement.setString(4, dateInscription);
                preparedStatement.setString(5, dateDebut);
                preparedStatement.setString(6, prix);
                preparedStatement.setString(7, septembre);
                preparedStatement.setString(8, octobre);
                preparedStatement.setString(9, novembre);
                preparedStatement.setString(10, decembre);
                preparedStatement.setString(11, janvier);
                preparedStatement.setString(12, fevrier);
                preparedStatement.setString(13, mars);
                preparedStatement.setString(14, avril);
                preparedStatement.setString(15, mai);
                preparedStatement.setString(16, juin);
                preparedStatement.setString(17, juillet);

                preparedStatement.executeUpdate();
            }

            response.sendRedirect("Informatique.jsp"); // Rediriger vers une page de succès

        } catch (SQLException ex) {
            ex.printStackTrace();
            response.sendRedirect("Ajout_informatique.jsp"); // Rediriger vers une page d'erreur générale
        } finally {
            // Fermer la connexion dans le bloc finally pour s'assurer qu'elle est toujours fermée
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private boolean recordExists(Connection connection, String ordre, String code) {
        String query = "SELECT COUNT(*) FROM informatique WHERE Ordre = ? OR Code = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, ordre);
            statement.setString(2, code);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    return count > 0;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            // Gérer l'erreur de base de données ici, par exemple afficher un message d'erreur
        }

        return false;
    }
}
