<link rel="stylesheet" href="css/style.css">

<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<div class="container">
<h2>Admin Dashboard</h2>

<p>Welcome, Admin</p>

<a href="addCourse.jsp">Add Course</a><br><br>
<a href="manageCourses.jsp">Manage Courses</a><br><br>
<a href="viewEnrollments.jsp">View Enrollments</a><br><br>
<a href="LogoutServlet">Logout</a>
</div>
