package control;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import dao.ProdottoDAO;
import model.Prodotto;

@WebServlet("/AdminInserisci")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AdminInserisciServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String SAVE_DIR = "images";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/adminInserisci.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String marca = request.getParameter("marca");
        double prezzo = Double.parseDouble(request.getParameter("prezzo"));
        String categoria = request.getParameter("categoria");
        int giacenza = Integer.parseInt(request.getParameter("giacenza"));
  
        Part filePart = request.getPart("immagine");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        String appPath = request.getServletContext().getRealPath("");
        String savePath = appPath + File.separator + SAVE_DIR;
        
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }
        
  
        if (fileName != null && !fileName.isEmpty()) {
            filePart.write(savePath + File.separator + fileName);
        } else {
            fileName = "default.png"; // Fallback di sicurezza
        }
        
    
        Prodotto p = new Prodotto();
        p.setNome(nome);
        p.setMarca(marca);
        p.setPrezzoAttuale(prezzo);
        p.setCategoria(categoria);
        p.setGiacenza(giacenza);
        p.setImmagine(fileName); 
        
        ProdottoDAO dao = new ProdottoDAO();
        dao.doSave(p);
        
        response.sendRedirect(request.getContextPath() + "/Admin");
    }
}