package gestion_de_cours_soutien;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

/**
 * Servlet implementation class FinanceDeleteServlet
 */
@WebServlet("/LanguesDeleteServlet")
public class LanguesDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LanguesDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    response.setContentType("application/json");
	    JSONObject jsonResponse = new JSONObject();

	    // Récupérer le paramètre "code" qui spécifie l'élément à supprimer
	    String code = request.getParameter("code");

	    if (code == null || code.isEmpty()) {
	        jsonResponse.put("success", false);
	        jsonResponse.put("message", "Le paramètre 'code' est requis pour la suppression");
	    } else {
	        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/sfe", "root", "")) {
	            String deleteSql = "DELETE FROM langues WHERE CODE = ?";

	            try (PreparedStatement statement = conn.prepareStatement(deleteSql)) {
	                statement.setString(1, code);

	                int rowsAffected = statement.executeUpdate();

	                if (rowsAffected > 0) {
	                    jsonResponse.put("success", true);
	                    jsonResponse.put("message", "Suppression réussie");
	                } else {
	                    jsonResponse.put("success", false);
	                    jsonResponse.put("message", "Aucune entrée correspondante trouvée pour le code spécifié");
	                }
	            } catch (SQLException e) {
	                e.printStackTrace();
	                jsonResponse.put("success", false);
	                jsonResponse.put("message", "Erreur lors de la suppression des données : " + e.getMessage());
	            }
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	            jsonResponse.put("success", false);
	            jsonResponse.put("message", "Erreur de connexion à la base de données : " + ex.getMessage());
	        }
	    }

	    try (PrintWriter out = response.getWriter()) {
	        out.print(jsonResponse);
	        out.flush();
	    }
	}
}
