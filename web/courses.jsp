<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<link rel="stylesheet" href="css/style.css">


<%
    if (session.getAttribute("sid") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM courses");
    ResultSet rs = ps.executeQuery();
%>

<div class="top-bar">
    <span>Welcome, <%= session.getAttribute("username") %></span><br>
    <a href="studentProfile.jsp">Profile</a>
    <a href="myCourses.jsp">My Courses</a>
    <a href="LogoutServlet">Logout</a>
</div>





<div class="container">
<h2>Available Courses</h2>


<form action="payment.jsp" method="post">
<table border="1" cellpadding="8">
    <tr>
        <th>Select</th>
        <th>Course Name</th>
        <th>Credits</th>
        <th>Available Seats</th>
    </tr>

<%
    while (rs.next()) {
        
%>
    <tr>
        <td>
            <input type="radio" name="courseId"
                   value="<%= rs.getInt("course_id") %>" required>
        </td>
        <td>
        <a href="courseDetails.jsp?id=<%= rs.getInt("course_id") %>">
        <%= rs.getString("course_name") %>
        </a>
        </td>
        <td><%= rs.getInt("credits") %></td>
        <td><%= rs.getInt("available_seats") %></td>
    </tr>
<%
    }
%>
</table>

<br>
<input type="submit" value="Enroll Course">

<a href="LogoutServlet">Logout</a>


</form>
</div>
