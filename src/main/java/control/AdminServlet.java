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

@WebServlet("/Admin")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProdottoDAO prodottoDAO = new ProdottoDAO();
        
        List<Prodotto> catalogoAdmin = prodottoDAO.doRetrieveAll(); 
        
        request.setAttribute("catalogoAdmin", catalogoAdmin);
        request.getRequestDispatcher("/WEB-INF/view/admin.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}