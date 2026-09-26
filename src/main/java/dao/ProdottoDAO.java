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
        String query = "SELECT * FROM PRODOTTO WHERE id_prodotto = ? AND eliminato = false"; 
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setIdProdotto(rs.getInt("id_prodotto")); 
                    p.setNome(rs.getString("nome"));
                    p.setMarca(rs.getString("marca"));
                    p.setPrezzoAttuale(rs.getDouble("prezzo_attuale")); 
                    p.setCategoria(rs.getString("categoria"));
                    p.setGiacenza(rs.getInt("giacenza"));
                    p.setEliminato(rs.getBoolean("eliminato"));
                    return p;
                }
            }
        } catch (SQLException e) {
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
                p.setEliminato(rs.getBoolean("eliminato"));
                
                prodotti.add(p);
            }
        } catch (SQLException e) {
            System.out.println("Errore in ProdottoDAO -> doRetrieveAll: " + e.getMessage());
            e.printStackTrace();
        }
        return prodotti;
    }

  
    public List<Prodotto> doRetrieveAllAdmin() {
        List<Prodotto> prodotti = new ArrayList<>();
        String query = "SELECT * FROM PRODOTTO"; 
        
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
                p.setEliminato(rs.getBoolean("eliminato"));
                
                prodotti.add(p);
            }
        } catch (SQLException e) {
            System.out.println("Errore in ProdottoDAO -> doRetrieveAllAdmin: " + e.getMessage());
            e.printStackTrace();
        }
        return prodotti;
    }

    public void doDeleteLogico(int idProdotto) {
        String query = "UPDATE prodotto SET eliminato = 1 WHERE id_prodotto = ?";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, idProdotto);
            ps.executeUpdate();
            
        } catch (SQLException e) {
            throw new RuntimeException("Errore durante la cancellazione logica", e);
        }
    }
    
    public Prodotto doRetrieveByIdAdmin(int id) {
        String query = "SELECT * FROM PRODOTTO WHERE id_prodotto = ?"; 
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setIdProdotto(rs.getInt("id_prodotto")); 
                    p.setNome(rs.getString("nome"));
                    p.setMarca(rs.getString("marca"));
                    p.setPrezzoAttuale(rs.getDouble("prezzo_attuale")); 
                    p.setCategoria(rs.getString("categoria"));
                    p.setGiacenza(rs.getInt("giacenza"));
                    p.setEliminato(rs.getBoolean("eliminato"));
                    return p;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore SQL in doRetrieveByIdAdmin", e);
        }
        return null;
    }

 
    public void doUpdate(Prodotto p) {
        String query = "UPDATE prodotto SET nome = ?, marca = ?, prezzo_attuale = ?, categoria = ?, giacenza = ? WHERE id_prodotto = ?";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setString(1, p.getNome());
            ps.setString(2, p.getMarca());
            ps.setDouble(3, p.getPrezzoAttuale());
            ps.setString(4, p.getCategoria());
            ps.setInt(5, p.getGiacenza());
            ps.setInt(6, p.getIdProdotto());
            
            ps.executeUpdate();
            
        } catch (SQLException e) {
            throw new RuntimeException("Errore durante l'aggiornamento del prodotto", e);
        }
    }
    
    public void doRipristinaLogico(int idProdotto) {
        String query = "UPDATE prodotto SET eliminato = 0 WHERE id_prodotto = ?";
        try (Connection con = model.ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, idProdotto);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Errore durante il ripristino logico", e);
        }
    }
    
    public void doSave(Prodotto p) {
        String query = "INSERT INTO prodotto (nome, marca, prezzo_attuale, categoria, giacenza, eliminato) VALUES (?, ?, ?, ?, ?, 0)";
        try (Connection con = model.ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setString(1, p.getNome());
            ps.setString(2, p.getMarca());
            ps.setDouble(3, p.getPrezzoAttuale());
            ps.setString(4, p.getCategoria());
            ps.setInt(5, p.getGiacenza());
            
            ps.executeUpdate();
            
        } catch (SQLException e) {
            throw new RuntimeException("Errore durante l'inserimento del nuovo prodotto", e);
        }
    }
}