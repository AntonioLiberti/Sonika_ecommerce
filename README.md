#Sonika - E-commerce Strumenti Musicali
Progetto realizzato per l'esame di Tecnologie Software per il Web
Autore: Antonio Liberti

##Descrizione del Progetto
Sonika è un e-commerce B2C specializzato nella vendita online di strumenti musicali (con focus su strumenti a corda e a tastiera). L'obiettivo è offrire un'esperienza di navigazione e acquisto chiara, rapida e intuitiva.

Il sistema gestisce tre tipologie di utenti, ognuno con permessi e percorsi dedicati:

Visitatore (Non registrato): Esplora il catalogo, usa la ricerca, riempie il carrello e può registrare un nuovo account.

Cliente (Utente Registrato): Oltre alle funzioni di base, può finalizzare l'acquisto (checkout con dati di spedizione) e accedere a un'area personale per consultare lo storico dei propri ordini.

Amministratore (Admin): Accede a un'area riservata e protetta da filtri. Da qui gestisce il catalogo (inserimento, modifica e cancellazione prodotti) e monitora le vendite, con la possibilità di filtrare gli ordini per data o ID cliente.

##Struttura e Pattern Architetturali
Il progetto è stato sviluppato applicando il pattern architetturale MVC (Model-View-Controller). Questo permette di separare nettamente l'interfaccia grafica (View - le pagine JSP), i dati del dominio (Model - le classi JavaBean) e la logica di business che elabora le richieste HTTP (Controller - le Servlet).

La comunicazione con il database relazionale è invece isolata e gestita tramite il pattern DAO (Data Access Object). Questo approccio garantisce un codice pulito, modulare e una gestione sicura delle connessioni, sfruttando le transazioni per blindare le operazioni critiche (come lo scalo automatico delle giacenze di magazzino durante gli acquisti).