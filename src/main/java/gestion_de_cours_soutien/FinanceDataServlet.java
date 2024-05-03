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

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/FinanceDataServlet")
public class FinanceDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        JSONArray jsonArray = new JSONArray();
        JSONObject jsonResponse = new JSONObject();

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/sfe", "root", "");
             PreparedStatement stmt = conn.prepareStatement("SELECT ordre, CODE, Nom_Complet, Date_inscription, Date_debut, Prix FROM finance WHERE Nom_Complet LIKE ? ORDER BY ordre")) {

            String searchTerm = request.getParameter("searchTerm");
            stmt.setString(1, "%" + searchTerm + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("ordre", rs.getInt("ordre"));
                    jsonObject.put("CODE", rs.getString("CODE"));
                    jsonObject.put("Nom_Complet", rs.getString("Nom_Complet"));
                    jsonObject.put("Date_inscription", rs.getString("Date_inscription"));
                    jsonObject.put("Date_debut", rs.getString("Date_debut"));
                    jsonObject.put("Prix", rs.getDouble("Prix"));
                    jsonArray.put(jsonObject);
                }
            }

            jsonResponse.put("success", true);
            jsonResponse.put("data", jsonArray);
        } catch (SQLException e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Erreur lors de la récupération des données : " + e.getMessage());
        }

        try (PrintWriter out = response.getWriter()) {
            out.print(jsonResponse);
            out.flush();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        JSONObject jsonResponse = new JSONObject();

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/sfe", "root", "")) {
            String code = request.getParameter("code");
            String septembre = request.getParameter("september");
            String octobre = request.getParameter("october");
            String novembre = request.getParameter("novembre");
            String decembre = request.getParameter("decembre");
            String janvier = request.getParameter("janvier");
            String fevrier = request.getParameter("fevrier");
            String mars = request.getParameter("mars");
            String avril = request.getParameter("avril");
            String mai = request.getParameter("mai");
            String juin = request.getParameter("juin");
            String juillet = request.getParameter("juillet");

            String updateSql = "UPDATE finance SET septembre=?, octobre=?, novembre=?, decembre=?, " +
                               "janvier=?, fevrier=?, mars=?, avril=?, mai=?, juin=?, juillet=? " +
                               "WHERE CODE=?";
            
            try (PreparedStatement statement = conn.prepareStatement(updateSql)) {
                statement.setString(1, septembre);
                statement.setString(2, octobre);
                statement.setString(3, novembre);
                statement.setString(4, decembre);
                statement.setString(5, janvier);
                statement.setString(6, fevrier);
                statement.setString(7, mars);
                statement.setString(8, avril);
                statement.setString(9, mai);
                statement.setString(10, juin);
                statement.setString(11, juillet);
                statement.setString(12, code);

                int rowsAffected = statement.executeUpdate();

                jsonResponse.put("success", true);
                jsonResponse.put("message", "Mise à jour réussie");
            } catch (SQLException e) {
                e.printStackTrace();
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Erreur lors de la mise à jour des données : " + e.getMessage());
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Erreur de connexion à la base de données : " + ex.getMessage());
        }

        try (PrintWriter out = response.getWriter()) {
            out.print(jsonResponse);
            out.flush();
        }
    }
}