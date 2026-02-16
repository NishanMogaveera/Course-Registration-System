package controller;

import dao.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteCourseServlet")
public class DeleteCourseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int courseId = Integer.parseInt(request.getParameter("courseId"));

        try {
            Connection con = DBConnection.getConnection();

            // OPTIONAL SAFETY CHECK (recommended)
            PreparedStatement check = con.prepareStatement(
                "SELECT * FROM registrations WHERE course_id=?"
            );
            check.setInt(1, courseId);
            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                response.sendRedirect("admin/manageCourses.jsp?error=assigned");
                return;
            }

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM courses WHERE course_id=?"
            );
            ps.setInt(1, courseId);
            ps.executeUpdate();

            response.sendRedirect("manageCourses.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
