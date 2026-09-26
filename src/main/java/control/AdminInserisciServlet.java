package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ProdottoDAO;
import model.Prodotto;

@WebServlet("/AdminInserisci")
public class AdminInserisciServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/adminInserisci.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String marca = request.getParameter("marca");
        double prezzo = Double.parseDouble(request.getParameter("prezzo"));
        String categoria = request.getParameter("categoria");
        int giacenza = Integer.parseInt(request.getParameter("giacenza"));
        
        Prodotto p = new Prodotto();
        p.setNome(nome);
        p.setMarca(marca);
        p.setPrezzoAttuale(prezzo);
        p.setCategoria(categoria);
        p.setGiacenza(giacenza);
        
        ProdottoDAO dao = new ProdottoDAO();
        dao.doSave(p);
        
        response.sendRedirect(request.getContextPath() + "/Admin");
    }
}