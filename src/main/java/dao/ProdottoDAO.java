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

    public List<Prodotto> doRetrieveAll() {
        List<Prodotto> prodotti = new ArrayList<>();
        String query = "SELECT * FROM prodotto";
        
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