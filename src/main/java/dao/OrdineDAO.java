package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Carrello;
import model.ConPool;
import model.ItemCarrello;
import model.Ordine;

public class OrdineDAO {

    public int salvaOrdine(int idUtente, Carrello carrello, String indirizzoSpedizione) throws SQLException {
        int idOrdine = -1;
        Connection con = null;
        try {
            con = ConPool.getConnection();
            con.setAutoCommit(false);

            String queryOrdine = "INSERT INTO ordine (data, stato, id_utente, indirizzo_spedizione) VALUES (CURDATE(), 'Pagato', ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(queryOrdine, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, idUtente);
                ps.setString(2, indirizzoSpedizione);
                ps.executeUpdate();
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        idOrdine = rs.getInt(1);
                    }
                }
            }

            String queryGiacenza = "UPDATE prodotto SET giacenza = giacenza - ? WHERE id_prodotto = ? AND giacenza >= ?";
            try (PreparedStatement psGiacenza = con.prepareStatement(queryGiacenza)) {
                for (ItemCarrello item : carrello.getItems()) {
                    psGiacenza.setInt(1, item.getQuantita());
                    psGiacenza.setInt(2, item.getProdotto().getIdProdotto());
                    psGiacenza.setInt(3, item.getQuantita());
                    int updated = psGiacenza.executeUpdate();
                    if (updated == 0) {
                        con.rollback();
                        throw new SQLException("Giacenza insufficiente per il prodotto " + item.getProdotto().getNome());
                    }
                }
            }

            String queryContiene = "INSERT INTO contiene (id_ordine, id_prodotto, quantita_acquistata, prezzo_acquisto) VALUES (?, ?, ?, ?)";
            try (PreparedStatement psContiene = con.prepareStatement(queryContiene)) {
                for (ItemCarrello item : carrello.getItems()) {
                    psContiene.setInt(1, idOrdine);
                    psContiene.setInt(2, item.getProdotto().getIdProdotto());
                    psContiene.setInt(3, item.getQuantita());
                    psContiene.setDouble(4, item.getProdotto().getPrezzoAttuale());
                    psContiene.addBatch();
                }
                psContiene.executeBatch();
            }

            con.commit();
        } catch (SQLException e) {
            if (con != null) {
                con.rollback();
            }
            throw e;
        } finally {
            if (con != null) {
                con.setAutoCommit(true);
                con.close();
            }
        }
        return idOrdine;
    }

    public Ordine getOrdineById(int idOrdine) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM ordine WHERE id_ordine = ?");
            ps.setInt(1, idOrdine);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Ordine o = new Ordine();
                o.setIdOrdine(rs.getInt("id_ordine"));
                o.setDataOrdine(rs.getDate("data"));
                o.setStato(rs.getString("stato"));
                o.setIdUtente(rs.getInt("id_utente"));
                o.setIndirizzoSpedizione(rs.getString("indirizzo_spedizione"));
                return o;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore recupero ordine", e);
        }
        return null;
    }

    public List<Ordine> getOrdiniByUtente(int idUtente) {
        List<Ordine> ordini = new ArrayList<>();
        String query = "SELECT * FROM ordine WHERE id_utente = ? ORDER BY data DESC, id_ordine DESC";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, idUtente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ordine o = new Ordine();
                    o.setIdOrdine(rs.getInt("id_ordine"));
                    o.setDataOrdine(rs.getDate("data"));
                    o.setStato(rs.getString("stato"));
                    o.setIdUtente(rs.getInt("id_utente"));
                    o.setIndirizzoSpedizione(rs.getString("indirizzo_spedizione"));
                    ordini.add(o);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel recupero degli ordini", e);
        }
        return ordini;
    }

    public List<Ordine> doRetrieveAllAdmin() {
        List<Ordine> ordini = new ArrayList<>();
        String query = "SELECT * FROM ordine ORDER BY data DESC, id_ordine DESC";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Ordine o = new Ordine();
                o.setIdOrdine(rs.getInt("id_ordine"));
                o.setDataOrdine(rs.getDate("data"));
                o.setStato(rs.getString("stato"));
                o.setIdUtente(rs.getInt("id_utente"));
                o.setIndirizzoSpedizione(rs.getString("indirizzo_spedizione"));
                ordini.add(o);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore SQL Admin: " + e.getMessage());
        }
        return ordini;
    }

    public List<Ordine> doRetrieveByFiltersAdmin(String dataDa, String dataA, String idCliente) {
        List<Ordine> ordini = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM ordine WHERE 1=1");

        if (dataDa != null && !dataDa.isEmpty()) query.append(" AND data >= ?");
        if (dataA != null && !dataA.isEmpty()) query.append(" AND data <= ?");
        if (idCliente != null && !idCliente.isEmpty()) query.append(" AND id_utente = ?");
        query.append(" ORDER BY data DESC, id_ordine DESC");

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(query.toString())) {
            int paramIndex = 1;
            if (dataDa != null && !dataDa.isEmpty()) ps.setDate(paramIndex++, Date.valueOf(dataDa));
            if (dataA != null && !dataA.isEmpty()) ps.setDate(paramIndex++, Date.valueOf(dataA));
            if (idCliente != null && !idCliente.isEmpty()) ps.setInt(paramIndex++, Integer.parseInt(idCliente));
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ordine o = new Ordine();
                    o.setIdOrdine(rs.getInt("id_ordine"));
                    o.setDataOrdine(rs.getDate("data"));
                    o.setStato(rs.getString("stato"));
                    o.setIdUtente(rs.getInt("id_utente"));
                    o.setIndirizzoSpedizione(rs.getString("indirizzo_spedizione"));
                    ordini.add(o);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore SQL Filtri: " + e.getMessage());
        }
        return ordini;
    }
}