CREATE DATABASE IF NOT EXISTS sonika_ecommerce;
USE sonika_ecommerce;

CREATE TABLE Utente (
    id_utente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    ruolo VARCHAR(20) DEFAULT 'cliente' 
);

CREATE TABLE Prodotto (
    id_prodotto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    prezzo_attuale DECIMAL(10, 2) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    giacenza INT DEFAULT 0,
    eliminato BOOLEAN DEFAULT FALSE 
);

CREATE TABLE Ordine (
    id_ordine INT AUTO_INCREMENT PRIMARY KEY,
    data_ordine DATE NOT NULL,
    stato VARCHAR(50) DEFAULT 'In elaborazione',
    id_utente INT NOT NULL,
    FOREIGN KEY (id_utente) REFERENCES Utente(id_utente)
);

CREATE TABLE Dettaglio_Ordine (
    id_ordine INT NOT NULL,
    id_prodotto INT NOT NULL,
    quantita_acquistata INT NOT NULL,
    prezzo_acquisto DECIMAL(10, 2) NOT NULL, 
    PRIMARY KEY (id_ordine, id_prodotto),
    FOREIGN KEY (id_ordine) REFERENCES Ordine(id_ordine),
    FOREIGN KEY (id_prodotto) REFERENCES Prodotto(id_prodotto)
);
