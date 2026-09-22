package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Carrello;
import model.Utente;

@WebServlet("/Checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
     
        Utente utente = (Utente) session.getAttribute("utenteLoggato");
        if (utente == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Carrello carrello = (Carrello) session.getAttribute("carrello");
        if (carrello == null || carrello.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/view/checkout.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utenteLoggato");
        Carrello carrello = (Carrello) session.getAttribute("carrello");

        if (utente == null || carrello == null || carrello.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
            return;
        }

        dao.OrdineDAO ordineDAO = new dao.OrdineDAO();
        int idOrdine = ordineDAO.salvaOrdine(utente.getIdUtente(), carrello);

        if (idOrdine > 0) {
            session.removeAttribute("carrello");
            request.setAttribute("idOrdine", idOrdine);
            request.getRequestDispatcher("/WEB-INF/view/conferma.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
        }
    }
}