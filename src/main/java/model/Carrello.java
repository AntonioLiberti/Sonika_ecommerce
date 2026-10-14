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
                if (item.getQuantita() + 1 <= prodotto.getGiacenza()) {
                    item.setQuantita(item.getQuantita() + 1);
                }
                return;
            }
        }
    
        if (prodotto.getGiacenza() > 0) {
            items.add(new ItemCarrello(prodotto, 1));
        }
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
                    if (nuovaQuantita > item.getProdotto().getGiacenza()) {
                        item.setQuantita(item.getProdotto().getGiacenza());
                    } else {
                        item.setQuantita(nuovaQuantita);
                    }
                }
                break;
            }
        }
    }
}