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
import dao.ProdottoDAO;
import model.DettaglioOrdine;
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
        if (idParam != null && !idParam.isEmpty()) {
            int idOrdine = Integer.parseInt(idParam);
            
            DettaglioOrdineDAO dettaglioDAO = new DettaglioOrdineDAO();
            ProdottoDAO prodottoDAO = new ProdottoDAO();
            
            List<DettaglioOrdine> dettagli = dettaglioDAO.getDettagliByOrdine(idOrdine);
            
            Map<DettaglioOrdine, Prodotto> mappaDettagli = new LinkedHashMap<>();
            double totaleOrdine = 0;
            
            for (DettaglioOrdine d : dettagli) {
                Prodotto p = prodottoDAO.doRetrieveByIdAdmin(d.getIdProdotto());
                if (p == null) {
                    p = new Prodotto();
                    p.setNome("Prodotto eliminato");
                    p.setMarca("-");
                }
                mappaDettagli.put(d, p);
                totaleOrdine += (d.getPrezzoAcquisto() * d.getQuantitaAcquistata());
            }

            request.setAttribute("mappaDettagli", mappaDettagli);
            request.setAttribute("idOrdine", idOrdine);
            request.setAttribute("totaleOrdine", totaleOrdine);
            
            request.getRequestDispatcher("/WEB-INF/view/dettaglioOrdine.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/Home");
        }
    }
}