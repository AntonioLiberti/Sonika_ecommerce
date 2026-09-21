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
   
        HttpSession session = request.getSession();

        Carrello carrello = (Carrello) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new Carrello();
            session.setAttribute("carrello", carrello);
        }

        String action = request.getParameter("action");
        
        if (action != null && action.equals("add")) {
            int idProdotto = Integer.parseInt(request.getParameter("id"));
            
            ProdottoDAO prodottoDAO = new ProdottoDAO();
            Prodotto prodotto = prodottoDAO.doRetrieveById(idProdotto);
            
            if (prodotto != null) {
                carrello.addProdotto(prodotto);
            }
            response.sendRedirect(request.getContextPath() + "/Home");
            return;
        } 
        
        else if (action != null && action.equals("remove")) {
            int idProdotto = Integer.parseInt(request.getParameter("id"));
            carrello.removeProdotto(idProdotto);
            response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
            return;
        }
       
        else if (action != null && action.equals("update")) {
            int idProdotto = Integer.parseInt(request.getParameter("id"));
            int quantita = Integer.parseInt(request.getParameter("quantita"));
            carrello.aggiornaQuantita(idProdotto, quantita);
            response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
            return;
        }

        else if (action != null && action.equals("clear")) {
            carrello.svuotaCarrello();
            response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
            return;
        }
        
        // Se non ci sono azioni (es. vogliamo solo vedere il carrello), andiamo alla pagina dedicata
        request.getRequestDispatcher("/WEB-INF/view/carrello.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}