<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="model.DettaglioOrdine" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.Utente" %>
<%
    Map<DettaglioOrdine, Prodotto> mappa = (Map<DettaglioOrdine, Prodotto>) request.getAttribute("mappaDettagli");
    Integer idOrdine = (Integer) request.getAttribute("idOrdine");
    Double totale = (Double) request.getAttribute("totaleOrdine");
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
    String indirizzo = (String) request.getAttribute("indirizzoSpedizione");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sonika - Dettaglio Ordine</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/dettaglioOrdine.css">
</head>
<body class="page-bg">
    <header class="light-header">
        <a href="${pageContext.request.contextPath}/Home" class="logo-link">
            <h1 class="brand-logo">
                <svg width="28" height="28" viewBox="0 0 24 24" fill="#CC0000" xmlns="http://www.w3.org/2000/svg" class="logo-svg">
                    <rect x="3" y="8" width="4" height="8" rx="2" />
                    <rect x="10" y="3" width="4" height="18" rx="2" />
                    <rect x="17" y="8" width="4" height="8" rx="2" />
                </svg>
                Sonika
                <span class="header-subtitle">| Dettaglio Ordine #<%= idOrdine %></span>
            </h1>
        </a>
        <div class="header-nav">
            <% if (utenteLoggato != null) { %>
                <span class="user-greeting">Ciao, <%= utenteLoggato.getNome() %></span>
            <% } %>
            <a href="${pageContext.request.contextPath}/StoricoOrdini" class="btn-back">&larr; Indietro</a>
        </div>
    </header>

    <div class="detail-container">
        <h2 class="detail-header-title">Articoli Acquistati</h2>

        <div class="indirizzo-box">
            <strong>Indirizzo di spedizione:</strong><br>
            <%= indirizzo != null ? indirizzo : "Nessun indirizzo specificato" %>
        </div>

        <div class="table-wrapper">
            <table class="detail-table">
                <thead>
                    <tr>
                        <th>Prodotto</th>
                        <th>Quantità</th>
                        <th>Prezzo Bloccato</th>
                        <th>Subtotale</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (mappa != null && !mappa.isEmpty()) {
                            for (Map.Entry<DettaglioOrdine, Prodotto> entry : mappa.entrySet()) {
                                DettaglioOrdine d = entry.getKey();
                                Prodotto p = entry.getValue();
                    %>
                    <tr>
                        <td>
                            <strong><%= p.getNome() %></strong><br>
                            <span class="prod-brand-text"><%= p.getMarca() %></span>
                        </td>
                        <td class="qty-text"><%= d.getQuantitaAcquistata() %></td>
                        <td class="price-text">€ <%= String.format("%.2f", d.getPrezzoAcquisto()) %></td>
                        <td class="subtotal-text">€ <%= String.format("%.2f", d.getPrezzoAcquisto() * d.getQuantitaAcquistata()) %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4" class="empty-msg">Nessun dettaglio disponibile.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <div class="total-section">
            <p class="total-price">Totale Pagato: € <%= String.format("%.2f", totale) %></p>
        </div>
    </div>
</body>
</html>