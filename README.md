# Sonika - E-commerce Strumenti Musicali

Progetto realizzato per l'esame di Tecnologie Software per il Web

Autore: Antonio Liberti

## Descrizione del Progetto
Sonika è un sito web di commercio elettronico specializzato nella vendita online di strumenti musicali, con un focus particolare su strumenti a corda e a tastiera. 

Il sistema prevede tre tipologie di utenti, ciascuno con specifiche funzionalità:
* Visitatore non registrato: Navigazione del catalogo, gestione del carrello e registrazione nuovo account.
* Utente Registrato (Cliente): Funzioni del visitatore con l'aggiunta di checkout (spedizione e pagamento) e visualizzazione dello storico ordini.
* Amministratore: Accesso ad area riservata per la gestione completa del catalogo prodotti (inserimento, modifica, cancellazione) e visualizzazione degli ordini filtrabili per data o cliente.

## Struttura e Pattern Architetturali
Il progetto è sviluppato seguendo il pattern architetturale MVC (Model-View-Controller).
La logica di persistenza dei dati è incapsulata utilizzando il pattern DAO (Data Access Object).
