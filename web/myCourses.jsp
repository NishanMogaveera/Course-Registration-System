<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<link rel="stylesheet" href="css/style.css">

<%
    if (session.getAttribute("sid") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int studentId = (int) session.getAttribute("sid");

    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(
        "SELECT c.course_name, c.credits " +
        "FROM courses c " +
        "JOIN registrations r ON c.course_id = r.course_id " +
        "WHERE r.student_id = ?"
    );

    ps.setInt(1, studentId);
    ResultSet rs = ps.executeQuery();
%>

<div class="container"> 
<h2>My Registered Courses</h2>

<table border="1" cellpadding="8">
<tr>
    <th>Course Name</th>
    <th>Credits</th>
</tr>

<%
    boolean found = false;
    while (rs.next()) {
        found = true;
%>
<tr>
    <td><%= rs.getString("course_name") %></td>
    <td><%= rs.getInt("credits") %></td>
</tr>
<%
    }
%>

</table>

<%
    if (!found) {
%>
    <p>You have not registered for any course yet.</p>
<%
    }
%>

<br>
<a href="courses.jsp">Back</a>
</div>
