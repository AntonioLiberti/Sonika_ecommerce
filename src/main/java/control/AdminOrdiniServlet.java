package control;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.OrdineDAO;
import model.Ordine;

@WebServlet("/AdminOrdini")
public class AdminOrdiniServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrdineDAO ordineDAO = new OrdineDAO();
        List<Ordine> listaOrdini = ordineDAO.doRetrieveAllAdmin();
        
        request.setAttribute("listaOrdini", listaOrdini);
        request.getRequestDispatcher("/WEB-INF/view/adminOrdini.jsp").forward(request, response);
    }
}