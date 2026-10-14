package control;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.DettaglioOrdineDAO;
import dao.OrdineDAO;
import dao.ProdottoDAO;
import model.DettaglioOrdine;
import model.Ordine;
import model.Prodotto;
import model.Utente;

@WebServlet("/DettaglioOrdine")
public class DettaglioOrdineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utenteLoggato");

        if (utente == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/StoricoOrdini");
            return;
        }

        try {
            int idOrdine = Integer.parseInt(idParam);
            OrdineDAO ordineDAO = new OrdineDAO();
            Ordine ordine = ordineDAO.getOrdineById(idOrdine);

            if (ordine == null || (!utente.getRuolo().equals("admin") && ordine.getIdUtente() != utente.getIdUtente())) {
                response.sendRedirect(request.getContextPath() + "/Home");
                return;
            }

            DettaglioOrdineDAO detDAO = new DettaglioOrdineDAO();
            ProdottoDAO prodDAO = new ProdottoDAO();
            List<DettaglioOrdine> listaDettagli = detDAO.getDettagliByOrdine(idOrdine);
            
            Map<DettaglioOrdine, Prodotto> mappaDettagli = new LinkedHashMap<>();
            double totaleOrdine = 0.0;
            
            for (DettaglioOrdine d : listaDettagli) {
                Prodotto p = prodDAO.doRetrieveById(d.getIdProdotto());
                if (p != null) {
                    mappaDettagli.put(d, p);
                    totaleOrdine += (d.getPrezzoAcquisto() * d.getQuantitaAcquistata());
                }
            }

            request.setAttribute("mappaDettagli", mappaDettagli);
            request.setAttribute("totaleOrdine", totaleOrdine);
            request.setAttribute("idOrdine", idOrdine);
            request.setAttribute("indirizzoSpedizione", ordine.getIndirizzoSpedizione());
            
            request.getRequestDispatcher("/WEB-INF/view/dettaglioOrdine.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/StoricoOrdini");
        }
    }
}