package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.ConPool;
import model.DettaglioOrdine;

public class DettaglioOrdineDAO {

   
    public void doSave(DettaglioOrdine dettaglio) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO Dettaglio_Ordine (id_ordine, id_prodotto, quantita_acquistata, prezzo_acquisto) VALUES (?, ?, ?, ?)");
            ps.setInt(1, dettaglio.getIdOrdine());
            ps.setInt(2, dettaglio.getIdProdotto());
            ps.setInt(3, dettaglio.getQuantitaAcquistata());
            ps.setDouble(4, dettaglio.getPrezzoAcquisto());
            
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel salvataggio del dettaglio ordine", e);
        }
    }
    
    public java.util.List<model.DettaglioOrdine> getDettagliByOrdine(int idOrdine) {
        java.util.List<model.DettaglioOrdine> dettagli = new java.util.ArrayList<>();
        try (java.sql.Connection con = model.ConPool.getConnection()) {
            java.sql.PreparedStatement ps = con.prepareStatement("SELECT * FROM CONTIENE WHERE id_ordine = ?");
            ps.setInt(1, idOrdine);
            java.sql.ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                model.DettaglioOrdine d = new model.DettaglioOrdine();
                d.setIdOrdine(rs.getInt("id_ordine"));
                d.setIdProdotto(rs.getInt("id_prodotto"));
                d.setQuantitaAcquistata(rs.getInt("quantita_acquistata"));
                d.setPrezzoAcquisto(rs.getDouble("prezzo_acquisto"));
                dettagli.add(d);
            }
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
        }
        return dettagli;
    }
}