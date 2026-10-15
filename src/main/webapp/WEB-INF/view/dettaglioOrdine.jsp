<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="model.DettaglioOrdine" %>
<%@ page import="model.Prodotto" %>

<jsp:include page="header.jsp" />

<div class="container header-centered">
    <div class="checkout-container checkout-wrapper">
        <h2 class="checkout-header-title">Dettaglio Ordine #<%= request.getAttribute("idOrdine") %></h2>

        <div class="indirizzo-box">
            <strong>Indirizzo di Spedizione:</strong><br>
            <%= request.getAttribute("indirizzoSpedizione") != null ? request.getAttribute("indirizzoSpedizione").toString().replace("<", "&lt;").replace(">", "&gt;") : "Non specificato" %>
        </div>

        <table class="table-ordini">
            <thead>
                <tr>
                    <th>Prodotto</th>
                    <th>Prezzo Acquisto</th>
                    <th>Quantità</th>
                    <th>Subtotale</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Map<DettaglioOrdine, Prodotto> mappa = (Map<DettaglioOrdine, Prodotto>) request.getAttribute("mappaDettagli");
                    if (mappa != null && !mappa.isEmpty()) {
                        for (Map.Entry<DettaglioOrdine, Prodotto> entry : mappa.entrySet()) {
                            DettaglioOrdine d = entry.getKey();
                            Prodotto p = entry.getValue();
                            double sub = d.getPrezzoAcquisto() * d.getQuantitaAcquistata();
                %>
                <tr>
                    <td><%= p.getNome().replace("<", "&lt;").replace(">", "&gt;") %></td>
                    <td>€ <%= String.format("%.2f", d.getPrezzoAcquisto()) %></td>
                    <td><%= d.getQuantitaAcquistata() %></td>
                    <td>€ <%= String.format("%.2f", sub) %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr><td colspan="4" class="text-center">Nessun dettaglio trovato.</td></tr>
                <% } %>
            </tbody>
        </table>
        
        <h3 class="totale-ordine">
            Totale: € <%= String.format("%.2f", request.getAttribute("totaleOrdine") != null ? request.getAttribute("totaleOrdine") : 0.0) %>
        </h3>
    </div>
</div>

<jsp:include page="footer.jsp" />