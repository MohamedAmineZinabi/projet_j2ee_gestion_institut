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

@WebServlet("/CompteServlet")
public class CompteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found.");
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ancienMotDePasse = request.getParameter("ancienMotDePasse");
        String nouveauMotDePasse = request.getParameter("nouveauMotDePasse");
        String confirmationMotDePasse = request.getParameter("confirmationMotDePasse");

        System.out.println("Ancien mot de passe : " + ancienMotDePasse);
        System.out.println("Nouveau mot de passe : " + nouveauMotDePasse);
        System.out.println("Confirmation du nouveau mot de passe : " + confirmationMotDePasse);

        if (nouveauMotDePasse.equals(confirmationMotDePasse)) {
            if (verifierAncienMotDePasse(ancienMotDePasse)) {
                System.out.println("Ancien mot de passe correct.");
                if (changerMotDePasseDansBaseDeDonnees(nouveauMotDePasse)) {
                    System.out.println("Mot de passe changé avec succès.");
                    // Password changed successfully
                    response.sendRedirect("Home.html?success=true");
                } else {
                    // Error changing password
                    System.out.println("Erreur lors du changement de mot de passe.");
                    request.setAttribute("errorMessage", "Erreur lors du changement de mot de passe.");
                    request.getRequestDispatcher("Compte.jsp").forward(request, response);
                }
            } else {
                // Incorrect old password
                System.out.println("Mot de passe incorrect. Veuillez réessayer.");
                request.setAttribute("errorMessage", "Mot de passe incorrect. Veuillez réessayer.");
                request.getRequestDispatcher("Compte.jsp").forward(request, response);
            }
        } else {
            // New passwords don't match
            System.out.println("Les nouveaux mots de passe ne correspondent pas.");
            request.setAttribute("errorMessage", "Les nouveaux mots de passe ne correspondent pas.");
            request.getRequestDispatcher("Compte.jsp").forward(request, response);
        }
    }

    private boolean verifierAncienMotDePasse(String ancienMotDePasse) {
        String connectionStr = "jdbc:mysql://localhost/sfe";
        String username = "root";
        String password = "";

        try (Connection connection = DriverManager.getConnection(connectionStr, username, password);
             PreparedStatement statement = connection.prepareStatement("SELECT password FROM compte WHERE user = ?")) {
            statement.setString(1, "admin"); // Assuming 'admin' is the user for whom password is being verified

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    String motDePasseBD = resultSet.getString("password");

                    // Comparer le mot de passe de la base de données avec l'ancien mot de passe fourni
                    return ancienMotDePasse.equals(motDePasseBD);
                } else {
                    System.out.println("Aucun utilisateur trouvé dans la base de données.");
                    return false;
                }
            }
        } catch (SQLException e) {
            System.out.println("Erreur lors de la connexion à la base de données pour vérifier l'ancien mot de passe : " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private boolean changerMotDePasseDansBaseDeDonnees(String nouveauMotDePasse) {
        // Implement your logic to update password in the database here
        String connectionStr = "jdbc:mysql://localhost/sfe";
        String username = "root";
        String password = "";

        try {
            System.out.println("Tentative de connexion à la base de données...");
            Connection connection = DriverManager.getConnection(connectionStr, username, password);
            System.out.println("Connexion réussie à la base de données.");

            PreparedStatement statement = connection.prepareStatement("UPDATE compte SET password = ? WHERE user = ?");
            statement.setString(1, nouveauMotDePasse);
            statement.setString(2, "admin"); // Assuming 'admin' is the user for whom password is being updated
            int rowsAffected = statement.executeUpdate();

            System.out.println("Nombre de lignes affectées : " + rowsAffected);

            statement.close();
            connection.close();

            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Erreur lors de la connexion à la base de données : " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}