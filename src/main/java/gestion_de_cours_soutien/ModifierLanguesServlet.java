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

@WebServlet("/ModifierLanguesServlet")
public class ModifierLanguesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ordreParam = request.getParameter("ordre");
        if (ordreParam == null || ordreParam.isEmpty()) {
            // Handle the case when the 'ordre' parameter is missing or empty
            response.getWriter().println("Error: 'ordre' parameter is missing or empty.");
            return;
        }

        int ordre;
        try {
            ordre = Integer.parseInt(ordreParam);
        } catch (NumberFormatException e) {
            // Handle the case when the 'ordre' parameter is not a valid integer
            response.getWriter().println("Error: 'ordre' parameter is not a valid integer.");
            return;
        }

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
            pstmt.setInt(1, ordre);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // If data is found, set attributes in request for JSP to use
                request.setAttribute("ordre", ordre);
                request.setAttribute("code", rs.getString("CODE"));
                request.setAttribute("nomComplet", rs.getString("Nom_Complet"));
                request.setAttribute("dateInscription", rs.getString("Date_inscription"));
                request.setAttribute("dateDebut", rs.getString("Date_debut"));
                request.setAttribute("langue", rs.getString("Langue"));
                request.setAttribute("prix", rs.getDouble("Prix"));
                request.getRequestDispatcher("/ModifierLangues.jsp").forward(request, response);
            } else {
                // If no data found for the specified id
                response.getWriter().println("No data found for the specified ordre.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            // Handle exceptions
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                response.getWriter().println("Error closing database resources: " + e.getMessage());
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int ordre = Integer.parseInt(request.getParameter("ordre"));
        String code = request.getParameter("code");
        String nomComplet = request.getParameter("nomComplet");
        String dateInscription = request.getParameter("dateInscription");
        String dateDebut = request.getParameter("dateDebut");
        String langue = request.getParameter("langue");
        double prix = Double.parseDouble(request.getParameter("prix"));

        // Database connection details
        String url = "jdbc:mysql://localhost/sfe";
        String username = "root";
        String password = "";

        Connection connection = null;
        PreparedStatement pstmt = null;

        try {
            // Load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish the connection
            connection = DriverManager.getConnection(url, username, password);

            // Update query to modify language data
            String sql = "UPDATE langues SET CODE=?, Nom_Complet=?, Date_inscription=?, Date_debut=?, langue=?, Prix=? WHERE ordre=?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, code);
            pstmt.setString(2, nomComplet);
            pstmt.setString(3, dateInscription);
            pstmt.setString(4, dateDebut);
            pstmt.setString(5, langue);
            pstmt.setDouble(6, prix);
            pstmt.setInt(7, ordre);

            // Execute the update
            int rowsAffected = pstmt.executeUpdate();

            // Check if update was successful
            if (rowsAffected > 0) {
                // Redirect back to ModifierLangue interface
                response.sendRedirect(request.getContextPath() + "/ModifierLanguesServlet?ordre=" + ordre);
                return; // Return to avoid further processing
            } else {
                // Print error message if update failed
                response.getWriter().println("Failed to modify language data.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            // Handle exceptions
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (pstmt != null) pstmt.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                response.getWriter().println("Error closing database resources: " + e.getMessage());
            }
        }
    }
}
