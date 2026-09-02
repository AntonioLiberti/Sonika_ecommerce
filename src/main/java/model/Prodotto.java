package model;

public class Prodotto {
    private int idProdotto;
    private String nome;
    private String marca;
    private double prezzoAttuale;
    private String categoria;
    private int giacenza;
    private boolean eliminato;

    public Prodotto() {}

    public int getIdProdotto() { return idProdotto; }
    public void setIdProdotto(int idProdotto) { this.idProdotto = idProdotto; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getMarca() { return marca; }
    public void setMarca(String marca) { this.marca = marca; }

    public double getPrezzoAttuale() { return prezzoAttuale; }
    public void setPrezzoAttuale(double prezzoAttuale) { this.prezzoAttuale = prezzoAttuale; }

    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }

    public int getGiacenza() { return giacenza; }
    public void setGiacenza(int giacenza) { this.giacenza = giacenza; }

    public boolean isEliminato() { return eliminato; }
    public void setEliminato(boolean eliminato) { this.eliminato = eliminato; }
}