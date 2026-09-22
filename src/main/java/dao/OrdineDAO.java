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
    
    public int salvaOrdine(int idUtente, model.Carrello carrello) {
        int idOrdine = -1;
        try (java.sql.Connection con = model.ConPool.getConnection()) {
            con.setAutoCommit(false);
            
            String queryOrdine = "INSERT INTO ORDINE (data, stato, id_utente) VALUES (CURDATE(), 'Pagato', ?)";
            try (java.sql.PreparedStatement ps = con.prepareStatement(queryOrdine, java.sql.Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, idUtente);
                ps.executeUpdate();
                
                try (java.sql.ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        idOrdine = rs.getInt(1);
                    }
                }
            }
            
            String queryContiene = "INSERT INTO CONTIENE (id_ordine, id_prodotto, quantita_acquistata, prezzo_acquisto) VALUES (?, ?, ?, ?)";
            try (java.sql.PreparedStatement psContiene = con.prepareStatement(queryContiene)) {
                for (model.ItemCarrello item : carrello.getItems()) {
                    psContiene.setInt(1, idOrdine);
                    psContiene.setInt(2, item.getProdotto().getIdProdotto());
                    psContiene.setInt(3, item.getQuantita());
                    psContiene.setDouble(4, item.getProdotto().getPrezzoAttuale());
                    psContiene.addBatch();
                }
                psContiene.executeBatch();
            }
            
            con.commit();
            con.setAutoCommit(true);
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
        }
        return idOrdine;
    }
    
    public java.util.List<model.Ordine> getOrdiniByUtente(int idUtente) {
        java.util.List<model.Ordine> ordini = new java.util.ArrayList<>();
        try (java.sql.Connection con = model.ConPool.getConnection()) {
            String query = "SELECT * FROM ORDINE WHERE id_utente = ? ORDER BY data DESC";
            try (java.sql.PreparedStatement ps = con.prepareStatement(query)) {
                ps.setInt(1, idUtente);
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        model.Ordine o = new model.Ordine();
                        o.setIdOrdine(rs.getInt("id_ordine"));
                        o.setDataOrdine(rs.getDate("data"));
                        o.setStato(rs.getString("stato"));
                        o.setIdUtente(rs.getInt("id_utente"));
                        ordini.add(o);
                    }
                }
            }
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
        }
        return ordini;
    }
}