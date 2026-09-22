package control;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Utente;
import model.Ordine;
import dao.OrdineDAO;

@WebServlet("/StoricoOrdini")
public class StoricoOrdiniServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utenteLoggato");
        
        if (utente == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        OrdineDAO dao = new OrdineDAO();
        List<Ordine> ordini = dao.getOrdiniByUtente(utente.getIdUtente());
        
        request.setAttribute("ordini", ordini);
        request.getRequestDispatcher("/WEB-INF/view/storicoOrdini.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
