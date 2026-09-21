<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Carrello" %>
<%@ page import="model.ItemCarrello" %>
<%
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
            if (carrello == null || carrello.getItems().isEmpty()) {
        %>
            <p style="color: #666; font-size: 1.2em;">Il tuo carrello è attualmente vuoto.</p>
        <%
            } else {
        %>
            <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
                <tr style="background-color: #333; color: white; text-align: left;">
                    <th style="padding: 10px;">Prodotto</th>
                    <th style="padding: 10px;">Prezzo Unitario</th>
                    <th style="padding: 10px;">Quantità</th>
                    <th style="padding: 10px;">Totale</th>
                    <th style="padding: 10px;">Azioni</th>
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
                    
                        <td style="padding: 10px;">
                            <form action="<%= request.getContextPath() %>/CarrelloServlet" method="get" style="display:inline;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="<%= item.getProdotto().getIdProdotto() %>">
                                <input type="number" name="quantita" value="<%= item.getQuantita() %>" min="1" style="width: 50px; padding: 3px;">
                                <button type="submit" style="background-color: #333333; color: white; border: none; padding: 5px; cursor: pointer; border-radius: 3px;">Aggiorna</button>
                            </form>
                        </td>
                        
                        <td style="padding: 10px; font-weight: bold;">€ <%= String.format("%.2f", item.getPrezzoTotale()) %></td>
                        
                        <td style="padding: 10px;">
                            <form action="<%= request.getContextPath() %>/CarrelloServlet" method="get">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="id" value="<%= item.getProdotto().getIdProdotto() %>">
                                <button type="submit" style="background-color: #CC0000; color: white; padding: 5px 10px; border: none; cursor: pointer; border-radius: 3px;">
                                    X Rimuovi
                                </button>
                            </form>
                        </td>
                    </tr>
                <% 
                    } 
                %>
            </table>
            
            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 20px;">
                <form action="<%= request.getContextPath() %>/CarrelloServlet" method="get">
                    <input type="hidden" name="action" value="clear">
                    <button type="submit" style="background-color: #555; color: white; padding: 10px 20px; border: none; cursor: pointer; font-size: 1em;">Svuota Carrello</button>
                </form>
                
                <h3 style="color: #CC0000; margin: 0;">
                    Totale Carrello: € <%= String.format("%.2f", carrello.getPrezzoTotaleCarrello()) %>
                </h3>
            </div>
            
            <form action="<%= request.getContextPath() %>/Checkout" method="get" style="text-align: right; margin-top: 20px;">
                <button type="submit" style="background-color: #333333; color: white; padding: 10px 20px; border: none; cursor: pointer; font-size: 1.1em;">Procedi al Pagamento</button>
            </form>
        <%
            }
        %>
    </div>
</body>
</html>