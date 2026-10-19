<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Carrello" %>
<%@ page import="model.ItemCarrello" %>
<%@ page import="model.Utente" %>
<%
    Carrello carrello = (Carrello) session.getAttribute("carrello");
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sonika - Il tuo Carrello</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/carrello.css">
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
                <span class="header-subtitle">| Carrello</span>
            </h1>
        </a>
        <div class="header-nav">
            <% if (utenteLoggato != null) { %>
                <span class="user-greeting">Ciao, <%= utenteLoggato.getNome() %></span>
            <% } %>
            <a href="${pageContext.request.contextPath}/Home" class="nav-link">Torna alla Vetrina</a>
            
            <% if (utenteLoggato != null) { %>
                <a href="${pageContext.request.contextPath}/login?action=logout" class="nav-link logout-link">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/login" class="nav-link">Login / Registrati</a>
            <% } %>
        </div>
    </header>

    <div class="cart-container">
        <div class="cart-header">
            <h2>Il tuo Carrello</h2>
        </div>
        
        <%
            if (carrello == null || carrello.getItems().isEmpty()) {
        %>
            <div class="empty-cart-msg">
                <p>Il tuo carrello è attualmente vuoto.</p>
                <a href="${pageContext.request.contextPath}/Home" class="btn-continue-shopping">Torna alla Vetrina</a>
            </div>
        <% 
            } else {
        %>
            <div class="cart-table-wrapper">
                <table class="cart-table">
                    <thead>
                        <tr>
                            <th>Prodotto</th>
                            <th>Prezzo Unitario</th>
                            <th>Quantità</th>
                            <th>Totale</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            for (ItemCarrello item : carrello.getItems()) { 
                        %>
                            <tr>
                                <td class="product-info">
                                    <strong><%= item.getProdotto().getNome() %></strong>
                                    <span><%= item.getProdotto().getMarca() %></span>
                                </td>
                                <td>€ <%= String.format("%.2f", item.getProdotto().getPrezzoAttuale()) %></td>
                                <td>
                                    <form action="<%= request.getContextPath() %>/CarrelloServlet" method="get" class="qty-form">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="id" value="<%= item.getProdotto().getIdProdotto() %>">
                                        <input type="number" name="quantita" value="<%= item.getQuantita() %>" min="1" class="qty-input">
                                        <button type="submit" class="btn-update">Aggiorna</button>
                                    </form>
                                </td>
                                <td class="cart-total-cell">€ <%= String.format("%.2f", item.getPrezzoTotale()) %></td>
                                <td class="cart-remove-cell">
                                    <form action="<%= request.getContextPath() %>/CarrelloServlet" method="get">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="id" value="<%= item.getProdotto().getIdProdotto() %>">
                                        <button type="submit" class="btn-remove">X Rimuovi</button>
                                    </form>
                                </td>
                            </tr>
                        <% 
                            } 
                        %>
                    </tbody>
                </table>
            </div>
            
            <div class="cart-footer">
                <form action="<%= request.getContextPath() %>/CarrelloServlet" method="get">
                    <input type="hidden" name="action" value="clear">
                    <button type="submit" class="btn-clear">Svuota Carrello</button>
                </form>
                
                <div class="checkout-section">
                    <h3 class="total-price">
                        Totale: € <%= String.format("%.2f", carrello.getPrezzoTotaleCarrello()) %>
                    </h3>
                    <form action="<%= request.getContextPath() %>/Checkout" method="get">
                        <button type="submit" class="btn-checkout">Procedi al Pagamento &rarr;</button>
                    </form>
                </div>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>>