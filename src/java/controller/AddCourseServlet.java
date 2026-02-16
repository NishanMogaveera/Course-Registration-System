package controller;

import dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddCourseServlet")
public class AddCourseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Admin session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        // ✅ Get form data
        String name = request.getParameter("name");
        int credits = Integer.parseInt(request.getParameter("credits"));
        int seats = Integer.parseInt(request.getParameter("seats"));
        String description = request.getParameter("desc");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO courses (course_name, credits, total_seats, available_seats, description) " +
                "VALUES (?, ?, ?, ?, ?)"
            );

            ps.setString(1, name);
            ps.setInt(2, credits);
            ps.setInt(3, seats);
            ps.setInt(4, seats); // available seats = total seats initially
            ps.setString(5, description);

            ps.executeUpdate();

            // ✅ Redirect back to admin dashboard
            response.sendRedirect("adminDashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
