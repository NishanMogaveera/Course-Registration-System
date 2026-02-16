<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<link rel="stylesheet" href="css/style.css">

<script>
function showPaymentDetails(type) {
    document.getElementById("card").style.display = "none";
    document.getElementById("upi").style.display = "none";
    document.getElementById("net").style.display = "none";

    document.getElementById(type).style.display = "block";
}
</script>

<%
    if (session.getAttribute("sid") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int studentId = (int) session.getAttribute("sid");
    int courseId = Integer.parseInt(request.getParameter("courseId"));

    Connection con = DBConnection.getConnection();

    
    PreparedStatement checkPs = con.prepareStatement(
        "SELECT * FROM registrations WHERE student_id=? AND course_id=?"
    );
    checkPs.setInt(1, studentId);
    checkPs.setInt(2, courseId);

    ResultSet checkRs = checkPs.executeQuery();

    if (checkRs.next()) {
        response.sendRedirect("alreadyRegistered.jsp");
        return;
    }
    PreparedStatement ps = con.prepareStatement(
    "SELECT course_name, credits FROM courses WHERE course_id=?"
);
ps.setInt(1, courseId);
ResultSet rs = ps.executeQuery();

%>



<div class="container">  
<h2>Course Payment</h2>

<%
    if (rs.next()) {
%>

<p><b>Course Name:</b> <%= rs.getString("course_name") %></p>
<p><b>Credits:</b> <%= rs.getInt("credits") %></p>
<p><b>Amount:</b> &#8377;<%= rs.getInt("credits") * 1000 %></p>

<%
    }
%>

<hr>

<form action="EnrollServlet" method="post">
    <!-- send courseId forward -->
    <input type="hidden" name="courseId" value="<%= courseId %>">

    <h3>Select Payment Method</h3>

<input type="radio" name="paymentMode" value="Card"
       onclick="showPaymentDetails('card')" required>
Credit / Debit Card <br>

<div id="card" style="display:none;">
    <h4>Card Details</h4>
    Card Number:<br>
    <input type="text" placeholder="1234 5678 9012 3456"><br>
    Expiry Date:<br>
    <input type="text" placeholder="MM/YY"><br>
    CVV:<br>
    <input type="password" placeholder="***"><br><br>
</div>

<input type="radio" name="paymentMode" value="UPI"
       onclick="showPaymentDetails('upi')">
UPI <br>

<div id="upi" style="display:none;">
    <h4>UPI Payment</h4>
    UPI ID:<br>
    <input type="text" placeholder="name@upi"><br><br>
</div>

<input type="radio" name="paymentMode" value="NetBanking"
       onclick="showPaymentDetails('net')">
Net Banking <br><br>

<div id="net" style="display:none;">
    <h4>Net Banking</h4>
    Select Bank:<br>
    <select>
        <option>SBI</option>
        <option>HDFC</option>
        <option>ICICI</option>
        <option>Axis Bank</option>
    </select><br><br>
</div>
<input type="submit" value="Pay Now">

</form>

<br>
<a href="courses.jsp">Cancel</a>
</div>