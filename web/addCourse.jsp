<link rel="stylesheet" href="css/style.css">

<div class="container">
<h2>Add Course</h2>

<form action="AddCourseServlet" method="post">
    Course Name:<br>
    <input type="text" name="name" required><br><br>

    Credits:<br>
    <input type="text" name="credits" required><br><br>

    Total Seats:<br>
    <input type="text" name="seats" required><br><br>

    Description:<br>
    <textarea name="desc"></textarea><br><br>

    <input type="submit" value="Add Course">
</form>
</div>
