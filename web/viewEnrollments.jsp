<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<link rel="stylesheet" href="css/style.css">

<div class="container">
<h2>Course Enrollments</h2>

<table>
<tr>
<th>Student</th>
<th>Course</th>
</tr>

<%
Connection con = DBConnection.getConnection();
PreparedStatement ps = con.prepareStatement(
"SELECT s.name, c.course_name FROM registrations r " +
"JOIN students s ON r.student_id=s.student_id " +
"JOIN courses c ON r.course_id=c.course_id"
);
ResultSet rs = ps.executeQuery();

while(rs.next()){
%>
<tr>
<td><%= rs.getString("name") %></td>
<td><%= rs.getString("course_name") %></td>
</tr>
<% } %>
</table>
</div>
