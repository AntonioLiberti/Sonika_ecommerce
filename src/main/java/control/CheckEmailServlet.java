package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ConPool;

@WebServlet("/CheckEmail")
public class CheckEmailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        boolean esiste = false;
        
        if (email != null && !email.trim().isEmpty()) {
            try (Connection con = ConPool.getConnection()) {
                PreparedStatement ps = con.prepareStatement("SELECT id_utente FROM Utente WHERE email = ?");
                ps.setString(1, email);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        esiste = true;
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(esiste ? "esiste" : "libera");
    }
}