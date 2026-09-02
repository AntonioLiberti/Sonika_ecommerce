package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Utente;
import dao.UtenteDAO;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Mostra la pagina di login nascosta e protetta
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        UtenteDAO utenteDAO = new UtenteDAO();
        Utente utente = utenteDAO.doRetrieveByEmailPassword(email, password); 
        
        if (utente != null) {
            HttpSession session = request.getSession();
            session.setAttribute("utenteLoggato", utente);
            // Reindirizza alla home o al catalogo dopo il login
            response.sendRedirect(request.getContextPath() + "/index.jsp"); 
        } else {
            request.setAttribute("errore", "Email o password errati.");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }
}