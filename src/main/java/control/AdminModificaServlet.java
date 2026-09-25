package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ProdottoDAO;
import model.Prodotto;

@WebServlet("/AdminModifica")
public class AdminModificaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            ProdottoDAO dao = new ProdottoDAO();
            Prodotto p = dao.doRetrieveByIdAdmin(id);
            
            request.setAttribute("prodotto", p);
            request.getRequestDispatcher("/WEB-INF/view/adminModifica.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/Admin");
        }
    }

     protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("idProdotto"));
        String nome = request.getParameter("nome");
        String marca = request.getParameter("marca");
        double prezzo = Double.parseDouble(request.getParameter("prezzo"));
        String categoria = request.getParameter("categoria");
        int giacenza = Integer.parseInt(request.getParameter("giacenza"));
        
        Prodotto p = new Prodotto();
        p.setIdProdotto(id);
        p.setNome(nome);
        p.setMarca(marca);
        p.setPrezzoAttuale(prezzo);
        p.setCategoria(categoria);
        p.setGiacenza(giacenza);
        
        ProdottoDAO dao = new ProdottoDAO();
        dao.doUpdate(p);
        
        response.sendRedirect(request.getContextPath() + "/Admin");
    }
}