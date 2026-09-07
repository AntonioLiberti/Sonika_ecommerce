package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Carrello;
import model.Prodotto;
import dao.ProdottoDAO;

@WebServlet("/CarrelloServlet")
public class CarrelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Recuperiamo la Sessione dell'utente
        HttpSession session = request.getSession();
        
        // 2. Cerchiamo il carrello. Se è la prima volta che l'utente clicca, lo creiamo vuoto.
        Carrello carrello = (Carrello) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new Carrello();
            session.setAttribute("carrello", carrello);
        }

        // 3. Leggiamo l'azione dalla pagina web (es. "add" per aggiungere)
        String action = request.getParameter("action");
        
        if (action != null && action.equals("add")) {
            int idProdotto = Integer.parseInt(request.getParameter("id"));
            
            // 4. Peschiamo il prodotto dal database tramite il suo ID
            ProdottoDAO prodottoDAO = new ProdottoDAO();
            Prodotto prodotto = prodottoDAO.doRetrieveById(idProdotto);
            
            // 5. Lo infiliamo nel carrello e torniamo in vetrina
            if (prodotto != null) {
                carrello.addProdotto(prodotto);
            }
            response.sendRedirect(request.getContextPath() + "/Home");
            return;
        }
        
        // Se non ci sono azioni (es. vogliamo solo vedere il carrello), andiamo alla pagina dedicata
        request.getRequestDispatcher("/WEB-INF/view/carrello.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

