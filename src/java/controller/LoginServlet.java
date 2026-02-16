package controller;

import dao.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM students WHERE email=? AND password=?"
            );

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("sid", rs.getInt("student_id"));
                session.setAttribute("username", rs.getString("name"));


                response.sendRedirect("courses.jsp");
            } else {
                response.sendRedirect("login.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
