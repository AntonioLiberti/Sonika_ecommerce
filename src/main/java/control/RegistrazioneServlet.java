package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Utente;
import dao.UtenteDAO;

@WebServlet("/Registrazione")
public class RegistrazioneServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Prende i dati scritti dall'utente nel form
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // 2. Crea un oggetto Utente
        Utente nuovoUtente = new Utente();
        nuovoUtente.setNome(nome);
        nuovoUtente.setCognome(cognome);
        nuovoUtente.setEmail(email);
        nuovoUtente.setPassword(password);
        nuovoUtente.setRuolo("cliente");

        // 3. Usa il DAO per salvare sul database
        UtenteDAO utenteDAO = new UtenteDAO();
        try {
            utenteDAO.doSave(nuovoUtente);
            // Se va tutto bene, riapre la pagina di login col messaggio verde
            request.setAttribute("messaggio", "Registrazione completata! Ora puoi fare il login.");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        } catch (RuntimeException e) {
            // Se c'è un errore (es. email già usata), riapre la pagina col messaggio rosso
            request.setAttribute("errore", "Errore durante la registrazione. Forse l'email è già in uso?");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }
}
