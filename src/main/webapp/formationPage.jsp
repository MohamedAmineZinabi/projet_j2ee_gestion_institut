<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException, java.sql.PreparedStatement" %>
<%@ page import="gestion_de_cours_soutien.FormationPageServlet" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formation Page</title>
    <style>
        body {
            background-color: #404040;
            color: white;
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        .section {
            margin-bottom: 30px;
        }
        .section h1 {
            font-size: 24px;
            margin-bottom: 10px;
        }
        .course-card {
            background-color: #404040;
            color: white;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .course-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .member-count {
            font-size: 16px;
        }
    </style>
</head>
<body>

    <div class="section">
        <h1>Formation professionnelle</h1>
        <% 
            List<String> courseTitles1 = Arrays.asList("Finance et Comptabilité", "Boulangerie et Patisserie");
            for (String courseTitle : courseTitles1) {
                String color = FormationPageServlet.getColorForCourse(courseTitle);
                int memberCount = FormationPageServlet.fetchMemberCount(courseTitle);
        %>
        <div class="course-card" style="background-color: <%=color%>;">
            <div class="course-title"><%=courseTitle%></div>
            <div class="member-count">Members: <%=memberCount%></div>
        </div>
        <% } %>
    </div>

    <div class="section">
        <h1>Formation continue</h1>
        <% 
            List<String> courseTitles2 = Arrays.asList("Langue", "Informatique");
            for (String courseTitle : courseTitles2) {
                String color = FormationPageServlet.getColorForCourse(courseTitle);
                int memberCount = FormationPageServlet.fetchMemberCount(courseTitle);
        %>
        <div class="course-card" style="background-color: <%=color%>;">
            <div class="course-title"><%=courseTitle%></div>
            <div class="member-count">Members: <%=memberCount%></div>
        </div>
        <% } %>
    </div>
</body>
</html>