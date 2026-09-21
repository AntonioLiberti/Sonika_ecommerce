package model;

import java.util.ArrayList;
import java.util.List;

public class Carrello {
    private List<ItemCarrello> items;

    public Carrello() {
        items = new ArrayList<>();
    }

    public List<ItemCarrello> getItems() {
        return items;
    }


    public void addProdotto(Prodotto prodotto) {
        for (ItemCarrello item : items) {

            if (item.getProdotto().getIdProdotto() == prodotto.getIdProdotto()) { 
                item.setQuantita(item.getQuantita() + 1);
                return;
            }
        }
        items.add(new ItemCarrello(prodotto, 1));
    }

    public void removeProdotto(int idProdotto) {
        items.removeIf(item -> item.getProdotto().getIdProdotto() == idProdotto);
    }


    public double getPrezzoTotaleCarrello() {
        double totale = 0;
        for (ItemCarrello item : items) {
            totale += item.getPrezzoTotale();
        }
        return totale;
    }
    
    public void svuotaCarrello() {
        this.items.clear();
    }

    public void aggiornaQuantita(int idProdotto, int nuovaQuantita) {
        for (ItemCarrello item : items) {
            if (item.getProdotto().getIdProdotto() == idProdotto) {
                if (nuovaQuantita > 0) {
                    item.setQuantita(nuovaQuantita);
                }
                break;
            }
        }
    }
}