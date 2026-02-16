<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<link rel="stylesheet" href="css/style.css">

<%
    // session validation
    if (session.getAttribute("sid") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int studentId = (int) session.getAttribute("sid");

    Connection con = DBConnection.getConnection();

    // fetch student details
    PreparedStatement ps1 = con.prepareStatement(
        "SELECT * FROM students WHERE student_id=?"
    );
    ps1.setInt(1, studentId);
    ResultSet rs1 = ps1.executeQuery();

    // fetch course count and total credits
    PreparedStatement ps2 = con.prepareStatement(
        "SELECT COUNT(*) AS total_courses, " +
        "IFNULL(SUM(c.credits),0) AS total_credits " +
        "FROM registrations r " +
        "JOIN courses c ON r.course_id = c.course_id " +
        "WHERE r.student_id=?"
    );
    ps2.setInt(1, studentId);
    ResultSet rs2 = ps2.executeQuery();
%>

<div class="container">
<h2>Student Profile</h2>

<%
    if (rs1.next()) {
%>

<p><b>Student ID:</b> <%= rs1.getInt("student_id") %></p>
<p><b>Name:</b> <%= rs1.getString("name") %></p>
<p><b>Email:</b> <%= rs1.getString("email") %></p>

<%
    }

    if (rs2.next()) {
%>

<p><b>Registered Courses:</b> <%= rs2.getInt("total_courses") %></p>
<p><b>Total Credits:</b> <%= rs2.getInt("total_credits") %></p>

<%
    }
%>

<hr>

<a href="courses.jsp">Back to Courses</a> |
<a href="myCourses.jsp">My Courses</a> |
<a href="LogoutServlet">Logout</a>
</div>