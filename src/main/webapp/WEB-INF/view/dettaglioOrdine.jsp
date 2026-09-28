<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="model.DettaglioOrdine" %>
<%@ page import="model.Prodotto" %>
<%
    Map<DettaglioOrdine, Prodotto> mappa = (Map<DettaglioOrdine, Prodotto>) request.getAttribute("mappaDettagli");
    Integer idOrdine = (Integer) request.getAttribute("idOrdine");
    Double totale = (Double) request.getAttribute("totaleOrdine");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Sonika - Dettaglio Ordine</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <style>
        .detail-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .detail-table th, .detail-table td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        .detail-table th { background-color: #333333; color: white; }
    </style>
</head>
<body>
    <header style="background-color: #333333; padding: 15px;">
        <h1 style="color: white; margin: 0; display: inline-block;">Dettaglio Ordine #<%= idOrdine %></h1>
        <button onclick="history.back()" style="background-color: #555; color: white; float: right; margin-top: 5px; padding: 8px 15px; border: none; cursor: pointer; font-weight: bold; border-radius: 4px;">Indietro</button>
    </header>
    
    <div class="container" style="display: block; margin-top: 30px;">
        <h2>Articoli Acquistati</h2>
        
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
                    <td><strong><%= p.getNome() %></strong><br><span style="font-size: 0.9em; color: #666;"><%= p.getMarca() %></span></td>
                    <td><%= d.getQuantitaAcquistata() %></td>
                    <td style="color: #CC0000; font-weight: bold;">€ <%= String.format("%.2f", d.getPrezzoAcquisto()) %></td>
                    <td>€ <%= String.format("%.2f", d.getPrezzoAcquisto() * d.getQuantitaAcquistata()) %></td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
        
        <div style="text-align: right; margin-top: 20px;">
            <h3 style="color: #CC0000;">Totale Pagato: € <%= String.format("%.2f", totale) %></h3>
        </div>
    </div>
</body>
</html>