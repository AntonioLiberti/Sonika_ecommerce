<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Carrello" %>
<%@ page import="model.ItemCarrello" %>
<%
    // Recuperiamo il carrello dalla Sessione
    Carrello carrello = (Carrello) session.getAttribute("carrello");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Sonika - Il tuo Carrello</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <header>
        <h1>Sonika - Carrello</h1>
        <nav><a href="${pageContext.request.contextPath}/Home" style="color: white; text-decoration: none;">Torna alla Vetrina</a></nav>
    </header>

    <div class="container" style="margin-top: 30px;">
        <h2>Riepilogo del tuo ordine</h2>
        
        <%
            // Se il carrello non esiste o è vuoto
            if (carrello == null || carrello.getItems().isEmpty()) {
        %>
            <p style="color: #666; font-size: 1.2em;">Il tuo carrello è attualmente vuoto.</p>
        <%
            } else {
        %>
            <!-- Se ci sono prodotti, creiamo la tabella -->
            <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
                <tr style="background-color: #333; color: white; text-align: left;">
                    <th style="padding: 10px;">Prodotto</th>
                    <th style="padding: 10px;">Prezzo Unitario</th>
                    <th style="padding: 10px;">Quantità</th>
                    <th style="padding: 10px;">Totale</th>
                </tr>
                <% 
                    for (ItemCarrello item : carrello.getItems()) { 
                %>
                    <tr style="border-bottom: 1px solid #ccc;">
                        <td style="padding: 10px;">
                            <strong><%= item.getProdotto().getNome() %></strong><br>
                            <span style="font-size: 0.9em; color: #555;"><%= item.getProdotto().getMarca() %></span>
                        </td>
                        <td style="padding: 10px;">€ <%= String.format("%.2f", item.getProdotto().getPrezzoAttuale()) %></td>
                        <td style="padding: 10px;"><%= item.getQuantita() %></td>
                        <td style="padding: 10px; font-weight: bold;">€ <%= String.format("%.2f", item.getPrezzoTotale()) %></td>
                    </tr>
                <% 
                    } 
                %>
            </table>
            
            <!-- Mostriamo il totale generale -->
            <h3 style="text-align: right; margin-top: 20px; color: #CC0000;">
                Totale Carrello: € <%= String.format("%.2f", carrello.getPrezzoTotaleCarrello()) %>
            </h3>
            
            <div style="text-align: right; margin-top: 20px;">
                <button style="background-color: #28a745; color: white; padding: 10px 20px; border: none; cursor: pointer; font-size: 1.1em;">Procedi al Pagamento</button>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>