package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.ConPool;
import model.Ordine;

public class OrdineDAO {

    // 1. Salva un nuovo ordine e restituisce l'ID generato automaticamente
    public int doSave(Ordine ordine) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO Ordine (data_ordine, stato, id_utente) VALUES (?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS);
            ps.setDate(1, ordine.getDataOrdine());
            ps.setString(2, ordine.getStato());
            ps.setInt(3, ordine.getIdUtente());
            
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Ci serve per sapere a quale ordine attaccare i prodotti
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel salvataggio dell'ordine", e);
        }
        return -1;
    }

    // 2. Recupera lo storico ordini di un singolo cliente (Area Personale)
    public List<Ordine> doRetrieveByUtente(int idUtente) {
        List<Ordine> ordini = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM Ordine WHERE id_utente = ? ORDER BY data_ordine DESC");
            ps.setInt(1, idUtente);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Ordine o = new Ordine();
                o.setIdOrdine(rs.getInt("id_ordine"));
                o.setDataOrdine(rs.getDate("data_ordine"));
                o.setStato(rs.getString("stato"));
                o.setIdUtente(rs.getInt("id_utente"));
                ordini.add(o);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel recupero degli ordini del cliente", e);
        }
        return ordini;
    }

    // 3. Recupera gli ordini per l'Amministratore (con filtro data X e data Y)
    public List<Ordine> doRetrieveByDate(Date dataInizio, Date dataFine) {
        List<Ordine> ordini = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM Ordine WHERE data_ordine BETWEEN ? AND ? ORDER BY data_ordine DESC");
            ps.setDate(1, dataInizio);
            ps.setDate(2, dataFine);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Ordine o = new Ordine();
                o.setIdOrdine(rs.getInt("id_ordine"));
                o.setDataOrdine(rs.getDate("data_ordine"));
                o.setStato(rs.getString("stato"));
                o.setIdUtente(rs.getInt("id_utente"));
                ordini.add(o);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel recupero degli ordini per data", e);
        }
        return ordini;
    }
}