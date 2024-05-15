package gestion_de_cours_soutien;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FormationPageServlet")
public class FormationPageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost/sfe";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Business logic to fetch member count and determine color based on course title
        String courseTitle = request.getParameter("courseTitle");
        int memberCount = fetchMemberCount(courseTitle);
        String color = getColorForCourse(courseTitle);

        // Set attributes for JSP rendering
        request.setAttribute("memberCount", memberCount);
        request.setAttribute("color", color);

        // Forward to JSP for rendering
        request.getRequestDispatcher("formationPage.jsp").forward(request, response);
    }

    // Business logic methods

    public static int fetchMemberCount(String courseTitle) {
        // Database connection and query
        int memberCount = 0;
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             Statement statement = connection.createStatement()) {
            String query = "SELECT COUNT(*) FROM " + getTableNameForCourse(courseTitle);
            try (ResultSet resultSet = statement.executeQuery(query)) {
                if (resultSet.next()) {
                    memberCount = resultSet.getInt(1);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return memberCount;
    }

    public static String getColorForCourse(String courseTitle) {
        // Determine color based on course
        switch (courseTitle) {
            case "Finance et Comptabilité":
                return "blue";
            case "Boulangerie et Patisserie":
                return "purple";
            case "Langue":
                return "black";
            case "Informatique":
                return "orange";
            default:
                return "gray";
        }
    }

    public static String getTableNameForCourse(String courseTitle) {
        // Map course titles to database table names
        switch (courseTitle) {
            case "Finance et Comptabilité":
                return "finance";
            case "Boulangerie et Patisserie":
                return "boulangerie";
            case "Informatique":
                return "informatique";
            case "Langue":
                return "langues";
            default:
                return "";
        }
    }
}
