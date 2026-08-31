package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.ConPool;
import model.DettaglioOrdine;

public class DettaglioOrdineDAO {

    // Salva i singoli strumenti contenuti in un ordine (risolve il requisito del prezzo storico)
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
}