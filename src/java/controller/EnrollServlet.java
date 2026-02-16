package controller;

import dao.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/EnrollServlet")
public class EnrollServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("sid") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int studentId = (int) session.getAttribute("sid");
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        
        String paymentMode = request.getParameter("paymentMode");


        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // check duplicate
            PreparedStatement check = con.prepareStatement(
                "SELECT * FROM registrations WHERE student_id=? AND course_id=?"
            );
            check.setInt(1, studentId);
            check.setInt(2, courseId);

            ResultSet rs = check.executeQuery();
            if (rs.next()) {
                con.rollback();
                response.sendRedirect("alreadyRegistered.jsp");
                return;
            }

            // check seats
            PreparedStatement seatCheck = con.prepareStatement(
                "SELECT available_seats FROM courses WHERE course_id=?"
            );
            seatCheck.setInt(1, courseId);
            ResultSet seatRs = seatCheck.executeQuery();

            if (seatRs.next()) {
                int seats = seatRs.getInt("available_seats");
                if (seats <= 0) {
                    con.rollback();
                    response.sendRedirect("noSeats.jsp");
                    return;
                }
            }

            // insert registration
            PreparedStatement insert = con.prepareStatement(
                "INSERT INTO registrations(student_id, course_id) VALUES(?,?)"
            );
            insert.setInt(1, studentId);
            insert.setInt(2, courseId);
            insert.executeUpdate();

            // reduce seat
            PreparedStatement update = con.prepareStatement(
                "UPDATE courses SET available_seats = available_seats - 1 WHERE course_id=?"
            );
            update.setInt(1, courseId);
            update.executeUpdate();

            con.commit();

            response.sendRedirect("success.jsp");

        } catch (Exception e) {
            try {
                if (con != null) con.rollback();
            } catch (Exception ex) {}
            e.printStackTrace();
        }
    }
}
