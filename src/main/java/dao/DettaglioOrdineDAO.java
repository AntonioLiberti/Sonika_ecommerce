package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.ConPool;
import model.DettaglioOrdine;

public class DettaglioOrdineDAO {

    public void doSave(DettaglioOrdine dettaglio) {
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "INSERT INTO contiene (id_ordine, id_prodotto, quantita_acquistata, prezzo_acquisto) VALUES (?, ?, ?, ?)")) {
            ps.setInt(1, dettaglio.getIdOrdine());
            ps.setInt(2, dettaglio.getIdProdotto());
            ps.setInt(3, dettaglio.getQuantitaAcquistata());
            ps.setDouble(4, dettaglio.getPrezzoAcquisto());
            
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel salvataggio del dettaglio ordine", e);
        }
    }
    
    public List<DettaglioOrdine> getDettagliByOrdine(int idOrdine) {
        List<DettaglioOrdine> dettagli = new ArrayList<>();
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM contiene WHERE id_ordine = ?")) {
            ps.setInt(1, idOrdine);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    DettaglioOrdine d = new DettaglioOrdine();
                    d.setIdOrdine(rs.getInt("id_ordine"));
                    d.setIdProdotto(rs.getInt("id_prodotto"));
                    d.setQuantitaAcquistata(rs.getInt("quantita_acquistata"));
                    d.setPrezzoAcquisto(rs.getDouble("prezzo_acquisto"));
                    dettagli.add(d);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel recupero dei dettagli ordine", e);
        }
        return dettagli;
    }
}