-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Ott 20, 2026 alle 00:44
-- Versione del server: 10.4.32-MariaDB
-- Versione PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sonika_ecommerce`
--
CREATE DATABASE IF NOT EXISTS `sonika_ecommerce` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sonika_ecommerce`;

-- --------------------------------------------------------

--
-- Struttura della tabella `contiene`
--

CREATE TABLE `contiene` (
  `id_ordine` int(11) NOT NULL,
  `id_prodotto` int(11) NOT NULL,
  `quantita_acquistata` int(11) NOT NULL,
  `prezzo_acquisto` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `contiene`
--

INSERT INTO `contiene` (`id_ordine`, `id_prodotto`, `quantita_acquistata`, `prezzo_acquisto`) VALUES
(1, 2, 1, 449.99),
(2, 3, 1, 85.50),
(3, 1, 2, 750.00),
(4, 4, 1, 249.00),
(5, 1, 2, 740.00),
(5, 2, 1, 449.99),
(6, 3, 1, 85.50),
(7, 3, 1, 85.50),
(8, 3, 1, 85.50),
(9, 2, 1, 449.99),
(10, 6, 3, 149.00),
(10, 7, 1, 549.00),
(10, 9, 1, 999.00),
(10, 12, 1, 3599.00),
(10, 18, 1, 229.00),
(11, 6, 1, 149.00),
(11, 7, 1, 549.00),
(12, 5, 1, 729.00),
(12, 6, 2, 149.00),
(13, 6, 1, 149.00),
(14, 6, 1, 149.00),
(15, 7, 1, 549.00),
(16, 6, 1, 149.00),
(17, 7, 1, 549.00),
(18, 6, 1, 149.00),
(18, 7, 1, 549.00),
(19, 5, 1, 729.00),
(20, 11, 2, 699.00);

-- --------------------------------------------------------

--
-- Struttura della tabella `ordine`
--

CREATE TABLE `ordine` (
  `id_ordine` int(11) NOT NULL,
  `data` date NOT NULL,
  `stato` varchar(50) NOT NULL,
  `id_utente` int(11) NOT NULL,
  `indirizzo_spedizione` varchar(255) NOT NULL DEFAULT 'Non specificato'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `ordine`
--

INSERT INTO `ordine` (`id_ordine`, `data`, `stato`, `id_utente`, `indirizzo_spedizione`) VALUES
(1, '2026-09-22', 'Pagato', 2, 'Non specificato'),
(2, '2026-09-23', 'Pagato', 2, 'Non specificato'),
(3, '2026-09-23', 'Pagato', 3, 'Non specificato'),
(4, '2026-09-27', 'Pagato', 2, 'Non specificato'),
(5, '2026-10-01', 'Pagato', 2, 'Non specificato'),
(6, '2026-10-01', 'Pagato', 2, 'Non specificato'),
(7, '2026-10-01', 'Pagato', 2, 'Non specificato'),
(8, '2026-10-01', 'Pagato', 2, 'Non specificato'),
(9, '2026-10-01', 'Pagato', 2, 'Non specificato'),
(10, '2026-10-06', 'Pagato', 2, 'Non specificato'),
(11, '2026-10-07', 'Pagato', 2, 'Non specificato'),
(12, '2026-10-08', 'Pagato', 2, 'Non specificato'),
(13, '2026-10-08', 'Pagato', 2, 'Non specificato'),
(14, '2026-10-08', 'Pagato', 2, 'Non specificato'),
(15, '2026-10-08', 'Pagato', 2, 'Non specificato'),
(16, '2026-10-17', 'Pagato', 10, 'due principati 344'),
(17, '2026-10-18', 'Pagato', 10, 'fdssd'),
(18, '2026-10-18', 'Pagato', 10, 'abcwd'),
(19, '2026-10-18', 'Pagato', 10, 'due principati 344'),
(20, '2026-10-19', 'Pagato', 10, 'due principati 344');

-- --------------------------------------------------------

--
-- Struttura della tabella `prodotto`
--

CREATE TABLE `prodotto` (
  `id_prodotto` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `prezzo_attuale` decimal(10,2) NOT NULL,
  `categoria` varchar(50) NOT NULL,
  `giacenza` int(11) DEFAULT 0,
  `eliminato` tinyint(1) DEFAULT 0,
  `immagine` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `prodotto`
--

INSERT INTO `prodotto` (`id_prodotto`, `nome`, `marca`, `prezzo_attuale`, `categoria`, `giacenza`, `eliminato`, `immagine`) VALUES
(1, 'Chitarra Elettrica Stratocaster', 'Fender', 740.00, 'Chitarre', 5, 1, ''),
(2, 'Pianoforte Digitale P-45', 'Yamaha', 449.99, 'Tastiere', 2, 1, ''),
(3, 'Ukulele Soprano', 'Kala', 85.50, 'Ukulele', 10, 1, ''),
(4, 'Basso Elettrico Ibanez GSR200', 'Ibanez', 249.00, 'Bassi', 3, 1, ''),
(5, 'Chitarra Elettrica Stratocaster Player', 'FENDER', 729.00, 'Chitarre', 4, 0, 'stratocaster.jpg'),
(6, 'Chitarra Classica C40', 'Yamaha', 149.00, 'Chitarre', 10, 0, 'yamaha_c40.jpg'),
(7, 'Chitarra Acustica LX1E Little', 'Martin', 549.00, 'Chitarre', 1, 0, 'martin_lx1e.jpg'),
(8, 'Chitarra Elettrica Les Paul Standard', 'Gibson', 2499.00, 'Chitarre', 2, 0, 'les_paul.jpg'),
(9, 'Chitarra Elettrica RG550', 'Ibanez', 999.00, 'Chitarre', 4, 0, 'ibanez_rg550.jpg'),
(10, 'Pianoforte Digitale P-45', 'Yamaha', 449.99, 'Tastiere', 6, 0, 'yamaha-p45b.jpg'),
(11, 'Pianoforte Digitale FP-30X', 'Roland', 699.00, 'Tastiere', 2, 0, 'roland_fp30x.jpg'),
(12, 'Sintetizzatore Stage 3 88', 'Nord', 3599.00, 'Tastiere', 1, 0, 'nord_stage3.jpg'),
(13, 'Ukulele Soprano KA-15S', 'Kala', 85.50, 'Ukulele', 15, 0, 'kala_ka15s.jpg'),
(14, 'Ukulele Concerto 15CM', 'Cordoba', 115.00, 'Ukulele', 8, 0, 'cordoba_15cm.jpg'),
(15, 'Ukulele Fullerton Strat', 'Fender', 199.00, 'Ukulele', 5, 0, 'fender_uke.jpg'),
(16, 'Basso Elettrico GSR200', 'Ibanez', 249.00, 'Bassi', 10, 0, 'ibanez_gsr200.jpg'),
(17, 'Basso Player Precision', 'Fender', 849.00, 'Bassi', 3, 0, 'precision_bass.jpg'),
(18, 'Basso Elettrico TRBX174', 'Yamaha', 229.00, 'Bassi', 7, 0, 'yamaha_trbx.jpg'),
(19, 'Chitarra Acustica 114ce', 'Taylor', 899.00, 'Chitarre', 4, 0, 'taylor_114ce.jpg');

-- --------------------------------------------------------

--
-- Struttura della tabella `utente`
--

CREATE TABLE `utente` (
  `id_utente` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `ruolo` varchar(20) DEFAULT 'cliente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `utente`
--

INSERT INTO `utente` (`id_utente`, `nome`, `cognome`, `email`, `password`, `ruolo`) VALUES
(1, 'mario', 'rossi', 'mario@test.it', '123', 'admin'),
(2, 'a', 'a', 'test@test', '123', 'admin'),
(3, 'a', 'a', 'a@a', '1', 'cliente'),
(4, 'ciao', 'salve', 'ciao@salve', '2222', 'cliente'),
(5, 'd', 'd', 'test@gmail.com', '123123123a', 'cliente'),
(8, 'An', 'xw', 'tewst@gmail.com', '123ewddsds', 'cliente'),
(10, 'Antonio', 'Liberti', 'antonioliberti@gmail.com', 'antonioliberti1', 'admin'),
(11, 'Mario', 'Rossi', 'mariorossi@gmail.com', 'mariorossi1', 'cliente');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `contiene`
--
ALTER TABLE `contiene`
  ADD PRIMARY KEY (`id_ordine`,`id_prodotto`),
  ADD KEY `id_prodotto` (`id_prodotto`);

--
-- Indici per le tabelle `ordine`
--
ALTER TABLE `ordine`
  ADD PRIMARY KEY (`id_ordine`),
  ADD KEY `id_utente` (`id_utente`);

--
-- Indici per le tabelle `prodotto`
--
ALTER TABLE `prodotto`
  ADD PRIMARY KEY (`id_prodotto`);

--
-- Indici per le tabelle `utente`
--
ALTER TABLE `utente`
  ADD PRIMARY KEY (`id_utente`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `ordine`
--
ALTER TABLE `ordine`
  MODIFY `id_ordine` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT per la tabella `prodotto`
--
ALTER TABLE `prodotto`
  MODIFY `id_prodotto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT per la tabella `utente`
--
ALTER TABLE `utente`
  MODIFY `id_utente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `contiene`
--
ALTER TABLE `contiene`
  ADD CONSTRAINT `contiene_ibfk_1` FOREIGN KEY (`id_ordine`) REFERENCES `ordine` (`id_ordine`) ON DELETE CASCADE,
  ADD CONSTRAINT `contiene_ibfk_2` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`) ON DELETE NO ACTION;

--
-- Limiti per la tabella `ordine`
--
ALTER TABLE `ordine`
  ADD CONSTRAINT `ordine_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
