package control;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ProdottoDAO;
import model.Prodotto;

@WebServlet("/Home") 
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String search = request.getParameter("search");
        String categoria = request.getParameter("categoria");
        String minPrezzoStr = request.getParameter("minPrezzo");
        String maxPrezzoStr = request.getParameter("maxPrezzo");

        Double minPrezzo = null;
        Double maxPrezzo = null;

        if (minPrezzoStr != null && !minPrezzoStr.trim().isEmpty()) {
            try { minPrezzo = Double.parseDouble(minPrezzoStr); } catch (NumberFormatException e) {}
        }
        if (maxPrezzoStr != null && !maxPrezzoStr.trim().isEmpty()) {
            try { maxPrezzo = Double.parseDouble(maxPrezzoStr); } catch (NumberFormatException e) {}
        }

        ProdottoDAO prodottoDAO = new ProdottoDAO();
        List<Prodotto> catalogo;
        
  
        if ((search != null && !search.trim().isEmpty()) || 
            (categoria != null && !categoria.trim().isEmpty()) || 
            minPrezzo != null || maxPrezzo != null) {
            catalogo = prodottoDAO.doRetrieveByFiltri(search, categoria, minPrezzo, maxPrezzo);
        } else {
            catalogo = prodottoDAO.doRetrieveAll();
        }
        
        request.setAttribute("prodotti", catalogo);
        request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}