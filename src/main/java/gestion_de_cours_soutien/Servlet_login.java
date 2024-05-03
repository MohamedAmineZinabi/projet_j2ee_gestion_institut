package gestion_de_cours_soutien;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/Servlet_login")
public class Servlet_login extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Charger le pilote JDBC MySQL
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException("MySQL JDBC Driver not found.", e);
        }

        // Informations de connexion à la base de données MySQL
        String url = "jdbc:mysql://localhost/sfe";
        String dbUsername = "root";
        String dbPassword = "";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Établir la connexion à la base de données
            conn = DriverManager.getConnection(url, dbUsername, dbPassword);

            // Requête SQL pour vérifier les informations d'identification
            String sql = "SELECT * FROM conn WHERE user = ? AND password = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            rs = stmt.executeQuery();

            // Si une ligne est retournée, les informations d'identification sont valides
            if (rs.next()) {
                // Rediriger vers la page Home.html après connexion réussie
                response.sendRedirect("Home.html");
            } else {
                // Afficher un message d'erreur si l'authentification échoue
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<html><body><h3>Login failed. Please try again.</h3></body></html>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database access error.", e);
        } finally {
            // Fermer les ressources JDBC pour libérer les ressources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
