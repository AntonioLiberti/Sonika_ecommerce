package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.ConPool;
import model.Utente;

public class UtenteDAO {
    
    // Metodo per il Login dell'utente
    public Utente doRetrieveByEmailPassword(String email, String password) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM Utente WHERE email = ? AND password = ?");
            ps.setString(1, email);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Utente u = new Utente();
                u.setIdUtente(rs.getInt("id_utente"));
                u.setNome(rs.getString("nome"));
                u.setCognome(rs.getString("cognome"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setRuolo(rs.getString("ruolo"));
                return u;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore durante il login", e);
        }
        return null; // Ritorna null se email e password non corrispondono
    }

    // Metodo per la Registrazione di un nuovo utente
    public void doSave(Utente utente) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO Utente (nome, cognome, email, password, ruolo) VALUES (?, ?, ?, ?, ?)");
            ps.setString(1, utente.getNome());
            ps.setString(2, utente.getCognome());
            ps.setString(3, utente.getEmail());
            ps.setString(4, utente.getPassword());
            ps.setString(5, utente.getRuolo() != null ? utente.getRuolo() : "cliente");
            
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Errore durante la registrazione", e);
        }
    }
}
