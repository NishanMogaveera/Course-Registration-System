<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<link rel="stylesheet" href="css/style.css">

<div class="container">
<h2>Manage Courses</h2>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Course Name</th>
        <th>Credits</th>
        <th>Available Seats</th>
        <th>Action</th>
    </tr>

<%
    Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM courses");
    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("course_id") %></td>
        <td><%= rs.getString("course_name") %></td>
        <td><%= rs.getInt("credits") %></td>
        <td><%= rs.getInt("available_seats") %></td>
        <td>
            <form action="<%= request.getContextPath() %>/DeleteCourseServlet" method="post"
                  onsubmit="return confirm('Are you sure you want to delete this course?');">
                <input type="hidden" name="courseId"
                       value="<%= rs.getInt("course_id") %>">
                <input type="submit" value="Delete">
            </form>
        </td>
    </tr>
<%
    }
%>
</table>

<br>

<a href="adminDashboard.jsp" >Back to Dashboard</a>
</div>
