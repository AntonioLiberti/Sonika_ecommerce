package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ProdottoDAO;

@WebServlet("/AdminNascondi")
public class AdminNascondiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("idProdotto");
        
        if (idParam != null && !idParam.isEmpty()) {
            int idProdotto = Integer.parseInt(idParam);
            ProdottoDAO prodottoDAO = new ProdottoDAO();
            
            prodottoDAO.doDeleteLogico(idProdotto);
        }
        
        response.sendRedirect(request.getContextPath() + "/Admin");
    }
}