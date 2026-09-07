package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Prodotto;
import model.ConPool;

public class ProdottoDAO {

	public Prodotto doRetrieveById(int id) {
	    // Adegua il nome della colonna 'id' se su phpMyAdmin si chiama diversamente!
	    String query = "SELECT * FROM PRODOTTO WHERE id_prodotto = ? AND eliminato = false"; 
	    try (java.sql.Connection con = model.ConPool.getConnection();
	         java.sql.PreparedStatement ps = con.prepareStatement(query)) {
	        
	        ps.setInt(1, id);
	        try (java.sql.ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                Prodotto p = new Prodotto();
	                p.setIdProdotto(rs.getInt("id")); // adegua il nome colonna
	                p.setNome(rs.getString("nome"));
	                p.setMarca(rs.getString("marca"));
	                p.setPrezzoAttuale(rs.getDouble("prezzoAttuale")); // adegua il nome colonna
	                p.setCategoria(rs.getString("categoria"));
	                p.setGiacenza(rs.getInt("giacenza"));
	                p.setEliminato(rs.getBoolean("eliminato"));
	                return p;
	            }
	        }
	    } catch (java.sql.SQLException e) {
	        throw new RuntimeException("Errore SQL in doRetrieveById: " + e.getMessage());
	    }
	    return null;
	}
    public List<Prodotto> doRetrieveAll() {
        List<Prodotto> prodotti = new ArrayList<>();
        String query = "SELECT * FROM PRODOTTO WHERE eliminato = false";
        
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                Prodotto p = new Prodotto();
                p.setIdProdotto(rs.getInt("id_prodotto"));
                p.setNome(rs.getString("nome"));
                p.setMarca(rs.getString("marca"));
                p.setPrezzoAttuale(rs.getDouble("prezzo_attuale"));
                p.setCategoria(rs.getString("categoria"));
                p.setGiacenza(rs.getInt("giacenza"));
                
             
                
                prodotti.add(p);
            }
        } catch (SQLException e) {
            System.out.println("Errore in ProdottoDAO -> doRetrieveAll: " + e.getMessage());
            e.printStackTrace();
        }
        
        return prodotti;
    }
}