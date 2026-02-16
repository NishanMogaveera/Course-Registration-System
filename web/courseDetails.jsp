<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<link rel="stylesheet" href="css/style.css">


<%
    if (session.getAttribute("sid") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int courseId = Integer.parseInt(request.getParameter("id"));

    Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM courses WHERE course_id=?"
    );

    ps.setInt(1, courseId);
    ResultSet rs = ps.executeQuery();
%>

<div class="container">
<h2>Course Details</h2>
 

<%
    if (rs.next()) {
%>

<h3><%= rs.getString("course_name") %></h3>

<p><b>Description:</b><br>
<%= rs.getString("description") %>
</p>

<p><b>Credits:</b> <%= rs.getInt("credits") %></p>
<p><b>Available Seats:</b> <%= rs.getInt("available_seats") %></p>

<br>
<a href="courses.jsp">Back to Courses</a>
</div>

<%
    }
%>
