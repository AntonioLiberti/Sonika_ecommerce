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
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Sonika - Dettaglio Ordine</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <style>
        .detail-container { max-width: 1000px; margin: 40px auto; padding: 0 20px; }
        .detail-header-title { color: #1f2937; margin: 0 0 25px 0; font-size: 24px; }
        .table-wrapper { background: #ffffff; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.03); border: 1px solid #f3f4f6; overflow: hidden; margin-bottom: 30px; }
        .detail-table { width: 100%; border-collapse: collapse; }
        .detail-table th, .detail-table td { padding: 18px 20px; text-align: left; border-bottom: 1px solid #f3f4f6; }
        .detail-table th { background-color: #f9fafb; color: #4b5563; font-weight: 600; text-transform: uppercase; font-size: 13px; letter-spacing: 0.5px; }
        .detail-table td { color: #1f2937; vertical-align: middle; font-size: 15px; }
        .btn-back { background-color: transparent; color: #4b5563; font-weight: 600; text-decoration: none; border: none; cursor: pointer; transition: color 0.2s; font-size: 16px; display: inline-flex; align-items: center; }
        .btn-back:hover { color: #1f2937; }
        .total-section { text-align: right; background: #ffffff; padding: 20px 25px; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.03); border: 1px solid #f3f4f6; }
        .total-price { font-size: 24px; color: #CC0000; margin: 0; font-weight: bold; }
    </style>
</head>
<body style="background-color: #f9fafb; margin: 0; font-family: sans-serif;">
    <header style="background-color: #ffffff; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
        <h1 style="color: #CC0000; margin: 0; font-size: 34px; letter-spacing: -1px; display: flex; align-items: center; transition: transform 0.2s;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">
    <svg width="28" height="28" viewBox="0 0 24 24" fill="#CC0000" xmlns="http://www.w3.org/2000/svg" style="margin-right: 10px;">
        <rect x="3" y="8" width="4" height="8" rx="2" />
        <rect x="10" y="3" width="4" height="18" rx="2" />
        <rect x="17" y="8" width="4" height="8" rx="2" />
    </svg>
    Sonika
 <span style="font-size: 16px; color: #6b7280; font-weight: normal; margin-left: 10px;">| Dettaglio Ordine #<%= idOrdine %></span>
        </h1>
        <div>
            <% if (utenteLoggato != null) { %>
                <span style="color: #333333; font-weight: bold; margin-right: 20px;">Ciao, <%= utenteLoggato.getNome() %></span>
            <% } %>
            <button onclick="history.back()" class="btn-back">&larr; Indietro</button>
        </div>
    </header>
    
    <div class="detail-container">
        <h2 class="detail-header-title">Articoli Acquistati</h2>
        
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
                            <span style="font-size: 13px; color: #6b7280;"><%= p.getMarca() %></span>
                        </td>
                        <td style="font-weight: 500;"><%= d.getQuantitaAcquistata() %></td>
                        <td style="color: #CC0000; font-weight: bold;">€ <%= String.format("%.2f", d.getPrezzoAcquisto()) %></td>
                        <td style="font-weight: bold;">€ <%= String.format("%.2f", d.getPrezzoAcquisto() * d.getQuantitaAcquistata()) %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4" style="text-align: center; padding: 30px; color: #6b7280;">Nessun dettaglio disponibile.</td>
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